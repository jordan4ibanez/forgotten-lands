// Solids
minetest.register_alias("mapgen_stone", "stone")
minetest.register_alias("mapgen_dirt", "dirt")
minetest.register_alias("mapgen_dirt_with_grass", "grass")

// Falling
minetest.register_alias("mapgen_sand", "sand")
minetest.register_alias("mapgen_gravel", "gravel")

// Liquids

// Biomes
minetest.register_biome({
  name: "Forgotten Fields",
  node_top: "grass",
  depth_top: 1,
  node_filler: "dirt",
  depth_filler: 6,
  node_stone: "stone"
} as BiomeDefinition)