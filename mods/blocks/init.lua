Blocks = Blocks or ({})
do
    local sounds = Sounds
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
    utility.loadFiles({""})
    local modDirectory = minetest.get_modpath("blocks")
    for ____, file in ipairs({"normal"}) do
        dofile(((modDirectory .. "/") .. file) .. ".lua")
    end
end
