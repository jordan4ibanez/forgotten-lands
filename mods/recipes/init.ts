namespace Recipes {
  const r = minetest.register_craft;
  const recipeType = CraftRecipeType;
  const craftBlockType = Types.CraftingBlockType;
  // This will probably get broken down into sub-files in this namespace.
  // But for now, crafting goes here.

  /**
   * Easily process a bulk array of craft recipes.
   * @param inputArray Array of craft recipe definitions to be processed.
   */
  export function processRecipeArray(inputArray: CraftRecipeDefinition[]): void {
    for (const recipe of inputArray) {
      r(recipe)
    }
  }

  // Fire up the recipe cannon.
  const toolMaterialLinkages = {
    wood: "oak_wood",
    stone: "cobblestone",
    iron: "iron",
    diamond: "diamond",
    mese: "mese"
  }
  for (const [_,toolName] of Object.entries(Types.ToolType)) {
    if (toolName == Types.ToolType.Shears) continue
    for (const [material, requirement] of Object.entries(toolMaterialLinkages)) {
      print()
    }
  }

  

  // Generic craftables.
  const craftables: CraftRecipeDefinition[] = [
    {
      type: recipeType.shapeless,
      output: "oak_wood 4",
      recipe: ["oak_tree"]
    },
    {
      output: "stick 4",
      recipe: [
        [craftBlockType.wood],
        [craftBlockType.wood]
      ]
    },
  ]

  processRecipeArray(craftables)

}