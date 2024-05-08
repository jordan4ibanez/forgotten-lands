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

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["295"] = 1,["297"] = 3,["298"] = 4,["299"] = 6,["300"] = 7,["307"] = 20,["308"] = 20,["310"] = 34,["311"] = 35,["312"] = 36,["313"] = 37,["314"] = 38,["315"] = 39,["316"] = 40,["317"] = 41,["318"] = 42,["319"] = 43,["320"] = 44,["321"] = 45,["322"] = 46,["323"] = 33,["324"] = 50,["325"] = 50,["327"] = 51,["328"] = 52,["329"] = 53,["330"] = 54,["331"] = 55,["332"] = 56,["333"] = 57,["334"] = 58,["335"] = 59,["336"] = 60,["337"] = 61,["338"] = 62,["339"] = 50,["340"] = 69,["341"] = 71,["342"] = 72,["343"] = 72,["344"] = 72,["345"] = 73,["347"] = 75,["348"] = 69,["349"] = 78,["350"] = 79,["351"] = 81,["352"] = 82,["353"] = 83,["358"] = 1,["359"] = 92,["360"] = 93,["361"] = 94,["362"] = 95,["364"] = 97,["366"] = 90,["371"] = 1,["372"] = 108,["373"] = 109,["374"] = 110,["375"] = 111,["377"] = 113,["379"] = 106,["384"] = 1,["385"] = 124,["386"] = 125,["387"] = 126,["388"] = 127,["390"] = 129,["392"] = 122,["393"] = 135,["394"] = 136,["395"] = 137,["396"] = 137,["397"] = 137,["398"] = 137,["399"] = 138,["400"] = 138,["401"] = 138,["402"] = 138,["403"] = 135,["404"] = 141,["405"] = 142,["406"] = 143,["407"] = 144,["408"] = 144,["409"] = 144,["410"] = 144,["411"] = 141,["417"] = 1,["418"] = 168,["419"] = 169,["420"] = 170,["421"] = 171,["422"] = 172,["423"] = 172,["424"] = 172,["425"] = 172,["426"] = 173,["428"] = 175,["429"] = 167,["435"] = 1,["436"] = 185,["437"] = 186,["438"] = 187,["439"] = 188,["440"] = 189,["441"] = 189,["442"] = 189,["443"] = 189,["444"] = 190,["446"] = 192,["447"] = 193,["448"] = 194,["451"] = 197,["452"] = 184,["453"] = 202,["454"] = 204,["455"] = 206,["456"] = 208,["457"] = 210,["458"] = 211,["459"] = 212,["460"] = 212,["461"] = 212,["462"] = 212,["465"] = 216,["466"] = 218,["467"] = 219,["468"] = 220,["469"] = 220,["470"] = 220,["471"] = 220,["474"] = 224,["475"] = 227,["476"] = 227,["477"] = 227,["478"] = 229,["479"] = 231,["480"] = 232,["481"] = 233,["483"] = 235,["484"] = 237,["485"] = 238,["486"] = 239,["487"] = 240,["489"] = 243,["490"] = 244,["492"] = 247,["494"] = 249,["495"] = 250,["496"] = 251,["498"] = 254,["499"] = 255,["501"] = 259,["504"] = 264,["505"] = 266,["506"] = 267,["507"] = 268,["509"] = 270,["510"] = 272,["511"] = 273,["512"] = 274,["514"] = 276,["515"] = 277,["518"] = 280,["520"] = 202,["521"] = 285,["522"] = 286,["523"] = 287,["525"] = 285});
controls = controls or ({})
do
    local warning = utility.warning
    local getTime = utility.getTime
    local Keys = _Keys
    local getPlayers = utility.getPlayers
    --- This was basically translated from this:
    -- https://github.com/mt-mods/controls
    -- 
    -- But we're going to give it a little TypeScript twist.
    -- 
    -- This is written out verbosely so no mistakes are made.
    local InputTimer = __TS__Class()
    InputTimer.name = "InputTimer"
    function InputTimer.prototype.____constructor(self)
        local currentTime = getTime()
        self.up = currentTime
        self.down = currentTime
        self.left = currentTime
        self.right = currentTime
        self.jump = currentTime
        self.aux1 = currentTime
        self.sneak = currentTime
        self.dig = currentTime
        self.place = currentTime
        self.LMB = currentTime
        self.RMB = currentTime
        self.zoom = currentTime
    end
    local PlayerControls = __TS__Class()
    PlayerControls.name = "PlayerControls"
    function PlayerControls.prototype.____constructor(self)
        self.up = false
        self.down = false
        self.left = false
        self.right = false
        self.jump = false
        self.aux1 = false
        self.sneak = false
        self.dig = false
        self.place = false
        self.LMB = false
        self.RMB = false
        self.zoom = false
    end
    local function generateKeyedMap()
        local map = __TS__New(Map)
        for ____, ____value in ipairs(__TS__ObjectEntries(__TS__New(PlayerControls))) do
            local key = ____value[1]
            local _ = ____value[2]
            map:set(key, {})
        end
        return map
    end
    local keysRepository = __TS__New(Map)
    local timeRepository = __TS__New(Map)
    local onPress = generateKeyedMap()
    local onHold = generateKeyedMap()
    local onRelease = generateKeyedMap()
    --- Register an on press callback for keys.
    -- 
    -- @param keys The keys in which you want your callback to run for.
    -- @param callback The callback.
    function controls.registerOnPress(keys, callback)
        for ____, key in ipairs(keys) do
            local funcArray = onPress:get(key)
            if funcArray == nil then
                error(("Tried to assign [on press] to key [" .. key) .. "] which doesn't exist.")
            end
            funcArray[#funcArray + 1] = callback
        end
    end
    --- Register an on press callback for keys.
    -- 
    -- @param keys The keys in which you want your callback to run for.
    -- @param callback The callback
    function controls.registerOnHold(keys, callback)
        for ____, key in ipairs(keys) do
            local funcArray = onHold:get(key)
            if funcArray == nil then
                error(("Tried to assign [on hold] to key [" .. key) .. "] which doesn't exist.")
            end
            funcArray[#funcArray + 1] = callback
        end
    end
    --- Register an on release callback for keys.
    -- 
    -- @param keys The keys in which you want your callback to run for.
    -- @param callback The callback.
    function controls.registerOnRelease(keys, callback)
        for ____, key in ipairs(keys) do
            local funcArray = onRelease:get(key)
            if funcArray == nil then
                error(("Tried to assign [on release] to key [" .. key) .. "] which doesn't exist.")
            end
            funcArray[#funcArray + 1] = callback
        end
    end
    minetest.register_on_joinplayer(function(player)
        local name = player:get_player_name()
        keysRepository:set(
            name,
            __TS__New(PlayerControls)
        )
        timeRepository:set(
            name,
            __TS__New(InputTimer)
        )
    end)
    minetest.register_on_leaveplayer(function(player)
        local name = player:get_player_name()
        keysRepository:delete(name)
        timeRepository:set(
            name,
            __TS__New(InputTimer)
        )
    end)
    --- Get if a key is down.
    -- 
    -- @param player The player.
    -- @param key The key.
    -- @returns If they key is down.
    function controls.isKeyDown(player, key)
        local name = player:get_player_name()
        local controlState = keysRepository:get(name)
        if controlState == nil then
            warning("Player control state did not exist. Creating and aborting.")
            keysRepository:set(
                name,
                __TS__New(PlayerControls)
            )
            return false
        end
        return controlState[key]
    end
    --- Get if any of a group of keys are down. Only one needs to be down to trigger true.
    -- 
    -- @param player The player.
    -- @param keys The array of possible keys.
    -- @returns True if any of them are down, false if none.
    function controls.areKeysDown(player, keys)
        local name = player:get_player_name()
        local controlState = keysRepository:get(name)
        if controlState == nil then
            warning("Player control state did not exist. Creating and aborting.")
            keysRepository:set(
                name,
                __TS__New(PlayerControls)
            )
            return false
        end
        for ____, key in ipairs(keys) do
            if controlState[key] then
                return true
            end
        end
        return false
    end
    local function pollPlayerControls(player)
        local name = player:get_player_name()
        local playerControl = player:get_player_control()
        local controlState = keysRepository:get(name)
        if controlState == nil then
            warning("Player control state did not exist. Creating and aborting.")
            keysRepository:set(
                name,
                __TS__New(PlayerControls)
            )
            return
        end
        local timeState = timeRepository:get(name)
        if timeState == nil then
            warning("Player time state did not exist. Creating and aborting.")
            timeRepository:set(
                name,
                __TS__New(InputTimer)
            )
            return
        end
        local currentTime = getTime()
        for ____, ____value in ipairs(__TS__ObjectEntries(playerControl)) do
            local key = ____value[1]
            local value = ____value[2]
            if controlState[key] ~= value then
                local startTime = timeState[key]
                if startTime == nil then
                    error((("Null start time for key " .. key) .. " for player ") .. name)
                end
                local elapsedTime = (currentTime - startTime) / 1000000
                if value == true then
                    local callbacks = onPress:get(key)
                    if callbacks == nil then
                        error("Something went horribly wrong with the onPress " .. key)
                    end
                    for ____, callback in ipairs(callbacks) do
                        callback(player, elapsedTime)
                    end
                    timeState[key] = currentTime
                else
                    local callbacks = onRelease:get(key)
                    if callbacks == nil then
                        error("Something went horribly wrong with the onRelease " .. key)
                    end
                    for ____, callback in ipairs(callbacks) do
                        callback(player, elapsedTime)
                    end
                    timeState[key] = currentTime
                end
            end
            if value == true then
                local startTime = timeState[key]
                if startTime == nil then
                    error((("Null start time for key " .. key) .. " for player ") .. name)
                end
                local elapsedTime = (currentTime - startTime) / 1000000
                local callbacks = onHold:get(key)
                if callbacks == nil then
                    error("Something went horribly wrong with the onHold " .. key)
                end
                for ____, callback in ipairs(callbacks) do
                    callback(player, elapsedTime)
                end
            end
            controlState[key] = value
        end
    end
    utility.onStep(function()
        for ____, player in ipairs(getPlayers()) do
            pollPlayerControls(player)
        end
    end)
end
