namespace Recipes {
  const r = minetest.register_craft;
  const recipeType = CraftRecipeType;

  // One super array so I don't have to keep typing r()
  const superArray: CraftRecipeDefinition[] = [

  ]

  // Now process the array.
  for (const recipe of superArray) {
    r(recipe)
  }
}