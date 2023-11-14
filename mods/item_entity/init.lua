-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
-- End of Lua Library inline imports
do
    local println = utility.println
    local fakeRef = utility.fakeRef
    local timeToLive = tonumber(minetest.settings:get("item_entity_ttl")) or 900
    local gravity = tonumber(minetest.settings:get("movement_gravity")) or -9.81
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = "__builtin:item"
        self.object = fakeRef()
        self.itemString = ""
        self.movingState = true
        self.physicalState = true
        self.age = 0
        self.beingForcedOut = false
        self.forceOut = vector.create()
        self.forceOutStart = vector.create()
        self.droppedBy = ""
        self._collisionBox = {
            0,
            0,
            0,
            0,
            0,
            0
        }
        self.collected = false
        self.initial_properties = {
            hp_max = 1,
            physical = true,
            collide_with_objects = false,
            collisionbox = {
                -0.3,
                -0.3,
                -0.3,
                0.3,
                0.3,
                0.3
            },
            visual = EntityVisual.cube,
            visual_size = vector.create2d(),
            textures = {""},
            is_visible = false,
            pointable = false
        }
    end
    function ItemEntity.prototype.setItem(self, item)
        local stack = ItemStack(item or self.itemString)
        self.itemString = stack:to_string()
        if self.itemString == "" then
            return
        end
        local itemName = stack:is_known() and stack:get_name() or "unknown"
        local size = 0.21
        local def = minetest.registered_items[itemName]
        local glow = def and def.light_source and math.floor(def.light_source / 2 + 0.5)
        local bias = 0.001 * math.random()
        local c = {
            -size,
            -size,
            -size,
            size,
            size,
            size
        }
        self.object:set_properties({
            is_visible = true,
            visual = EntityVisual.wielditem,
            textures = {itemName},
            visual_size = vector.create2d(size + bias, size + bias),
            collisionbox = c,
            wield_item = self.itemString,
            glow = glow,
            infotext = stack:get_description()
        })
        self._collisionBox = c
    end
    function ItemEntity.prototype.get_staticdata(self)
        return minetest.serialize({itemString = self.itemString, age = self.age, droppedBy = self.droppedBy})
    end
    function ItemEntity.prototype.on_activate(self, staticData, delta)
        if string.sub(
            staticData,
            1,
            string.len("return")
        ) == "return" then
            local data = minetest.deserialize(staticData)
            if data and type(data) == "table" then
                self.itemString = data.itemString
                self.age = data.age
                self.droppedBy = data.droppedBy
            end
        else
            self.itemString = staticData
        end
    end
    function ItemEntity.prototype.enablePhysics(self)
        if self.physicalState then
            return
        end
        self.physicalState = true
        self.object:set_properties({physical = true})
        self.object:set_velocity(vector.create())
        self.object:set_acceleration(vector.create(0, -gravity, 0))
    end
    function ItemEntity.prototype.disablePhysics(self)
        if not self.physicalState then
            return
        end
        self.physicalState = false
        self.object:set_properties({physical = true})
        self.object:set_velocity(vector.create())
        local ____ = self.object.set_acceleration
    end
    function ItemEntity.prototype.tickAge(self, delta)
        self.age = self.age + delta
        if timeToLive > 0 and self.age > timeToLive then
            self.itemString = ""
            self.object:remove()
            return true
        end
        return false
    end
    function ItemEntity.prototype.checkOutOfBounds(self, node)
        if node and node.name == "ignore" then
            self.itemString = ""
            self.object:remove()
            return true
        end
        return false
    end
    function ItemEntity.prototype.slipCheck(self, delta, def, node)
        if not def then
            return false
        end
        local slippery = minetest.get_item_group(node.name, "slippery")
        local vel = self.object:get_velocity()
        if slippery ~= 0 and (math.abs(vel.x) > 0.1 or math.abs(vel.z)) then
            local factor = math.min(4 / (slippery + 4) * delta, 1)
            self.object:set_velocity(vector.create(vel.x * (1 - factor), 0, vel.z * (1 - factor)))
            return true
        end
        return false
    end
    function ItemEntity.prototype.forceOutCheck(self, pos)
        if not self.beingForcedOut then
            return false
        end
        local c = self._collisionBox
        local s = self.forceOutStart
        local f = self.forceOut
        local okay = f.x > 0 and pos.x + c[2] > s.x + 0.5 or f.y > 0 and pos.y + c[3] > s.y + 0.5 or f.z > 0 and pos.z + c[4] > s.z + 0.5 or f.x < 0 and pos.x + c[5] < s.x - 0.5 or f.z < 0 and pos.z + c[7] < s.z - 0.5
        if not okay then
            return false
        end
        self.beingForcedOut = false
        self:enablePhysics()
        return true
    end
    function ItemEntity.prototype.pollPlayers(self, pos)
        if self.collected then
            return
        end
        if self.age < 1.5 then
            return
        end
        for ____, player in ipairs(minetest.get_connected_players()) do
            do
                local playerPos = player:get_pos()
                if vector.distance(pos, playerPos) > 3 then
                    goto __continue28
                end
                if vector.distance2d(pos, playerPos) > 1.5 then
                    goto __continue28
                end
                if playerPos.y - pos.y > 0.05 then
                    goto __continue28
                end
                local inv = player:get_inventory()
                if not inv then
                    goto __continue28
                end
                if not inv:room_for_item("main", self.itemString) then
                    goto __continue28
                end
                inv:add_item("main", self.itemString)
                self:disablePhysics()
                self.object:move_to(playerPos, true)
                self.age = 0
                self.collected = true
                addMagnetPop(player)
            end
            ::__continue28::
        end
    end
    function ItemEntity.prototype.collectionCleanup(self, delta)
        self.age = self.age + delta
        if self.age < 0.2 then
            return
        end
        self.object:remove()
    end
    function ItemEntity.prototype.unstuckSelf(self, pos, isStuck)
        if not isStuck then
            return
        end
        local shootDir = (function()
            local order = {
                vector.create(1, 0, 0),
                vector.create(-1, 0, 0),
                vector.create(0, 0, 1),
                vector.create(0, 0, -1)
            }
            for ____, direction in ipairs(order) do
                local cNode = minetest.get_node(vector.add(pos, direction)).name
                local cDef = minetest.registered_nodes[cNode] or nil
                if cNode ~= "ignore" and cDef and cDef.walkable == false then
                    return direction
                end
            end
            local lastTry = vector.create(0, 1, 0)
            local cNode = minetest.get_node(vector.add(pos, lastTry)).name
            if cNode ~= "ignore" then
                return lastTry
            end
            return nil
        end)()
        if not shootDir then
            return
        end
        local newVelocity = vector.multiply(shootDir, 3)
        self:disablePhysics()
        self.object:set_velocity(newVelocity)
        self.forceOut = newVelocity
        self.forceOutStart = vector.round(pos)
        self.beingForcedOut = true
    end
    function ItemEntity.prototype.on_step(self, delta, moveResult)
    end
    minetest.registerTSEntity(ItemEntity)
end
