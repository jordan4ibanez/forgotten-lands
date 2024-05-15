-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
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

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
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

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["306"] = 1,["308"] = 1,["309"] = 1,["310"] = 1,["311"] = 1,["312"] = 7,["313"] = 1,["314"] = 12,["315"] = 13,["316"] = 14,["317"] = 15,["319"] = 11,["320"] = 1,["321"] = 19,["322"] = 19,["323"] = 19,["324"] = 19,["325"] = 19,["326"] = 19,["327"] = 19,["328"] = 1,["329"] = 21,["330"] = 22,["331"] = 23,["332"] = 23,["333"] = 23,["334"] = 24,["335"] = 23,["336"] = 23,["337"] = 26,["338"] = 21,["339"] = 1,["340"] = 31,["341"] = 37,["342"] = 38,["344"] = 39,["345"] = 39,["346"] = 40,["347"] = 41,["348"] = 46,["349"] = 39,["352"] = 49,["353"] = 50,["355"] = 53,["356"] = 29,["357"] = 1,["358"] = 56,["359"] = 57,["360"] = 58,["361"] = 59,["363"] = 60,["364"] = 68,["365"] = 61,["367"] = 62,["369"] = 63,["371"] = 64,["373"] = 65,["375"] = 66,["377"] = 67,["379"] = 68,["380"] = 69,["381"] = 70,["383"] = 72,["386"] = 74,["389"] = 59,["391"] = 78,["392"] = 56,["393"] = 1,["394"] = 82,["395"] = 81,["399"] = 1,["400"] = 90,["401"] = 92,["403"] = 93,["407"] = 95,["408"] = 96,["409"] = 89,["414"] = 1,["415"] = 105,["416"] = 104,["425"] = 1,["426"] = 120,["427"] = 118,["431"] = 1,["432"] = 129,["433"] = 130,["434"] = 131,["435"] = 137,["436"] = 137,["437"] = 137,["438"] = 138,["439"] = 139,["442"] = 142,["443"] = 1,["444"] = 127,["445"] = 147,["449"] = 1,["450"] = 153,["451"] = 152,["452"] = 156,["456"] = 1,["457"] = 162,["458"] = 161,["459"] = 165,["463"] = 1,["464"] = 172,["465"] = 171});
utility = utility or ({})
do
    utility.textureSize = 16
    utility.tickRate = 0.05
    function utility.pixel(inputPixel)
        return inputPixel / utility.textureSize - 0.5
    end
    function utility.loadFiles(filesToLoad)
        local currentMod = minetest.get_current_modname()
        local currentDirectory = minetest.get_modpath(currentMod)
        for ____, file in ipairs(filesToLoad) do
            dofile(((currentDirectory .. "/") .. file) .. ".lua")
        end
    end
    utility.loadFiles({
        "option",
        "math",
        "enums",
        "color_generator",
        "quaternion",
        "vector"
    })
    function utility.concat(...)
        local input = {...}
        local accumulator = ""
        __TS__ArrayForEach(
            input,
            function(____, val)
                accumulator = accumulator .. val
            end
        )
        return accumulator
    end
    function utility.generateSchematic(size, keys, forcePlace, data, ySliceProb)
        local newSchematic = {size = size, data = {}, yslice_prob = {}}
        local length = #data
        local countDown = length
        do
            local i = 1
            while i <= length do
                local databit = string.sub(data, countDown, countDown)
                table.insert(newSchematic.data, {name = keys[databit], force_place = forcePlace[databit] == true})
                countDown = countDown - 1
                i = i + 1
            end
        end
        for ____, databit in ipairs(ySliceProb) do
            table.insert(newSchematic.yslice_prob, {prob = databit})
        end
        return newSchematic
    end
    function utility.println(...)
        local any = {...}
        local builder = ""
        for ____, item in __TS__Iterator(any) do
            builder = builder .. tostring((function()
                repeat
                    local ____switch16 = type(item)
                    local thing
                    local ____cond16 = ____switch16 == "string"
                    if ____cond16 then
                        return item
                    end
                    ____cond16 = ____cond16 or ____switch16 == "number"
                    if ____cond16 then
                        return tostring(item)
                    end
                    ____cond16 = ____cond16 or ____switch16 == "table"
                    if ____cond16 then
                        return dump(item)
                    end
                    ____cond16 = ____cond16 or ____switch16 == "userdata"
                    if ____cond16 then
                        thing = item
                        if thing:is_player() then
                            return thing:get_player_name()
                        end
                        return thing.name
                    end
                    do
                        return "unknown"
                    end
                until true
            end)())
        end
        print(builder)
    end
    function utility.fakeRef()
        return {}
    end
    --- A bolt on to allow you to directly register MT lua entities as TS classes.
    -- 
    -- @param clazz Class definition.
    function utility.registerTSEntity(clazz)
        local instance = __TS__New(clazz)
        if instance.name == nil then
            error(
                __TS__New(Error, "Unable to register entity: Name is null"),
                0
            )
        end
        instance.__index = instance
        minetest.registered_entities[instance.name] = instance
    end
    --- Register a node regardless of it's name.
    -- 
    -- @param nodeName The node name.
    -- @param definition The node definition.
    function utility.registerNode(nodeName, definition)
        minetest.register_node(":" .. nodeName, definition)
    end
    --- Colorize a string to pretty print it to an ANSI terminal.
    -- If your terminal does not support ANSI colors: Oops.
    -- 
    -- @param inputString The string you want to print.
    -- @param r Red channel color. (0 - 255)
    -- @param g Green channel color. (0 - 255)
    -- @param b Blue channel color. (0 - 255)
    -- @returns ANSI Colorized string.
    function utility.terminalColorize(inputString, r, g, b)
        return ((((((("[38;2;" .. tostring(r)) .. ";") .. tostring(g)) .. ";") .. tostring(b)) .. "m") .. inputString) .. "[0m"
    end
    --- Print a warning message instead of an error.
    -- 
    -- @param message The warning message.
    function utility.warning(message)
        local rawText = debug.traceback(message)
        local textArray = __TS__StringSplit(rawText, "\n")
        local accumulator = {}
        for ____, ____value in __TS__Iterator(__TS__ArrayEntries(textArray)) do
            local key = ____value[1]
            local value = ____value[2]
            if key ~= 2 and key ~= 3 then
                accumulator[#accumulator + 1] = value
            end
        end
        local result = "WARNING! " .. table.concat(accumulator, "\n")
        print(utility.terminalColorize(result, 255, 165, 0))
    end
    local register_globalstep = minetest.register_globalstep
    --- Run a function in a global step.
    -- 
    -- @param func Function to be run on global step.
    function utility.onStep(func)
        register_globalstep(func)
    end
    local get_us_time = minetest.get_us_time
    --- Get the US time. Somewhere in the US.
    -- 
    -- @returns The time in the US.
    function utility.getTime()
        return get_us_time()
    end
    local get_connected_players = minetest.get_connected_players
    --- Get all players currently online.
    -- 
    -- @returns Array of players currently online.
    function utility.getPlayers()
        return get_connected_players()
    end
end
