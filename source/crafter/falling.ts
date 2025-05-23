namespace main {
	// local
	// minetest,vector,table,pairs,type,math
	// =
	// minetest,vector,table,pairs,type,math

	//
	// Falling entity rewrite.
	//

	// local param_translation = {
	// 	[0] = 0,
	// 	[3] = math.pi/2,
	// 	[2] = math.pi,
	// 	[1] = math.pi*1.5,
	// }

	const facedir_to_euler: { x: number; y: number; z: number }[] = [
		{ y: 0, x: 0, z: 0 },
		{ y: -math.pi / 2, x: 0, z: 0 },
		{ y: math.pi, x: 0, z: 0 },
		{ y: math.pi / 2, x: 0, z: 0 },
		{ y: math.pi / 2, x: -math.pi / 2, z: math.pi / 2 },
		{ y: math.pi / 2, x: math.pi, z: math.pi / 2 },
		{ y: math.pi / 2, x: math.pi / 2, z: math.pi / 2 },
		{ y: math.pi / 2, x: 0, z: math.pi / 2 },
		{ y: -math.pi / 2, x: math.pi / 2, z: math.pi / 2 },
		{ y: -math.pi / 2, x: 0, z: math.pi / 2 },
		{ y: -math.pi / 2, x: -math.pi / 2, z: math.pi / 2 },
		{ y: -math.pi / 2, x: math.pi, z: math.pi / 2 },
		{ y: 0, x: 0, z: math.pi / 2 },
		{ y: 0, x: -math.pi / 2, z: math.pi / 2 },
		{ y: 0, x: math.pi, z: math.pi / 2 },
		{ y: 0, x: math.pi / 2, z: math.pi / 2 },
		{ y: math.pi, x: math.pi, z: math.pi / 2 },
		{ y: math.pi, x: math.pi / 2, z: math.pi / 2 },
		{ y: math.pi, x: 0, z: math.pi / 2 },
		{ y: math.pi, x: -math.pi / 2, z: math.pi / 2 },
		{ y: math.pi, x: math.pi, z: 0 },
		{ y: -math.pi / 2, x: math.pi, z: 0 },
		{ y: 0, x: math.pi, z: 0 },
		{ y: math.pi / 2, x: math.pi, z: 0 },
	];

	class FallingNode extends types.Entity {
		override name: string = ":__builtin:falling_node";
		initial_properties = {
			visual: EntityVisual.wielditem,
			visual_size: { x: 0.667, y: 0.667 },
			textures: [],
			physical: true,
			is_visible: false,
			collide_with_objects: false,
			collisionbox: [-0.5, -0.5, -0.5, 0.5, 0.5, 0.5],
		};

		node: MapNode = {
			name: "",
			prob: 3,
			param2: 0,
			force_place: false,
			level: 0,
		};
		meta?: MetaData;
		floats: boolean = false;
		liquidtype?: LiquidType;

		set_node(node: MapNode, metadata?: MetaRef | MetaData): void {
			node.param2 = node.param2 || 0;

			this.node = node;

			let meta: MetaRef | MetaData = {} as MetaRef;

			if (
				(meta as MetaRef).to_table &&
				type((meta as MetaRef).to_table) == "function"
			) {
				const attempt = (meta as MetaRef).to_table();
				if (attempt) {
					meta = attempt;
				}
			}

			// This was transformed in the previous statement, I think?
			meta = meta as MetaData;

			for (let [_, list] of pairs(meta.inventory || {})) {
				for (let [i, stack] of pairs(list)) {
					if (type(stack) == "userdata") {
						list[i as number] = (
							stack as ItemStackObject
						).to_string();
					}
				}
			}

			const def: NodeDefinition | null = core.registered_nodes[node.name];

			if (!def) {
				// Don't allow unknown nodes to fall.
				core.log(
					LogLevel.error,
					"Unknown falling node removed at " +
						core.pos_to_string(this.object.get_pos())
				);
				this.object.remove();
				return;
			}

			this.meta = meta;

			// Cache whether we're supposed to float on water.
			this.floats = core.get_item_group(node.name, "float") != 0;

			// -- Save liquidtype for falling water
			this.liquidtype = def.liquidtype;

			// Set up entity visuals.
			// For compatibility with older clients we continue to use "item" visual
			// for simple situations.

			const drawtypes: { [id: string]: boolean } = {
				normal: true,
				glasslike: true,
				allfaces: true,
				nodebox: true,
			};

			const p2types: { [id: string]: boolean } = {
				none: true,
				facedir: true,
				"4dir": true,
			};

			if (
				def.drawtype &&
				drawtypes[def.drawtype] &&
				def.paramtype2 &&
				p2types[def.paramtype2] &&
				def.use_texture_alpha != TextureAlpha.blend
			) {
				// Calculate size of falling node.
				const s: Vec3 = vector.zero();
				s.x = (def.visual_scale || 1) * 0.667;
				s.y = s.x;
				s.z = s.x;
				// Compensate for wield_scale.
				if (def.wield_scale) {
					s.x = s.x / def.wield_scale.x;
					s.y = s.y / def.wield_scale.y;
					s.z = s.z / def.wield_scale.z;
				}
				this.object.set_properties({
					is_visible: true,
					visual: EntityVisual.item,
					wield_item: node.name,
					visual_size: s,
					glow: def.light_source,
				});
				// Rotate as needed.
				if (def.paramtype2 == ParamType2.facedir) {
					const fdir: number = (node.param2 % 32) % 24;
					const euler: Vec3 | null = facedir_to_euler[
						fdir + 1
					] as Vec3;
					if (euler != null) {
						this.object.set_rotation(euler);
					}
				} else if (def.paramtype2 == ParamType2["4dir"]) {
					const fdir: number = node.param2 % 4;
					const euler: Vec3 | null = facedir_to_euler[
						fdir + 1
					] as Vec3;
					if (euler != null) {
						this.object.set_rotation(euler);
					}
				}
			} else if (def.drawtype != Drawtype.airlike) {
				this.object.set_properties({
					is_visible: true,
					node: node,
					glow: def.light_source,
				});
			}

			// Set collision box (certain nodeboxes only for now).
			const nb_types: { [id: string]: boolean } = {
				fixed: true,
				leveled: true,
				connected: true,
			};

			if (
				def.drawtype == Drawtype.nodebox &&
				def.node_box &&
				nb_types[def.node_box.type] &&
				def.node_box.fixed
			) {
				let box: number | number[] | number[][] | null =
					def.node_box.fixed.slice();

				if (box && type(box[1]) == "table") {
					box = (box.length == 1 && box[1]) || null; // We can only use a single box.
				}

				if (box != null) {
					box = box as number[];
					if (
						def.paramtype2 == ParamType2.leveled &&
						(this.node.level || 0) > 0
					) {
						box[5] = -0.5 + this.node.level / 64;
					}
					this.object.set_properties({
						collisionbox: box,
					});
				}
			}
		}

		get_staticdata(): string {
			const ds = {
				node: this.node,
				meta: this.meta,
			};
			return core.serialize(ds);
		}

		on_activate(staticdata: string) {
			print("hi");
			this.object.set_armor_groups({ immortal: 1 });

			// Lua unsafety just kinda unravels here.
			const ds: any = core.deserialize(staticdata);

			if (ds && ds.node) {
				this.set_node(ds.node, ds.meta);
			} else if (ds) {
				this.set_node(ds);
			} else if (staticdata != "") {
				this.set_node({ name: staticdata } as MapNode);
			}
		}

		on_step(dtime: number) {
			// print("hi");
			// 	-- Set gravity
			// 	local acceleration = self.object:get_acceleration()
			// 	if not vector.equals(acceleration, {x = 0, y = -10, z = 0}) then
			// 		self.object:set_acceleration({x = 0, y = -10, z = 0})
			// 	end
			// 	-- Turn to actual node when colliding with ground, or continue to move
			// 	local pos = self.object:get_pos()
			// 	-- Position of bottom center point
			// 	local bcp = {x = pos.x, y = pos.y - 0.7, z = pos.z}
			// 	-- 'bcn' is nil for unloaded nodes
			// 	local bcn = minetest.get_node_or_nil(bcp)
			// 	-- Delete on contact with ignore at world edges
			// 	if bcn and bcn.name == "ignore" then
			// 		self.object:remove()
			// 		return
			// 	end
			// 	local bcd = bcn and minetest.registered_nodes[bcn.name]
			// 	if bcn and
			// 			(not bcd or bcd.walkable or
			// 			(minetest.get_item_group(self.node.name, "float") ~= 0 and
			// 			bcd.liquidtype ~= "none")) then
			// 		if bcd and bcd.leveled and
			// 				bcn.name == self.node.name then
			// 			local addlevel = self.node.level
			// 			if not addlevel or addlevel <= 0 then
			// 				addlevel = bcd.leveled
			// 			end
			// 			if minetest.add_node_level(bcp, addlevel) == 0 then
			// 				self.object:remove()
			// 				return
			// 			end
			// 		elseif bcd and bcd.buildable_to and
			// 				(minetest.get_item_group(self.node.name, "float") == 0 or
			// 				bcd.liquidtype == "none") then
			// 			minetest.remove_node(bcp)
			// 			return
			// 		end
			// 		local np = {x = bcp.x, y = bcp.y + 1, z = bcp.z}
			// 		-- Check what's here
			// 		local n2 = minetest.get_node(np)
			// 		local nd = minetest.registered_nodes[n2.name]
			// 		-- If it's not air or liquid, remove node and replace it with
			// 		-- it's drops
			// 		if n2.name ~= "air" and (not nd or nd.liquidtype == "none") then
			// 			local drops = minetest.get_node_drops(self.node.name, "")
			// 			if drops and table.getn(drops) > 0 then
			// 				for _,droppy in pairs(drops) do
			// 					minetest.throw_item(np,droppy)
			// 				end
			// 			else
			// 				minetest.throw_item(np,self.node)
			// 			end
			// 			self.object:remove()
			// 			return
			// 		end
			// 		-- Create node and remove entity
			// 		local def = minetest.registered_nodes[self.node.name]
			// 		if def then
			// 			minetest.add_node(np, self.node)
			// 			if self.meta then
			// 				local meta = minetest.get_meta(np)
			// 				meta:from_table(self.meta)
			// 			end
			// 			if def.sounds and def.sounds.fall then
			// 				minetest.sound_play(def.sounds.fall, {pos = np}, true)
			// 			end
			// 		end
			// 		self.object:remove()
			// 		minetest.check_for_falling(np)
			// 		return
			// 	end
			// 	local vel = self.object:get_velocity()
			// 	if vector.equals(vel, {x = 0, y = 0, z = 0}) then
			// 		local npos = self.object:get_pos()
			// 		self.object:set_pos(vector.round(npos))
			// 	end
		}
	}

	utility.registerTSEntity(FallingNode);

	core.register_on_joinplayer((player: ObjectRef) => {
		const pos = player.get_pos();
		pos.y += 5;

		core.set_node(pos, { name: "crafter:dirt" });
		core.spawn_falling_node(pos);
	});
}
