
namespace builtinEntity {
    // const println = utility.println;
    const fakeRef = utility.fakeRef;
    const timeToLive = tonumber(minetest.settings.get("item_entity_ttl")) || 900;
    const gravity = tonumber(minetest.settings.get("movement_gravity")) || -9.81;
    const randomRange = utility.randomRange;

    const addCollectionSound = (() => {
        const playerSoundBuffer: { [id: string]: number; } = {};
        const deletionQueue: string[] = [];

        minetest.register_on_joinplayer((player: ObjectRef) => {
            const name = player.get_player_name();
            playerSoundBuffer[name] = 0;
        });

        minetest.register_on_leaveplayer((player: ObjectRef) => {
            const name = player.get_player_name();
            delete playerSoundBuffer[name];
        });

        utility.onStep((delta: number) => {
            for (const [name, remaining] of Object.entries(playerSoundBuffer)) {
                if (remaining <= 0) continue;
                const player = minetest.get_player_by_name(name);
                if (!player) {
                    table.insert(deletionQueue, name);
                    continue;
                }

                minetest.sound_play({
                    name: "item_pickup"
                },
                    {
                        gain: 0.15,
                        pitch: randomRange(0.7, 1.0),
                        object: player
                    });

                playerSoundBuffer[name] -= 1;
            }

            while (deletionQueue.length > 0) {
                const name = deletionQueue.pop();
                if (name == null) break;
                delete playerSoundBuffer[name];
            }
        });

        return function (player: ObjectRef) {
            const name = player.get_player_name();
            playerSoundBuffer[name] += 1;
        };
    })();

    export class ItemEntity implements LuaEntity {
        name = "__builtin:item";
        object = fakeRef();
        itemString = "";
        movingState = true;
        physicalState = true;
        age = 0;
        beingForcedOut = false;
        forceOut = vector.create3d();
        forceOutStart = vector.create3d();
        droppedBy = "";
        _collisionBox = [0, 0, 0, 0, 0, 0];
        // Magnet components.
        collected = false;
        collector: ObjectRef | null = null;

        initial_properties = {
            hp_max: 1,
            physical: true,
            collide_with_objects: false,
            collisionbox: [-0.3, -0.3, -0.3, 0.3, 0.3, 0.3],
            visual: EntityVisual.cube,
            visual_size: vector.create2d(),
            automatic_rotate: 1,
            textures: [""],
            is_visible: false,
            pointable: false
        };

        setItem(item: ItemStackObject | string): void {
            const stack = ItemStack(item || this.itemString);
            this.itemString = stack.to_string();
            if (this.itemString == "") {
                // Item is unknown.
                return;
            }

            const itemName: string = (stack.is_known() && stack.get_name()) || "unknown";
            const size = 0.21;
            const def = minetest.registered_items[itemName];
            const glow = def && def.light_source && math.floor(def.light_source / 2 + 0.5);

            // Small random bias to counter Z-fighting.
            const bias = 1e-3 * math.random();

            const c = [-size, -size, -size, size, size, size];

            this.object.set_properties({
                is_visible: true,
                visual: EntityVisual.wielditem,
                textures: [itemName],
                visual_size: vector.create2d(size + bias, size + bias),
                collisionbox: c,
                wield_item: this.itemString,
                automatic_rotate: 1,
                glow: glow,
                infotext: stack.get_description()
            });

            // Cache collisionbox for usage in on_step
            this._collisionBox = c;
        }

        get_staticdata(): string {
            return minetest.serialize({
                itemString: this.itemString,
                age: this.age,
                droppedBy: this.droppedBy
            });
        }

        on_activate(staticData: string, delta: number): void {
            if (string.sub(staticData, 1, string.len("return")) == "return") {
                const data = minetest.deserialize(staticData);
                if (data && type(data) == "table") {
                    this.itemString = data.itemString;
                    this.age = data.age;
                    this.droppedBy = data.droppedBy;
                }
            } else {
                this.itemString = staticData;
            }
            this.object.set_armor_groups({ immortal: 1 });
            // this.object.set_velocity(vector.create(0,2,0))
            this.object.set_acceleration(vector.create3d(0, -gravity, 0));
            this._collisionBox = this.initial_properties.collisionbox;
            this.setItem("");
        }

        enablePhysics(): void {
            if (this.physicalState) return;
            this.physicalState = true;
            this.object.set_properties({ physical: true });
            this.object.set_velocity(vector.create3d());
            this.object.set_acceleration(vector.create3d(0, -gravity, 0));
        }

        disablePhysics(): void {
            if (!this.physicalState) return;
            this.physicalState = false;
            this.object.set_properties({ physical: false });
            this.object.set_velocity(vector.create3d());
            this.object.set_acceleration(vector.create3d());
        }

        disablePhysicsSilent(): void {
            if (!this.physicalState) return;
            this.physicalState = false;
            this.object.set_properties({ physical: false });
        }

        tickAge(delta: number): boolean {
            this.age += delta;
            if (timeToLive > 0 && this.age > timeToLive) {
                this.itemString = "";
                this.object.remove();
                return true;
            }
            return false;
        }

        checkOutOfBounds(node: NodeTable | null): boolean {
            // Delete if in an ignore node.
            if (node && node.name == "ignore") {
                this.itemString = "";
                this.object.remove();
                return true;
            }
            return false;
        }

        slipCheck(delta: number, def: NodeDefinition | null, node: NodeTable | null): boolean {
            if (!def) return false;
            if (!node) return false;
            const slippery = minetest.get_item_group(node.name, "slippery");
            const vel = this.object.get_velocity();
            // todo: check this with math.sign(vel.x) etc
            if (slippery != 0 && (math.abs(vel.x) > 0.1 || math.abs(vel.z))) {
                // Horizontal deceleration.
                const factor = math.min(4 / (slippery + 4) * delta, 1);
                this.object.set_velocity(vector.create3d(
                    vel.x * (1 - factor),
                    0,
                    vel.z * (1 - factor)
                ));
                return true;
            }
            return false;
        }

        forceOutCheck(pos: Vec3): boolean {
            if (!this.beingForcedOut) return false;
            /*
            This code runs after the entity got a push from the isStuck() code.
            It makes sure the entity is entirely outside the solid node.
            */
            const c = this._collisionBox;
            const s = this.forceOutStart;
            const f = this.forceOut;
            const okay = (f.x > 0 && pos.x + c[1] > s.x + 0.5) ||
                (f.y > 0 && pos.y + c[2] > s.y + 0.5) ||
                (f.z > 0 && pos.z + c[3] > s.z + 0.5) ||
                (f.x < 0 && pos.x + c[4] < s.x - 0.5) ||
                (f.z < 0 && pos.z + c[6] < s.z - 0.5);

            if (!okay) return false;

            // Item was successfully forced out.
            this.beingForcedOut = false;
            this.enablePhysics();
            return true;
        }

        pollPlayers(pos: Vec3): void {
            if (this.collected) return;
            if (this.age < 1.5) return;

            for (const player of minetest.get_connected_players()) {
                const playerPos = player.get_pos();
                if (vector.distance(pos, playerPos) > 3) continue;
                if (vector.distance2d(pos, playerPos) > 1.5) continue;
                if (playerPos.y - pos.y > 0.05) continue;

                const inv = player.get_inventory();
                if (!inv) continue;
                if (!inv.room_for_item("main", this.itemString)) continue;

                inv.add_item("main", this.itemString);

                //! fixme: Have a function specifically made to magnetize towards the player because move_to is awful
                this.disablePhysicsSilent();
                this.collector = player;
                this.age = 0;
                this.collected = true;
                addCollectionSound(player);
            }
        }

        collectionCleanup(delta: number, pos: Vec3): void {

            //? Collection animation.

            this.age += delta;

            // A glitch occurred. Extreme safety, had problems with this in previous iterations.
            if (!this.collector) {
                this.object.remove();
                return;
            }
            if (!minetest.is_player(this.collector)) {
                this.object.remove();
                return;
            }

            const goal = this.collector.get_pos();
            if (!goal) {
                this.object.remove();
                return;
            }

            const assistedVelocity = this.collector.get_velocity();
            if (!assistedVelocity) {
                this.object.remove();
                return;
            }

            goal.y += 0.8;

            // Overcomplicated, but smooth.

            const distance = vector.distance(pos, goal);

            if (distance <= 0.1) {
                this.object.remove();
                return;
            }

            const snappiness = 15;
            const speed = distance * snappiness;
            const normalized = vector.multiply(vector.direction(pos, goal), speed);
            const finalized = vector.add(normalized, assistedVelocity);

            this.object.set_velocity(finalized);

            if (this.age < 0.3) return;
            this.object.remove();
        }

        unstuckSelf(pos: Vec3, isStuck: boolean) {
            if (!isStuck) return;

            let shootDir: Vec3 | null = (() => {
                //! fixme: this should be a cached single instance. Why is this getting created every time?
                const order = [vector.create3d(1, 0, 0), vector.create3d(-1, 0, 0), vector.create3d(0, 0, 1), vector.create3d(0, 0, -1),];
                for (const direction of order) {
                    const cNode = minetest.get_node(vector.add(pos, direction)).name;
                    const cDef = minetest.registered_nodes[cNode] || null;
                    if (cNode != "ignore" && cDef && cDef.walkable == false) {
                        return direction;
                    }
                }

                // Iteration failed on X and Z axis, only way left is to go up.
                const lastTry = vector.create3d(0, 1, 0);
                const cNode = minetest.get_node(vector.add(pos, lastTry)).name;
                if (cNode != "ignore") {
                    return lastTry;
                }
                // Everything failed.
                return null;
            })();

            // Everything failed, give up.
            if (!shootDir) return;

            const newVelocity = vector.multiply(shootDir, 3);
            this.disablePhysics();
            this.object.set_velocity(newVelocity);

            this.forceOut = newVelocity;
            this.forceOutStart = vector.round(pos);
            this.beingForcedOut = true;

        }

        on_step(delta: number, moveResult: MoveResult): void {

            //! This is a temporary test to judge how efficient this would be to have a generic item entity attached to a player's hand.
            //todo: probably should get rid of this garbage!

            // const attachments = this.object.get_attach();

            // print(dump(attachments));

            // if (attachments == null) {
            //   this.object.set_attach(minetest.get_player_by_name("singleplayer"), "Arm_Right", vector.create3d(), vector.create3d(), true);
            // }

            //! End test.


            const pos = this.object.get_pos();

            if (this.collected) {
                this.collectionCleanup(delta, pos);
                return;
            }

            this.pollPlayers(pos);

            if (this.tickAge(delta)) return;

            let node = minetest.get_node_or_nil(vector.create3d(
                pos.x,
                pos.y + this._collisionBox[2] - 0.05,
                pos.z
            ));

            if (this.checkOutOfBounds(node)) return;

            if (moveResult == null && this.object.get_attach()) return;

            if (this.forceOutCheck(pos)) return;

            if (!this.physicalState) return;

            // todo: items should probably decelerate in air.
            if (!moveResult.collides) return;

            let isStuck = false;
            const sNode = minetest.get_node_or_nil(pos);

            if (sNode) {
                const sDef = minetest.registered_nodes[sNode.name] || {};
                isStuck = (sDef.walkable == null || sDef.walkable == true) &&
                    (sDef.collision_box == null || sDef.collision_box.type == Nodeboxtype.regular) &&
                    (sDef.node_box == null || sDef.node_box.type == Nodeboxtype.regular);
                this.unstuckSelf(pos, isStuck);
            }

            node = null;
            if (moveResult.touching_ground) {
                for (const collision of moveResult.collisions) {
                    if (collision.axis == "y") {
                        node = minetest.get_node(collision.node_pos);
                        break;
                    }
                }
            }

            // Slide on slippery nodes.
            const def = node && minetest.registered_nodes[node.name];
            const keepMovement = this.slipCheck(delta, def, node);

            if (!keepMovement) {
                this.object.set_velocity(vector.create3d());
            }

            // Do not update anything until the moving state changes.
            if (this.movingState == keepMovement) return;

            this.movingState = keepMovement;
        }
    }


    utility.registerTSEntity(ItemEntity);
}

// {
//   ItemEntity
// }