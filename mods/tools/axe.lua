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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 2,["75"] = 3,["76"] = 4,["77"] = 5,["78"] = 7,["79"] = 7,["80"] = 7,["81"] = 7,["82"] = 7,["83"] = 7,["84"] = 7,["85"] = 7,["86"] = 7,["87"] = 29,["88"] = 29,["89"] = 29,["90"] = 29,["91"] = 29,["92"] = 29,["93"] = 29,["94"] = 29,["95"] = 29,["96"] = 52,["97"] = 52,["98"] = 52,["99"] = 52,["100"] = 52,["101"] = 52,["102"] = 52,["103"] = 52,["104"] = 52,["105"] = 76,["106"] = 76,["107"] = 76,["108"] = 76,["109"] = 76,["110"] = 76,["111"] = 76,["112"] = 76,["113"] = 76,["114"] = 100,["115"] = 100,["116"] = 100,["117"] = 100,["118"] = 100,["119"] = 100,["120"] = 100,["121"] = 100,["122"] = 100,["123"] = 125,["124"] = 125,["125"] = 125,["126"] = 125,["127"] = 125,["128"] = 128,["129"] = 133,["130"] = 133,["131"] = 133,["132"] = 133,["133"] = 133,["134"] = 125,["135"] = 125,["136"] = 125,["137"] = 125});
tools = tools or ({})
do
    local generateToolDropGroups = tools.generateToolDropGroups
    local toolType = types.ToolType
    local blockType = types.BlockType
    local wieldScale = tools.wieldScale
    minetest.register_tool(
        ":wood_axe",
        {
            inventory_image = "default_tool_woodaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {[blockType.wood] = {times = {[1] = 1.25}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Axe] = 1})
        }
    )
    minetest.register_tool(
        ":stone_axe",
        {
            inventory_image = "default_tool_stoneaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {[blockType.wood] = {times = {[1] = 1.25, [2] = 2.5}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Axe] = 2})
        }
    )
    minetest.register_tool(
        ":iron_axe",
        {
            inventory_image = "default_tool_steelaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.wood] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Axe] = 3})
        }
    )
    minetest.register_tool(
        ":gold_axe",
        {
            inventory_image = "default_tool_goldaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.wood] = {times = {[1] = 0.5, [2] = 1, [3] = 1.5}, uses = 4, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Axe] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_axe",
        {
            inventory_image = "default_tool_diamondaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {[blockType.wood] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75, [4] = 5}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Axe] = 4})
        }
    )
    minetest.register_tool(
        ":mese_axe",
        {
            inventory_image = "default_tool_meseaxe.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.wood] = {times = {
                [1] = 1.25,
                [2] = 2.5,
                [3] = 3.75,
                [4] = 5,
                [5] = 6.25
            }, uses = 30, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Axe] = 5})
        }
    )
end
