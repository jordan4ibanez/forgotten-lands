blocks = blocks or ({})
do
    local blockType = types.BlockType
    local pixel = utility.pixel
    local create = vector.create
    local grassSize = {
        [1] = create(3, 3, 13),
        [2] = create(3, 5, 13),
        [3] = create(3, 6, 13),
        [4] = create(2, 7, 14),
        [5] = create(2, 8, 14)
    }
    do
        local i = 1
        while i <= 5 do
            local size = grassSize[i]
            local collisionBox = {{
                pixel(size.x),
                pixel(0),
                pixel(size.x),
                pixel(size.z),
                pixel(size.y),
                pixel(size.z)
            }}
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
                    collision_box = {type = Nodeboxtype.fixed, fixed = collisionBox},
                    selection_box = {type = Nodeboxtype.fixed, fixed = collisionBox},
                    groups = {[blockType.break_instant] = 1, attached_node = 1},
                    drop = ""
                }
            )
            i = i + 1
        end
    end
    utility.loadFiles({"normal", "ores", "furnace", "workbench"})
end
