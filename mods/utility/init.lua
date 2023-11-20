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
-- End of Lua Library inline imports
utility = utility or ({})
do
    function utility.loadFiles(filesToLoad)
        local currentMod = minetest.get_current_modname()
        local currentDirectory = minetest.get_modpath(currentMod)
        for ____, file in ipairs(filesToLoad) do
            dofile(((currentDirectory .. "/") .. file) .. ".lua")
        end
    end
    utility.loadFiles({"enums", "color_generator"})
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
                    local ____switch15 = type(item)
                    local thing
                    local ____cond15 = ____switch15 == "string"
                    if ____cond15 then
                        return item
                    end
                    ____cond15 = ____cond15 or ____switch15 == "number"
                    if ____cond15 then
                        return tostring(item)
                    end
                    ____cond15 = ____cond15 or ____switch15 == "table"
                    if ____cond15 then
                        return dump(item)
                    end
                    ____cond15 = ____cond15 or ____switch15 == "userdata"
                    if ____cond15 then
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
    function utility.randomRange(min, max)
        return math.random() * (max - min) + min
    end
    function utility.fakeRef()
        return {}
    end
    local rr = utility.randomRange
    vector.create = function(x, y, z)
        local temp = vector.zero()
        temp.x = x or 0
        temp.y = y or 0
        temp.z = z or 0
        return temp
    end
    vector.create2d = function(x, y)
        local temp = {x = x or 0, y = y or 0}
        return temp
    end
    local create = vector.create
    vector.random = function(minX, maxX, minY, maxY, minZ, maxZ)
        return create(
            rr(minX, maxX),
            rr(minY, maxY),
            rr(minZ, maxZ)
        )
    end
    vector.distance2d = (function()
        local vecA = vector.create()
        local vecB = vector.create()
        return function(vec1, vec2)
            vecA.x = vec1.x
            vecA.y = 0
            vecA.z = vec1.z
            vecB.x = vec2.x
            vecB.y = 0
            vecB.z = vec2.z
            return vector.distance(vecA, vecB)
        end
    end)()
    minetest.registerTSEntity = function(clazz)
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
    math.clamp = function(min, max, input)
        if input < min then
            return min
        elseif input > max then
            return max
        end
        return input
    end
end
