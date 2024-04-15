
namespace recipes {

  const blockType = types.CraftingBlockType

  minetest.register_craft({
    type: utility.CraftRecipeType.cooking,
    output: "glass",
    recipe: blockType.sand,
  })

  minetest.register_craft({
    type: utility.CraftRecipeType.cooking,
    output: "iron",
    recipe: "iron_ore",
  })
  
}