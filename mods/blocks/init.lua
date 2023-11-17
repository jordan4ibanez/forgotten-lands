blocks = blocks or ({})
do
    local blockType = Types.BlockType
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
                    groups = {[blockType.break_instant] = 1, attached_node = 1},
                    drop = ""
                }
            )
            i = i + 1
        end
    end
    Utility.loadFiles({"normal", "ores", "furnace"})
end
