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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["82"] = 1,["84"] = 1,["85"] = 1,["89"] = 1,["90"] = 14,["91"] = 15,["92"] = 15,["93"] = 15,["95"] = 16,["96"] = 1,["97"] = 17,["98"] = 16,["102"] = 20,["103"] = 13,["107"] = 1,["108"] = 28,["109"] = 29,["110"] = 29,["111"] = 29,["113"] = 30,["114"] = 30,["115"] = 31,["116"] = 30,["120"] = 34,["121"] = 27,["122"] = 37,["123"] = 37,["124"] = 37,["125"] = 37,["126"] = 37,["127"] = 37,["128"] = 37,["129"] = 37});
tools = tools or ({})
do
    tools.CURRENT_MAX_LEVEL = 5
    tools.wieldScale = vector.create3d(1.5, 1.5, 1)
    --- Generates a node tool_groups array.
    -- 
    -- @param table Holds the ToolType and min tool level to drop an item.
    function tools.generateDropRequirements(____table)
        local temp = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(____table)) do
            local toolType = ____value[1]
            local minLevel = ____value[2]
            do
                local i = minLevel
                while i <= tools.CURRENT_MAX_LEVEL do
                    temp[#temp + 1] = (toolType .. "_") .. tostring(i)
                    i = i + 1
                end
            end
        end
        return temp
    end
    --- Generates a tool group dictionary.
    -- 
    -- @param table The ToolType max level in which it can drop items from the tool group.
    function tools.generateToolDropGroups(____table)
        local temp = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(____table)) do
            local toolType = ____value[1]
            local maxLevel = ____value[2]
            do
                local i = 1
                while i <= maxLevel do
                    temp[(toolType .. "_") .. tostring(i)] = 1
                    i = i + 1
                end
            end
        end
        return temp
    end
    utility.loadFiles({
        "hand",
        "pickaxe",
        "shovel",
        "axe",
        "sword",
        "shears"
    })
end
