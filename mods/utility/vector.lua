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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 1,["75"] = 5,["76"] = 6,["77"] = 7,["78"] = 8,["79"] = 9,["80"] = 10,["81"] = 5,["82"] = 13,["83"] = 14,["84"] = 18,["85"] = 13,["86"] = 21,["87"] = 24,["88"] = 25,["89"] = 25,["90"] = 25,["91"] = 25,["92"] = 25,["93"] = 24,["94"] = 32,["95"] = 34,["96"] = 35,["97"] = 36,["98"] = 37,["99"] = 38,["100"] = 39,["101"] = 40,["102"] = 41,["103"] = 42,["104"] = 43,["105"] = 36,["106"] = 32,["107"] = 1,["108"] = 48,["109"] = 47});
utility = utility or ({})
do
    local rr = utility.randomRange
    vector.create3d = function(x, y, z)
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
    local create3d = vector.create3d
    vector.random = function(minX, maxX, minY, maxY, minZ, maxZ)
        return create3d(
            rr(minX, maxX),
            rr(minY, maxY),
            rr(minZ, maxZ)
        )
    end
    vector.distance2d = (function()
        local vecA = vector.create3d()
        local vecB = vector.create3d()
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
    function utility.vec3ToString(input)
        return (((tostring(input.x) .. ", ") .. tostring(input.y)) .. ", ") .. tostring(input.z)
    end
end
