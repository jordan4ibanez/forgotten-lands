-- Lua Library inline imports
local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end
-- End of Lua Library inline imports
builtinEntity = builtinEntity or ({})
do
    local fakeRef = utility.fakeRef
    local timeToLive = tonumber(minetest.settings:get("item_entity_ttl")) or 900
    local gravity = tonumber(minetest.settings:get("movement_gravity")) or -9.81
    local randomRange = utility.randomRange
    local addCollectionSound = (function()
        local playerSoundBuffer = {}
        local deletionQueue = {}
        minetest.register_on_joinplayer(function(player)
            local name = player:get_player_name()
            playerSoundBuffer[name] = 0
        end)
        minetest.register_on_leaveplayer(function(player)
            local name = player:get_player_name()
            __TS__Delete(playerSoundBuffer, name)
        end)
        minetest.register_globalstep(function(delta)
            for ____, ____value in ipairs(__TS__ObjectEntries(playerSoundBuffer)) do
                local name = ____value[1]
                local remaining = ____value[2]
                do
                    if remaining <= 0 then
                        goto __continue7
                    end
                    local player = minetest.get_player_by_name(name)
                    if not player then
                        table.insert(deletionQueue, name)
                        goto __continue7
                    end
                    minetest.sound_play(
                        {name = "item_pickup"},
                        {
                            gain = 0.15,
                            pitch = randomRange(0.7, 1),
                            object = player
                        }
                    )
                    playerSoundBuffer[name] = playerSoundBuffer[name] - 1
                end
                ::__continue7::
            end
            while #deletionQueue > 0 do
                local name = table.remove(deletionQueue)
                if name == nil then
                    break
                end
                __TS__Delete(playerSoundBuffer, name)
            end
        end)
        return function(player)
            local name = player:get_player_name()
            playerSoundBuffer[name] = playerSoundBuffer[name] + 1
        end
    end)()
    builtinEntity.ItemEntity = __TS__Class()
    local ItemEntity = builtinEntity.ItemEntity
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
        self.collector = nil
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
            automatic_rotate = 1,
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
            automatic_rotate = 1,
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
        self.object:set_armor_groups({immortal = 1})
        self.object:set_acceleration(vector.create(0, -gravity, 0))
        self._collisionBox = self.initial_properties.collisionbox
        self:setItem("")
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
        self.object:set_properties({physical = false})
        self.object:set_velocity(vector.create())
        self.object:set_acceleration(vector.create())
    end
    function ItemEntity.prototype.disablePhysicsSilent(self)
        if not self.physicalState then
            return
        end
        self.physicalState = false
        self.object:set_properties({physical = false})
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
        if not node then
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
                    goto __continue42
                end
                if vector.distance2d(pos, playerPos) > 1.5 then
                    goto __continue42
                end
                if playerPos.y - pos.y > 0.05 then
                    goto __continue42
                end
                local inv = player:get_inventory()
                if not inv then
                    goto __continue42
                end
                if not inv:room_for_item("main", self.itemString) then
                    goto __continue42
                end
                inv:add_item("main", self.itemString)
                self:disablePhysicsSilent()
                self.collector = player
                self.age = 0
                self.collected = true
                addCollectionSound(player)
            end
            ::__continue42::
        end
    end
    function ItemEntity.prototype.collectionCleanup(self, delta, pos)
        self.age = self.age + delta
        if not self.collector then
            self.object:remove()
            return
        end
        if not minetest.is_player(self.collector) then
            self.object:remove()
            return
        end
        local goal = self.collector:get_pos()
        if not goal then
            self.object:remove()
            return
        end
        local assistedVelocity = self.collector:get_velocity()
        if not assistedVelocity then
            self.object:remove()
            return
        end
        goal.y = goal.y + 0.8
        local distance = vector.distance(pos, goal)
        if distance <= 0.1 then
            self.object:remove()
            return
        end
        local snappiness = 15
        local speed = distance * snappiness
        local normalized = vector.multiply(
            vector.direction(pos, goal),
            speed
        )
        local finalized = vector.add(normalized, assistedVelocity)
        self.object:set_velocity(finalized)
        if self.age < 0.3 then
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
        local pos = self.object:get_pos()
        if self.collected then
            self:collectionCleanup(delta, pos)
            return
        end
        self:pollPlayers(pos)
        if self:tickAge(delta) then
            return
        end
        local node = minetest.get_node_or_nil(vector.create(pos.x, pos.y + self._collisionBox[3] - 0.05, pos.z))
        if self:checkOutOfBounds(node) then
            return
        end
        if moveResult == nil and self.object:get_attach() then
            return
        end
        if self:forceOutCheck(pos) then
            return
        end
        if not self.physicalState then
            return
        end
        if not moveResult.collides then
            return
        end
        local isStuck = false
        local sNode = minetest.get_node_or_nil(pos)
        if sNode then
            local sDef = minetest.registered_nodes[sNode.name] or ({})
            isStuck = (sDef.walkable == nil or sDef.walkable == true) and (sDef.collision_box == nil or sDef.collision_box.type == "regular") and (sDef.node_box == nil or sDef.node_box.type == "regular")
            self:unstuckSelf(pos, isStuck)
        end
        node = nil
        if moveResult.touching_ground then
            for ____, collision in ipairs(moveResult.collisions) do
                if collision.axis == "y" then
                    node = minetest.get_node(collision.node_pos)
                    break
                end
            end
        end
        local def = node and minetest.registered_nodes[node.name]
        local keepMovement = self:slipCheck(delta, def, node)
        if not keepMovement then
            self.object:set_velocity(vector.create())
        end
        if self.movingState == keepMovement then
            return
        end
        self.movingState = keepMovement
    end
    minetest.registerTSEntity(builtinEntity.ItemEntity)
end
