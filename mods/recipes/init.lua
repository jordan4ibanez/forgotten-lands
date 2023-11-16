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
Recipes = Recipes or ({})
do
    local r = minetest.register_craft
    local recipeType = CraftRecipeType
    local craftBlockType = Types.CraftingBlockType
    --- Easily process a bulk array of craft recipes.
    -- 
    -- @param inputArray Array of craft recipe definitions to be processed.
    function Recipes.processRecipeArray(inputArray)
        for ____, recipe in ipairs(inputArray) do
            r(recipe)
        end
    end
    local toolMaterialLinkages = {
        wood = "oak_wood",
        stone = "cobblestone",
        iron = "iron",
        diamond = "diamond",
        mese = "mese"
    }
    for ____, ____value in ipairs(__TS__ObjectEntries(Types.ToolType)) do
        local enumerator = ____value[1]
        local toolName = ____value[2]
        do
            if toolName == Types.ToolType.Shears then
                goto __continue6
            end
            print(toolName)
        end
        ::__continue6::
    end
    local craftables = {{type = recipeType.shapeless, output = "oak_wood 4", recipe = {"oak_tree"}}, {output = "stick 4", recipe = {{craftBlockType.wood}, {craftBlockType.wood}}}}
    Recipes.processRecipeArray(craftables)
end
