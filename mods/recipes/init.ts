namespace Recipes {
  const r = minetest.register_craft;
  const recipeType = CraftRecipeType;
  // This will probably get broken down into sub-files in this namespace.
  // But for now, crafting goes here.

  // And make a handly little function for the different files in the future.
  export function processRecipeArray(inputArray: CraftRecipeDefinition[]): void {
    for (const recipe of inputArray) {
      r(recipe)
    }
  }

  // One super array so I don't have to keep typing r()
  const craftables: CraftRecipeDefinition[] = [
    {
      type: recipeType.shapeless,
      output: "oak_wood 4",
      recipe: ["oak_tree"]
    }
  ]

  // Now process the array.
  processRecipeArray(craftables)

}