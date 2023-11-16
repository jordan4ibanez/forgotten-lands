Types = Types or ({})
do
    Types.ToolType = ToolType or ({})
    Types.ToolType.Pickaxe = "pickaxe"
    Types.ToolType.Shovel = "shovel"
    Types.ToolType.Axe = "axe"
    Types.ToolType.Hoe = "hoe"
    Types.ToolType.Shears = "shears"
    Types.BlockType = BlockType or ({})
    Types.BlockType.break_instant = 0
    Types.BlockType[Types.BlockType.break_instant] = "break_instant"
    Types.BlockType.soil = 1
    Types.BlockType[Types.BlockType.soil] = "soil"
    Types.BlockType.wood = 2
    Types.BlockType[Types.BlockType.wood] = "wood"
    Types.BlockType.leaf = 3
    Types.BlockType[Types.BlockType.leaf] = "leaf"
    Types.BlockType.stone = 4
    Types.BlockType[Types.BlockType.stone] = "stone"
    Types.BlockType.metal = 5
    Types.BlockType[Types.BlockType.metal] = "metal"
    Types.BlockType.glass = 6
    Types.BlockType[Types.BlockType.glass] = "glass"
    Types.BlockType.wool = 7
    Types.BlockType[Types.BlockType.wool] = "wool"
end
