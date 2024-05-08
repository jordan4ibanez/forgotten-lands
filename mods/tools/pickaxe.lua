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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 4,["75"] = 5,["76"] = 6,["77"] = 7,["78"] = 9,["79"] = 9,["80"] = 9,["81"] = 9,["82"] = 9,["83"] = 9,["84"] = 9,["85"] = 9,["86"] = 9,["87"] = 31,["88"] = 31,["89"] = 31,["90"] = 31,["91"] = 31,["92"] = 31,["93"] = 31,["94"] = 31,["95"] = 31,["96"] = 54,["97"] = 54,["98"] = 54,["99"] = 54,["100"] = 54,["101"] = 54,["102"] = 54,["103"] = 54,["104"] = 54,["105"] = 78,["106"] = 78,["107"] = 78,["108"] = 78,["109"] = 78,["110"] = 78,["111"] = 78,["112"] = 78,["113"] = 78,["114"] = 102,["115"] = 102,["116"] = 102,["117"] = 102,["118"] = 102,["119"] = 102,["120"] = 102,["121"] = 102,["122"] = 102,["123"] = 127,["124"] = 127,["125"] = 127,["126"] = 127,["127"] = 127,["128"] = 130,["129"] = 135,["130"] = 135,["131"] = 135,["132"] = 135,["133"] = 135,["134"] = 127,["135"] = 127,["136"] = 127,["137"] = 127});
tools = tools or ({})
do
    local generateToolDropGroups = tools.generateToolDropGroups
    local toolType = types.ToolType
    local blockType = types.BlockType
    local wieldScale = tools.wieldScale
    minetest.register_tool(
        ":wood_pickaxe",
        {
            inventory_image = "default_tool_woodpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {[blockType.stone] = {times = {[1] = 1.25}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 1})
        }
    )
    minetest.register_tool(
        ":stone_pickaxe",
        {
            inventory_image = "default_tool_stonepick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 2})
        }
    )
    minetest.register_tool(
        ":iron_pickaxe",
        {
            inventory_image = "default_tool_steelpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 3})
        }
    )
    minetest.register_tool(
        ":gold_pickaxe",
        {
            inventory_image = "default_tool_goldpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.stone] = {times = {[1] = 0.5, [2] = 1, [3] = 1.5}, uses = 4, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_pickaxe",
        {
            inventory_image = "default_tool_diamondpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75, [4] = 5}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 4})
        }
    )
    minetest.register_tool(
        ":mese_pickaxe",
        {
            inventory_image = "default_tool_mesepick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.stone] = {times = {
                [1] = 1.25,
                [2] = 2.5,
                [3] = 3.75,
                [4] = 5,
                [5] = 6.25
            }, uses = 30, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 5})
        }
    )
end
