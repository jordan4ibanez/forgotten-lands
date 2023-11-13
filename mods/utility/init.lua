local ____lualib = require("lualib_bundle")
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local Map = ____lualib.Map
utility = utility or ({})
do
    local function concat(self, ...)
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
    local function generateSchematic(self, size, keys, forcePlace, data, ySliceProb)
        local newSchematic = {size = size, data = {}, yslice_prob = {}}
        local length = #data
        local countDown = length
        do
            local i = 1
            while i <= length do
                local databit = string.sub(data, countDown, countDown)
                table.insert(
                    newSchematic.data,
                    {
                        name = keys:get(databit),
                        forcePlace = forcePlace:get(databit)
                    }
                )
                countDown = countDown - 1
                i = i + 1
            end
        end
        for databit in pairs(ipairs(ySliceProb)) do
            table.insert(newSchematic.yslice_prob, {prob = databit})
        end
        local ____ = ItemStack
        return newSchematic
    end
end
