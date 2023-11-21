recipes = recipes or ({})
do
    minetest.register_craft({type = CraftRecipeType.cooking, output = "glass", recipe = "group:sand"})
end
