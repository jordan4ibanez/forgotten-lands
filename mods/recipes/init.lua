Recipes = Recipes or ({})
do
    local r = minetest.register_craft
    local recipeType = CraftRecipeType
    function Recipes.processRecipeArray(inputArray)
        for ____, recipe in ipairs(inputArray) do
            r(recipe)
        end
    end
    local craftables = {{type = recipeType.shapeless, output = "oak_wood 4", recipe = {"oak_tree"}}}
    Recipes.processRecipeArray(craftables)
end
