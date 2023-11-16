namespace Types {
  export enum ToolType {
    Pickaxe = "pickaxe",
    Shovel = "shovel",
    Axe = "axe",
    Hoe = "hoe",
    Shears = "shears",
    Sword = "sword"
  }

  export enum BlockType {
    break_instant = "break_instant",
    soil = "soil",
    wood = "wood",
    leaf = "leaf",
    stone = "stone",
    metal = "metal",
    glass = "glass",
    wool = "wool",
  }

  // This one is quite useful for crafting recipes.
  export enum CraftingBlockType {
    soil = "group:soil",
    wood = "group:wood",
    leaf = "group:leaf",
    stone = "group:stone",
    metal = "group:metal",
    glass = "group:glass",
    wool = "group:wool",
  }
}