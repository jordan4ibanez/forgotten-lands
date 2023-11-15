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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 2,["75"] = 2,["76"] = 2,["77"] = 2,["78"] = 4,["79"] = 7,["80"] = 7,["81"] = 7,["82"] = 7,["83"] = 41,["84"] = 42,["85"] = 42,["86"] = 42,["87"] = 42,["88"] = 42,["89"] = 7,["90"] = 53,["91"] = 54,["92"] = 54,["93"] = 54,["94"] = 54,["95"] = 54,["96"] = 7,["97"] = 7,["98"] = 7,["99"] = 2,["100"] = 2,["101"] = 2});
Player = Player or ({})
do
    minetest.override_item(
        "",
        {
            wield_scale = vector.create(1, 1, 2.5),
            tool_capabilities = {full_punch_interval = 0.9, max_drop_level = 1, groupcaps = {
                break_instant = {times = {[1] = 0.1}, uses = 0},
                soil = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0},
                wooden = {times = {[1] = 1.5, [2] = 4, [3] = 8, [4] = 14}, uses = 0},
                leafy = {times = {[1] = 0.3, [2] = 0.6, [3] = 0.9, [4] = 1.2}, uses = 0},
                stone = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                metal = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                glass = {times = {[1] = 1, [2] = 3, [3] = 6, [4] = 9}, maxlevel = 0, uses = 0},
                wool = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0}
            }, damage_groups = {fleshy = 1}}
        }
    )
end
