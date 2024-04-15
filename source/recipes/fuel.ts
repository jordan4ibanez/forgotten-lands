import { CraftRecipeType } from "../utility/enums"

namespace recipes {

  const blockType = types.CraftingBlockType

  minetest.register_craft({
    type: CraftRecipeType.fuel,
    recipe: "coal",
    burntime: 40,
  })
  
  minetest.register_craft({
    type: CraftRecipeType.fuel,
    recipe: "coal_block",
    burntime: 370,
  })

  minetest.register_craft({
    type: CraftRecipeType.fuel,
    recipe: blockType.tree,
    burntime: 40,
  })

  minetest.register_craft({
    type: CraftRecipeType.fuel,
    recipe: blockType.planks,
    burntime: 7,
  })

  minetest.register_craft({
    type: CraftRecipeType.fuel,
    recipe: "stick",
    burntime: 1,
  })

  
  
}