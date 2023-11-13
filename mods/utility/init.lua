-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
function concat(...)
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
function generateSchematic(size, keys, forcePlace, data, ySliceProb)
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
