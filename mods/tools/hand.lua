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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 3,["75"] = 8,["76"] = 8,["77"] = 8,["78"] = 8,["79"] = 10,["80"] = 13,["81"] = 13,["82"] = 13,["83"] = 13,["84"] = 13,["85"] = 13,["86"] = 13,["87"] = 13,["88"] = 8,["89"] = 8,["90"] = 8});
tools = tools or ({})
do
    local blockType = types.BlockType
    minetest.override_item(
        "",
        {
            wield_scale = vector.create3d(1, 1, 2.5),
            tool_capabilities = {full_punch_interval = 0.9, max_drop_level = 1, groupcaps = {
                [blockType.break_instant] = {times = {[1] = 0.1}, uses = 0},
                [blockType.soil] = {times = {[1] = 2}, uses = 0},
                [blockType.wood] = {times = {[1] = 4, [2] = 6, [3] = 8, [4] = 10}, uses = 0},
                [blockType.leaf] = {times = {[1] = 1}, uses = 0},
                [blockType.stone] = {times = {[1] = 10, [2] = 20, [3] = 30, [4] = 40}, maxlevel = 0, maxdrop = 0, uses = 0},
                [blockType.metal] = {times = {[1] = 10, [2] = 20, [3] = 30, [4] = 40}, maxlevel = 0, maxdrop = 0, uses = 0},
                [blockType.glass] = {times = {[1] = 10, [2] = 20, [3] = 30, [4] = 40}, maxlevel = 0, uses = 0},
                [blockType.wool] = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0}
            }, damage_groups = {fleshy = 1}}
        }
    )
end
