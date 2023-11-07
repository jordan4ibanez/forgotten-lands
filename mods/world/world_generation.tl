-- Solids
minetest.register_alias("mapgen_stone", "stone")
minetest.register_alias("mapgen_dirt", "dirt")
minetest.register_alias("mapgen_dirt_with_grass", "grass")

-- Falling
minetest.register_alias("mapgen_sand", "sand")
minetest.register_alias("mapgen_gravel", "gravel")

-- Liquids


-- Biomes
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
  for i = 1,5 do
    local height = tostring(i)
    table.insert(grass, "tall_grass_" .. height)
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

-- local mod_directory = minetest.get_modpath("world") .. "/"
-- minetest.register_decoration({
--   name = "pine_tree",
--   deco_type = "schematic",
--   place_on = "grass",
--   biomes = {"Forgotten Fields"},
--   schematic = mod_directory .. "schematics/pine_tree.mts",
--   fill_ratio = 0.01
-- })
