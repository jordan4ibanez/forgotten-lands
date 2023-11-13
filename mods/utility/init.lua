-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
function concat(self, ...)
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
function generateSchematic(self, size)
end
x = vector:zero()
