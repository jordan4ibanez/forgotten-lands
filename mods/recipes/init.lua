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
-- End of Lua Library inline imports
recipes = recipes or ({})
do
    local r = minetest.register_craft
    local recipeType = CraftRecipeType
    local craftBlockType = types.CraftingBlockType
    --- Easily process a bulk array of craft recipes.
    -- 
    -- @param inputArray Array of craft recipe definitions to be processed.
    function recipes.processRecipeArray(inputArray)
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
    recipes.processRecipeArray(toolRegistrationArray)
    local craftables = {{type = recipeType.shapeless, output = "oak_wood 4", recipe = {"oak_tree"}}, {output = "stick 4", recipe = {{craftBlockType.wood}, {craftBlockType.wood}}}}
    recipes.processRecipeArray(craftables)
    utility.loadFiles({"cooking", "fuel"})
end
