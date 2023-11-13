-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
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
                print(forcePlace[databit] == true)
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
        for ____, item in ipairs({any}) do
            builder = builder .. tostring((function()
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
            end)())
            builder = builder .. ","
        end
        print(builder)
    end
    function utility.randomRange(min, max)
        return math.random() * (max - min) + min
    end
end
