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

local __TS__Match = string.match

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end
-- End of Lua Library inline imports
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["228"] = 2,["230"] = 4,["231"] = 5,["232"] = 6,["233"] = 7,["234"] = 9,["235"] = 10,["236"] = 11,["237"] = 13,["238"] = 14,["239"] = 15,["240"] = 13,["241"] = 18,["242"] = 19,["243"] = 20,["244"] = 18,["245"] = 23,["246"] = 24,["247"] = 24,["248"] = 24,["250"] = 25,["251"] = 25,["253"] = 26,["254"] = 27,["255"] = 28,["256"] = 29,["258"] = 32,["259"] = 32,["260"] = 35,["261"] = 35,["262"] = 35,["263"] = 35,["264"] = 32,["265"] = 32,["266"] = 41,["270"] = 44,["271"] = 45,["272"] = 46,["275"] = 47,["277"] = 23,["278"] = 51,["279"] = 52,["280"] = 53,["281"] = 51,["282"] = 9,["283"] = 2,["284"] = 2,["285"] = 57,["287"] = 58,["288"] = 59,["289"] = 60,["290"] = 61,["291"] = 62,["292"] = 63,["293"] = 64,["294"] = 65,["295"] = 66,["296"] = 67,["297"] = 68,["298"] = 68,["299"] = 68,["300"] = 68,["301"] = 68,["302"] = 68,["303"] = 68,["304"] = 68,["305"] = 70,["306"] = 71,["307"] = 73,["308"] = 73,["309"] = 73,["310"] = 73,["311"] = 77,["312"] = 77,["313"] = 77,["314"] = 77,["315"] = 77,["316"] = 77,["317"] = 77,["318"] = 73,["319"] = 73,["320"] = 73,["321"] = 73,["322"] = 73,["323"] = 73,["324"] = 73,["325"] = 73,["326"] = 57,["327"] = 86,["328"] = 87,["329"] = 88,["330"] = 89,["333"] = 94,["334"] = 95,["335"] = 96,["336"] = 97,["337"] = 100,["338"] = 102,["339"] = 102,["340"] = 102,["341"] = 102,["342"] = 102,["343"] = 102,["344"] = 102,["345"] = 102,["346"] = 104,["347"] = 104,["348"] = 104,["349"] = 104,["350"] = 104,["351"] = 104,["352"] = 104,["353"] = 104,["354"] = 104,["355"] = 104,["356"] = 104,["357"] = 117,["358"] = 86,["359"] = 120,["360"] = 121,["361"] = 120,["362"] = 128,["363"] = 129,["364"] = 129,["365"] = 129,["366"] = 129,["367"] = 129,["368"] = 130,["369"] = 131,["370"] = 132,["371"] = 133,["372"] = 134,["375"] = 137,["377"] = 139,["378"] = 141,["379"] = 142,["380"] = 143,["381"] = 128,["382"] = 146,["383"] = 147,["386"] = 148,["387"] = 149,["388"] = 150,["389"] = 151,["390"] = 146,["391"] = 154,["392"] = 155,["395"] = 156,["396"] = 157,["397"] = 158,["398"] = 159,["399"] = 154,["400"] = 162,["401"] = 163,["404"] = 164,["405"] = 165,["406"] = 162,["407"] = 168,["408"] = 169,["409"] = 170,["410"] = 171,["411"] = 172,["412"] = 173,["414"] = 175,["415"] = 168,["416"] = 178,["417"] = 180,["418"] = 181,["419"] = 182,["420"] = 183,["422"] = 185,["423"] = 178,["424"] = 188,["425"] = 189,["426"] = 189,["428"] = 190,["429"] = 190,["431"] = 191,["432"] = 192,["433"] = 194,["434"] = 196,["435"] = 197,["436"] = 202,["438"] = 204,["439"] = 188,["440"] = 207,["441"] = 208,["442"] = 208,["444"] = 213,["445"] = 214,["446"] = 215,["447"] = 216,["448"] = 222,["449"] = 222,["451"] = 225,["452"] = 226,["453"] = 227,["454"] = 207,["455"] = 230,["456"] = 231,["459"] = 232,["462"] = 234,["464"] = 235,["465"] = 236,["466"] = 236,["468"] = 237,["469"] = 237,["471"] = 238,["472"] = 238,["474"] = 240,["475"] = 241,["476"] = 241,["478"] = 242,["479"] = 242,["481"] = 244,["482"] = 247,["483"] = 248,["484"] = 249,["485"] = 250,["486"] = 251,["490"] = 230,["491"] = 255,["492"] = 259,["493"] = 262,["494"] = 263,["497"] = 266,["498"] = 267,["501"] = 271,["502"] = 272,["503"] = 273,["506"] = 277,["507"] = 278,["508"] = 279,["511"] = 283,["512"] = 287,["513"] = 289,["514"] = 290,["517"] = 294,["518"] = 295,["519"] = 296,["520"] = 296,["521"] = 296,["522"] = 296,["523"] = 297,["524"] = 299,["525"] = 301,["528"] = 302,["529"] = 255,["530"] = 305,["531"] = 306,["534"] = 308,["535"] = 310,["536"] = 310,["537"] = 310,["538"] = 310,["539"] = 310,["540"] = 310,["541"] = 311,["542"] = 312,["543"] = 313,["544"] = 314,["545"] = 315,["548"] = 320,["549"] = 321,["550"] = 322,["551"] = 323,["553"] = 326,["554"] = 308,["555"] = 330,["558"] = 332,["559"] = 333,["560"] = 334,["561"] = 336,["562"] = 337,["563"] = 338,["564"] = 305,["565"] = 342,["566"] = 358,["567"] = 360,["568"] = 361,["571"] = 365,["572"] = 367,["575"] = 369,["576"] = 375,["579"] = 377,["582"] = 379,["585"] = 381,["588"] = 384,["591"] = 386,["592"] = 387,["593"] = 389,["594"] = 390,["595"] = 391,["596"] = 394,["598"] = 397,["599"] = 398,["600"] = 399,["601"] = 400,["602"] = 401,["607"] = 408,["608"] = 409,["609"] = 411,["610"] = 412,["612"] = 416,["615"] = 418,["616"] = 342,["617"] = 2});
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
        utility.onStep(function(delta)
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
        self.forceOut = vector.create3d()
        self.forceOutStart = vector.create3d()
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
        self.object:set_acceleration(vector.create3d(0, -gravity, 0))
        self._collisionBox = self.initial_properties.collisionbox
        self:setItem("")
    end
    function ItemEntity.prototype.enablePhysics(self)
        if self.physicalState then
            return
        end
        self.physicalState = true
        self.object:set_properties({physical = true})
        self.object:set_velocity(vector.create3d())
        self.object:set_acceleration(vector.create3d(0, -gravity, 0))
    end
    function ItemEntity.prototype.disablePhysics(self)
        if not self.physicalState then
            return
        end
        self.physicalState = false
        self.object:set_properties({physical = false})
        self.object:set_velocity(vector.create3d())
        self.object:set_acceleration(vector.create3d())
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
            self.object:set_velocity(vector.create3d(vel.x * (1 - factor), 0, vel.z * (1 - factor)))
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
                vector.create3d(1, 0, 0),
                vector.create3d(-1, 0, 0),
                vector.create3d(0, 0, 1),
                vector.create3d(0, 0, -1)
            }
            for ____, direction in ipairs(order) do
                local cNode = minetest.get_node(vector.add(pos, direction)).name
                local cDef = minetest.registered_nodes[cNode] or nil
                if cNode ~= "ignore" and cDef and cDef.walkable == false then
                    return direction
                end
            end
            local lastTry = vector.create3d(0, 1, 0)
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
        local node = minetest.get_node_or_nil(vector.create3d(pos.x, pos.y + self._collisionBox[3] - 0.05, pos.z))
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
            isStuck = (sDef.walkable == nil or sDef.walkable == true) and (sDef.collision_box == nil or sDef.collision_box.type == Nodeboxtype.regular) and (sDef.node_box == nil or sDef.node_box.type == Nodeboxtype.regular)
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
            self.object:set_velocity(vector.create3d())
        end
        if self.movingState == keepMovement then
            return
        end
        self.movingState = keepMovement
    end
    minetest.registerTSEntity(builtinEntity.ItemEntity)
end
