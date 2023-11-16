Blocks = Blocks or ({})
do
    local sounds = Sounds
    Blocks.BlockType = BlockType or ({})
    Blocks.BlockType.break_instant = "break_instant"
    Blocks.BlockType.soil = "soil"
    Blocks.BlockType.wood = "wood"
    Blocks.BlockType.leaf = "leaf"
    Blocks.BlockType.stone = "stone"
    Blocks.BlockType.metal = "metal"
    Blocks.BlockType.glass = "glass"
    Blocks.BlockType.wool = "wool"
    do
        local i = 1
        while i <= 5 do
            minetest.register_node(
                ":tall_grass_" .. tostring(i),
                {
                    drawtype = Drawtype.plantlike,
                    walkable = false,
                    waving = 1,
                    paramtype = ParamType1.light,
                    paramtype2 = ParamType2.degrotate,
                    tiles = {("default_grass_" .. tostring(i)) .. ".png"},
                    buildable_to = true,
                    sounds = sounds.plant(),
                    groups = {break_instant = 1},
                    drop = ""
                }
            )
            i = i + 1
        end
    end
    local modDirectory = minetest.get_modpath("blocks")
    for ____, file in ipairs({"normal"}) do
        dofile(((modDirectory .. "/") .. file) .. ".lua")
    end
end
