minetest.register_alias("mapgen_stone", "stone")
minetest.register_alias("mapgen_dirt", "dirt")
minetest.register_alias("mapgen_dirt_with_grass", "grass")
minetest.register_alias("mapgen_sand", "sand")
minetest.register_alias("mapgen_gravel", "gravel")
minetest.register_biome({
    name = "Forgotten Fields",
    node_top = "grass",
    depth_top = 1,
    node_filler = "dirt",
    depth_filler = 6,
    node_stone = "stone"
})
do
    local grass = {}
    do
        local i = 1
        while i <= 5 do
            local height = tostring(i)
            table.insert(grass, "tall_grass_" .. height)
            i = i + 1
        end
    end
    minetest.register_decoration({
        deco_type = "simple",
        place_on = "grass",
        biomes = {"Forgotten Fields"},
        decoration = grass,
        param2 = 0,
        param2_max = 239,
        fill_ratio = 0.98
    })
end
