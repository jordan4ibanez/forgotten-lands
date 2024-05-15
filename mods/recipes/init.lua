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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["82"] = 2,["84"] = 3,["85"] = 4,["86"] = 5,["90"] = 13,["91"] = 14,["92"] = 15,["94"] = 13,["95"] = 20,["96"] = 20,["97"] = 20,["98"] = 20,["99"] = 20,["100"] = 20,["101"] = 20,["102"] = 20,["103"] = 28,["104"] = 29,["105"] = 29,["106"] = 29,["107"] = 30,["108"] = 38,["109"] = 47,["110"] = 55,["111"] = 64,["112"] = 72,["113"] = 80,["115"] = 89,["116"] = 96,["117"] = 101,["118"] = 131,["119"] = 133});
recipes = recipes or ({})
do
    local r = minetest.register_craft
    local recipeType = CraftRecipeType
    local craftBlockType = types.CraftingBlockType
    --- Easily process a bulk array of craft recipes.
    -- 
    -- @param inputArray Array of craft recipe definitions to be processed.
    local function processRecipeArray(inputArray)
        for ____, recipe in ipairs(inputArray) do
            r(recipe)
        end
    end
    local toolMaterialLinkages = {
        wood = craftBlockType.wood,
        stone = "cobblestone",
        iron = "iron",
        gold = "gold",
        diamond = "diamond",
        mese = "mese"
    }
    local toolRegistrationArray = {}
    for ____, ____value in ipairs(__TS__ObjectEntries(toolMaterialLinkages)) do
        local material = ____value[1]
        local requirement = ____value[2]
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_pickaxe", recipe = {{requirement, requirement, requirement}, {"", "stick", ""}, {"", "stick", ""}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_shovel", recipe = {{requirement}, {"stick"}, {"stick"}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_axe", recipe = {{requirement, requirement, ""}, {requirement, "stick", ""}, {"", "stick", ""}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_axe", recipe = {{"", requirement, requirement}, {"", "stick", requirement}, {"", "stick", ""}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_hoe", recipe = {{requirement, requirement}, {"", "stick"}, {"", "stick"}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_hoe", recipe = {{requirement, requirement}, {"stick", ""}, {"stick", ""}}}
        toolRegistrationArray[#toolRegistrationArray + 1] = {output = material .. "_sword", recipe = {{requirement}, {requirement}, {"stick"}}}
    end
    toolRegistrationArray[#toolRegistrationArray + 1] = {output = "shears", recipe = {{"", "iron"}, {"iron", ""}}}
    processRecipeArray(toolRegistrationArray)
    local craftables = {{type = recipeType.shapeless, output = "oak_wood 4", recipe = {"oak_tree"}}, {output = "stick 4", recipe = {{craftBlockType.planks}, {craftBlockType.planks}}}, {output = "furnace", recipe = {{"cobblestone", "cobblestone", "cobblestone"}, {"cobblestone", "", "cobblestone"}, {"cobblestone", "cobblestone", "cobblestone"}}}, {output = "workbench", recipe = {{craftBlockType.planks, craftBlockType.planks}, {craftBlockType.planks, craftBlockType.planks}}}}
    processRecipeArray(craftables)
    utility.loadFiles({"cooking", "fuel"})
end
