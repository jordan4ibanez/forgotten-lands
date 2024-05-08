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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 3,["75"] = 4,["76"] = 5,["77"] = 6,["78"] = 8,["79"] = 8,["80"] = 8,["81"] = 8,["82"] = 8,["83"] = 8,["84"] = 8,["85"] = 8,["86"] = 8,["87"] = 30,["88"] = 30,["89"] = 30,["90"] = 30,["91"] = 30,["92"] = 30,["93"] = 30,["94"] = 30,["95"] = 30,["96"] = 53,["97"] = 53,["98"] = 53,["99"] = 53,["100"] = 53,["101"] = 53,["102"] = 53,["103"] = 53,["104"] = 53,["105"] = 77,["106"] = 77,["107"] = 77,["108"] = 77,["109"] = 77,["110"] = 77,["111"] = 77,["112"] = 77,["113"] = 77,["114"] = 101,["115"] = 101,["116"] = 101,["117"] = 101,["118"] = 101,["119"] = 101,["120"] = 101,["121"] = 101,["122"] = 101,["123"] = 126,["124"] = 126,["125"] = 126,["126"] = 126,["127"] = 126,["128"] = 129,["129"] = 134,["130"] = 134,["131"] = 134,["132"] = 134,["133"] = 134,["134"] = 126,["135"] = 126,["136"] = 126,["137"] = 126});
tools = tools or ({})
do
    local generateToolDropGroups = tools.generateToolDropGroups
    local toolType = types.ToolType
    local blockType = types.BlockType
    local wieldScale = tools.wieldScale
    minetest.register_tool(
        ":wood_sword",
        {
            inventory_image = "default_tool_woodsword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {[blockType.leaf] = {times = {[1] = 0.75}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Sword] = 1})
        }
    )
    minetest.register_tool(
        ":stone_sword",
        {
            inventory_image = "default_tool_stonesword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {[blockType.leaf] = {times = {[1] = 0.75, [2] = 1.5}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Sword] = 2})
        }
    )
    minetest.register_tool(
        ":iron_sword",
        {
            inventory_image = "default_tool_steelsword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.leaf] = {times = {[1] = 0.75, [2] = 1.5, [3] = 2.25}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Sword] = 3})
        }
    )
    minetest.register_tool(
        ":gold_sword",
        {
            inventory_image = "default_tool_goldsword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.leaf] = {times = {[1] = 0.25, [2] = 0.5, [3] = 1}, uses = 4, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Sword] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_sword",
        {
            inventory_image = "default_tool_diamondsword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {[blockType.leaf] = {times = {[1] = 0.75, [2] = 1.5, [3] = 2.25, [4] = 3}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Sword] = 4})
        }
    )
    minetest.register_tool(
        ":mese_sword",
        {
            inventory_image = "default_tool_mesesword.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.leaf] = {times = {
                [1] = 0.75,
                [2] = 1.5,
                [3] = 2.25,
                [4] = 3,
                [5] = 3.75
            }, uses = 30, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Sword] = 5})
        }
    )
end
