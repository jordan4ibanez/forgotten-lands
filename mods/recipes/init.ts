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
    wood: craftBlockType.wood,
    stone: "cobblestone",
    iron: "iron",
    diamond: "diamond",
    mese: "mese"
  }
  let toolRegistrationArray: CraftRecipeDefinition[] = []
  for (const [material, requirement] of Object.entries(toolMaterialLinkages)) {
    toolRegistrationArray.push({
      output: material + "_pickaxe",
      recipe: [
        [requirement, requirement, requirement],
        ["",          "stick",     ""],
        ["",          "stick",     ""]
      ]
    })
    toolRegistrationArray.push({
      output: material + "_shovel",
      recipe: [
        [requirement],
        ["stick"],
        ["stick"]
      ]
    })
    // Axe can be crafted in both directions.
    toolRegistrationArray.push({
      output: material + "_axe",
      recipe: [
        [requirement, requirement, ""],
        [requirement, "stick",     ""],
        ["",          "stick",     ""]
      ]
    })
    toolRegistrationArray.push({
      output: material + "_axe",
      recipe: [
        ["", requirement, requirement],
        ["", "stick",     requirement],
        ["", "stick",     ""]
      ]
    })
    // Hoe can be crafted in both directions.
    toolRegistrationArray.push({
      output: material + "_hoe",
      recipe: [
        [requirement, requirement],
        ["",          "stick"],
        ["",          "stick"]
      ]
    })
    toolRegistrationArray.push({
      output: material + "_hoe",
      recipe: [
        [requirement, requirement],
        ["stick",     ""],
        ["stick",     ""]
      ]
    })
    toolRegistrationArray.push({
      output: material + "_sword",
      recipe: [
        [requirement],
        [requirement],
        ["stick"]
      ]
    })
  }
  processRecipeArray(toolRegistrationArray)

  

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