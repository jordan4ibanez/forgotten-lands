recipes = recipes or ({})
do
    minetest.register_craft({type = CraftRecipeType.fuel, recipe = "coal", burntime = 40})
    minetest.register_craft({type = CraftRecipeType.fuel, recipe = "coal_block", burntime = 370})
    minetest.register_craft({type = CraftRecipeType.fuel, recipe = "group:wood", burntime = 7})
    minetest.register_craft({type = CraftRecipeType.cooking, output = "iron", recipe = "iron_ore"})
end
