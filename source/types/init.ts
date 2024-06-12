namespace types {
  export enum ToolType {
    Pickaxe = "pickaxe",
    Shovel = "shovel",
    Axe = "axe",
    Hoe = "hoe",
    Sword = "sword",
    Shears = "shears"
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
    planks = "planks",
    tree = "tree",
    sand = "sand",
    lava_cooling = "lava_cooling",
    liquid = "liquid",
    water = "water",
    attached_node = "attached_node"
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
    planks = "group:planks",
    tree = "group:tree",
    sand = "group:sand"
  }

  export enum DamageGroup {
    flesh = "flesh",
    metal = "metal",
    bone = "bone"
  }
}