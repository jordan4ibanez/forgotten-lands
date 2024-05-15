-- Lua Library inline imports
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 3,["75"] = 4,["76"] = 5,["77"] = 6,["78"] = 7,["79"] = 8,["80"] = 9,["81"] = 1,["82"] = 12,["83"] = 11,["84"] = 22,["85"] = 23,["86"] = 24,["87"] = 25,["88"] = 26,["90"] = 28,["91"] = 22,["92"] = 37,["93"] = 38,["94"] = 37,["95"] = 42,["96"] = 45,["97"] = 50,["98"] = 51,["99"] = 52,["100"] = 53,["101"] = 54,["103"] = 55,["104"] = 56,["106"] = 57,["107"] = 45,["108"] = 60,["109"] = 61,["110"] = 60,["111"] = 64,["112"] = 65,["113"] = 64,["114"] = 68,["115"] = 69,["116"] = 68});
utility = utility or ({})
do
    local floor = math.floor
    local PI = math.pi
    local PI_HALF = math.pi / 2
    local PI2 = math.pi * 2
    local random = math.random
    local sqrt = math.sqrt
    local asin = math.asin
    function utility.randomRange(min, max)
        return random() * (max - min) + min
    end
    math.clamp = function(min, max, input)
        if input < min then
            return min
        elseif input > max then
            return max
        end
        return input
    end
    math.truncate = function(floating)
        return math.floor(floating * 10) / 10
    end
    local truncate = math.truncate
    math.cosFromSin = function(sin, angle)
        local cos = sqrt(1 - sin * sin)
        local a = angle + PI_HALF
        local b = a - truncate(a / PI2) * PI2
        if b < 0 then
            b = PI2 + b
        end
        if b >= PI then
            return -cos
        end
        return cos
    end
    math.fma = function(x, y, z)
        return x * y + z
    end
    math.invsqrt = function(r)
        return 1 / sqrt(r)
    end
    math.safeAsin = function(r)
        return r <= -1 and -PI_HALF or (r >= 1 and PI_HALF or asin(r))
    end
end
