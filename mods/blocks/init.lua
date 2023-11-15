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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 2,["76"] = 4,["77"] = 4,["78"] = 5,["79"] = 5,["80"] = 5,["81"] = 5,["82"] = 5,["83"] = 5,["84"] = 5,["85"] = 5,["86"] = 5,["87"] = 5,["88"] = 5,["89"] = 5,["90"] = 5,["91"] = 5,["92"] = 5,["93"] = 4,["96"] = 21,["97"] = 22,["98"] = 23});
Blocks = Blocks or ({})
do
    local sounds = Sounds
    do
        local i = 1
        while i <= 5 do
            minetest.register_node(
                ":tall_grass_" .. tostring(i),
                {
                    drawtype = Drawtype.plantlike,
                    walkable = false,
                    waving = 1,
                    paramtype = ParamType1.light,
                    paramtype2 = ParamType2.degrotate,
                    tiles = {("default_grass_" .. tostring(i)) .. ".png"},
                    buildable_to = true,
                    sounds = sounds.plant(),
                    groups = {break_instant = 1},
                    drop = ""
                }
            )
            i = i + 1
        end
    end
    local modDirectory = minetest.get_modpath("blocks")
    for ____, file in ipairs({"normal"}) do
        dofile(((modDirectory .. "/") .. file) .. ".lua")
    end
end
