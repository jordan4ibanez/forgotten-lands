-- Lua Library inline imports
local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["82"] = 1,["84"] = 1,["85"] = 1,["86"] = 1,["87"] = 1,["88"] = 1,["89"] = 1,["90"] = 1,["94"] = 1,["95"] = 19,["96"] = 20,["97"] = 20,["98"] = 20,["100"] = 21,["101"] = 1,["102"] = 22,["103"] = 21,["107"] = 25,["108"] = 18,["109"] = 1,["110"] = 32});
Tools = Tools or ({})
do
    Tools.CURRENT_MAX_LEVEL = 5
    Tools.ToolType = ToolType or ({})
    Tools.ToolType.Pickaxe = "pickaxe"
    Tools.ToolType.Shovel = "shovel"
    Tools.ToolType.Axe = "axe"
    Tools.ToolType.Hoe = "hoe"
    Tools.ToolType.Shears = "shears"
    --- Generates a node tool_groups array.
    -- 
    -- @param table Holds the ToolType and min tool level to drop an item.
    function Tools.generateDropRequirements(____table)
        local temp = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(____table)) do
            local toolType = ____value[1]
            local minLevel = ____value[2]
            do
                local i = minLevel
                while i <= Tools.CURRENT_MAX_LEVEL do
                    temp[#temp + 1] = (toolType .. "_") .. tostring(i)
                    i = i + 1
                end
            end
        end
        return temp
    end
    Tools.generateDropRequirements({[Tools.ToolType.Axe] = 3})
    minetest.register_tool(":pickaxe", {inventory_image = "default_tool_stonepick.png", tool_capabilities = {full_punch_interval = 0.5, max_drop_level = 1, groupcaps = {stone = {times = {[1] = 1}, maxlevel = 1, maxdrop = 0}}}, groups = {pickaxe_1 = 1}})
end
