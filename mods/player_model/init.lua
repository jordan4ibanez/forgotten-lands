-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    Set[Symbol.species] = Set
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["416"] = 1,["418"] = 3,["419"] = 4,["420"] = 5,["421"] = 6,["422"] = 7,["423"] = 8,["424"] = 9,["425"] = 10,["426"] = 12,["427"] = 13,["428"] = 27,["429"] = 27,["430"] = 27,["431"] = 29,["432"] = 29,["433"] = 29,["434"] = 30,["435"] = 30,["436"] = 30,["437"] = 31,["438"] = 31,["439"] = 31,["440"] = 31,["441"] = 30,["442"] = 36,["443"] = 36,["444"] = 36,["445"] = 36,["446"] = 30,["447"] = 30,["448"] = 29,["449"] = 42,["450"] = 42,["451"] = 42,["452"] = 43,["453"] = 43,["454"] = 43,["455"] = 43,["456"] = 42,["457"] = 48,["458"] = 48,["459"] = 48,["460"] = 48,["461"] = 42,["462"] = 42,["463"] = 29,["464"] = 55,["465"] = 55,["466"] = 55,["467"] = 56,["468"] = 56,["469"] = 56,["470"] = 56,["471"] = 55,["472"] = 61,["473"] = 61,["474"] = 61,["475"] = 61,["476"] = 55,["477"] = 55,["478"] = 29,["479"] = 67,["480"] = 67,["481"] = 67,["482"] = 68,["483"] = 68,["484"] = 68,["485"] = 68,["486"] = 67,["487"] = 73,["488"] = 73,["489"] = 73,["490"] = 73,["491"] = 67,["492"] = 67,["493"] = 29,["494"] = 29,["495"] = 27,["496"] = 27,["497"] = 82,["498"] = 82,["499"] = 82,["500"] = 84,["501"] = 84,["502"] = 84,["503"] = 85,["504"] = 85,["505"] = 86,["506"] = 86,["507"] = 86,["508"] = 86,["509"] = 85,["510"] = 91,["511"] = 91,["512"] = 91,["513"] = 91,["514"] = 85,["515"] = 85,["516"] = 84,["517"] = 82,["518"] = 82,["519"] = 100,["520"] = 100,["521"] = 100,["522"] = 100,["523"] = 100,["524"] = 100,["525"] = 100,["526"] = 100,["527"] = 100,["528"] = 100,["529"] = 100,["530"] = 110,["531"] = 111,["532"] = 111,["533"] = 111,["534"] = 111,["535"] = 111,["536"] = 111,["537"] = 110,["538"] = 122,["539"] = 124,["540"] = 125,["541"] = 126,["542"] = 129,["543"] = 131,["544"] = 132,["545"] = 133,["546"] = 134,["548"] = 137,["549"] = 138,["550"] = 139,["551"] = 140,["552"] = 141,["553"] = 142,["556"] = 145,["557"] = 146,["558"] = 147,["559"] = 148,["560"] = 149,["561"] = 150,["562"] = 152,["563"] = 153,["564"] = 154,["567"] = 160,["568"] = 161,["569"] = 161,["570"] = 161,["571"] = 161,["572"] = 161,["574"] = 122});
playerModel = playerModel or ({})
do
    local Quaternion = utility.Quaternion
    local registerAnimation = animationStation.registerAnimation
    local registerBones = animationStation.registerBones
    local setPlayerBoneAnimation = animationStation.setPlayerBoneAnimation
    local setPlayerBoneAnimationSpeed = animationStation.setPlayerBoneAnimationSpeed
    local setPlayerBoneAnimationWithSync = animationStation.setPlayerBoneAnimationWithSync
    local create3d = vector.create3d
    local Keys = _Keys
    local isKeyDown = controls.isKeyDown
    local setPlayerBoneRotation = animationStation.setPlayerBoneRotation
    registerAnimation(
        "character.b3d",
        "walk",
        __TS__New(
            Map,
            {
                {
                    "Arm_Left",
                    {
                        start = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(math.pi / 4, 0, 0),
                            scale = create3d(0, 0, 0)
                        },
                        ["end"] = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(-math.pi / 4, 0, 0),
                            scale = create3d(1, 1, 1)
                        }
                    }
                },
                {
                    "Leg_Right",
                    {
                        start = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(math.pi / 4, 0, 0),
                            scale = create3d(0, 0, 0)
                        },
                        ["end"] = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(-math.pi / 4, 0, 0),
                            scale = create3d(1, 1, 1)
                        }
                    }
                },
                {
                    "Arm_Right",
                    {
                        start = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(-math.pi / 4, 0, 0),
                            scale = create3d(0, 0, 0)
                        },
                        ["end"] = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(math.pi / 4, 0, 0),
                            scale = create3d(1, 1, 1)
                        }
                    }
                },
                {
                    "Leg_Left",
                    {
                        start = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(-math.pi / 4, 0, 0),
                            scale = create3d(0, 0, 0)
                        },
                        ["end"] = {
                            translation = create3d(0, 0, 0),
                            rotation = create3d(math.pi / 4, 0, 0),
                            scale = create3d(1, 1, 1)
                        }
                    }
                }
            }
        )
    )
    registerAnimation(
        "character.b3d",
        "mine",
        __TS__New(
            Map,
            {{
                "Arm_Right",
                {
                    start = {
                        translation = create3d(0, 0, 0),
                        rotation = create3d(math.pi / 2 + math.pi / 4, 0, 0),
                        scale = create3d(0, 0, 0)
                    },
                    ["end"] = {
                        translation = create3d(0, 0, 0),
                        rotation = create3d(math.pi / 2 - math.pi / 4, math.pi / 8, 0),
                        scale = create3d(0, 0, 0)
                    }
                }
            }}
        )
    )
    registerBones(
        "character.b3d",
        __TS__New(Set, {
            "Body",
            "Head",
            "Arm_Left",
            "Arm_Right",
            "Leg_Left",
            "Leg_Right"
        })
    )
    minetest.register_on_joinplayer(function(player)
        player:set_properties({
            mesh = "character.b3d",
            textures = {"character.png"},
            visual = EntityVisual.mesh,
            visual_size = vector.create3d(1, 1, 1)
        })
    end)
    utility.onStep(function(_)
        for ____, player in ipairs(minetest.get_connected_players()) do
            local vel = player:get_velocity()
            local speed = vector.length(vel)
            local diggingTrigger = false
            if isKeyDown(player, Keys.dig) then
                setPlayerBoneAnimation(player, "Arm_Right", "mine")
                setPlayerBoneAnimationSpeed(player, "Arm_Right", 7)
                diggingTrigger = true
            end
            if speed == 0 then
                setPlayerBoneAnimation(player, "Leg_Left", "")
                setPlayerBoneAnimation(player, "Leg_Right", "")
                setPlayerBoneAnimation(player, "Arm_Left", "")
                if not diggingTrigger then
                    setPlayerBoneAnimation(player, "Arm_Right", "")
                end
            else
                setPlayerBoneAnimation(player, "Leg_Left", "walk")
                setPlayerBoneAnimation(player, "Leg_Right", "walk")
                setPlayerBoneAnimation(player, "Arm_Left", "walk")
                setPlayerBoneAnimationSpeed(player, "Leg_Left", speed)
                setPlayerBoneAnimationSpeed(player, "Leg_Right", speed)
                setPlayerBoneAnimationSpeed(player, "Arm_Left", speed)
                if not diggingTrigger then
                    setPlayerBoneAnimationWithSync(player, "Arm_Right", "walk", "Leg_Right")
                    setPlayerBoneAnimationSpeed(player, "Arm_Right", speed)
                end
            end
            local lookDir = player:get_look_vertical()
            setPlayerBoneRotation(
                player,
                "Head",
                create3d(-lookDir, 0, 0)
            )
        end
    end)
end
