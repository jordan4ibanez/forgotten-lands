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

{
  let grass: string[] = []

  for (let i = 1; i <= 5; i++) {
    const height = tostring(i)
    table.insert(grass, "tall_grass_" + height)
  }

  minetest.register_decoration({
    deco_type: "simple",
    place_on: "grass",
    biomes: ["Forgotten Fields"],
    decoration: grass,
    param2: 0,
    param2_max: 239,
    fill_ratio: 0.98
  } as DecorationDefinition)

  const concat = utility.concat;
  const generateSchematic = utility.generateSchematic;

  const small_oak = generateSchematic(
    vector.create(5,5,5),
    {
      " ": "air",
      "I": "oak_tree",
      "H": "oak_leaves"
    },
    {
      "I": true
    },
    concat(
      "     ",
      "     ",
      "  H  ",
      " HHH ",
      "     ",
      ///////
      "     ",
      "  H  ",
      " HHH ",
      "HHHHH",
      "     ",
      ///////
      "  H  ",
      " HHH ",
      "HHIHH",
      "HHIHH",
      "  I  ",
      ///////
      "     ",
      "  H  ",
      " HHH ",
      "HHHHH",
      "     ",
      ///////
      "     ",
      "     ",
      "  H  ",
      " HHH ",
      "     "
    ),
    [
      253,253,253,253,253,
      253,254,254,254,253,
      253,254,255,254,253,
      253,254,254,254,253,
      253,253,253,253,253
    ]
  )
}