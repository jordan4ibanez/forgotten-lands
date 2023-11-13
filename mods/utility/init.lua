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
x = vector:new(1, 2, 3)
