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
-- End of Lua Library inline imports
utility = utility or ({})
do
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
            builder = builder .. (function()
                repeat
                    local ____switch12 = type(item)
                    local thing
                    local ____cond12 = ____switch12 == "string"
                    if ____cond12 then
                        return item
                    end
                    ____cond12 = ____cond12 or ____switch12 == "number"
                    if ____cond12 then
                        return tostring(item)
                    end
                    ____cond12 = ____cond12 or ____switch12 == "table"
                    if ____cond12 then
                        return dump(item)
                    end
                    ____cond12 = ____cond12 or ____switch12 == "userdata"
                    if ____cond12 then
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
            end)()
        end
        print(builder)
    end
    function utility.randomRange(min, max)
        return math.random() * (max - min) + min
    end
    local rr = utility.randomRange
    vector.create = function(x, y, z)
        local temp = vector.zero()
        temp.x = x
        temp.y = y
        temp.z = z
        return temp
    end
    local create = vector.create
    vector.random = function(minX, minY, minZ, maxX, maxY, maxZ)
        return create(
            rr(minX, maxX),
            rr(minY, maxY),
            rr(minZ, maxZ)
        )
    end
end
