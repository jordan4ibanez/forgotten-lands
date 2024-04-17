
namespace world {
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
  })

  {
    let grass: string[] = []

    for (let i = 1; i <= 5; i++) {
      const height = tostring(i)
      table.insert(grass, "tall_grass_" + height)
    }

    minetest.register_decoration({
      name: "grassOnFields",
      deco_type: DecorationType.simple,
      place_on: "grass",
      biomes: ["Forgotten Fields"],
      decoration: grass,
      param2: 0,
      param2_max: 239,
      fill_ratio: 0.98
    })

    const concat = utility.concat;
    const generateSchematic = utility.generateSchematic;
    const create = vector.create3d;

    const smallOak = generateSchematic(
      create(5, 5, 5),
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
        253, 253, 253, 253, 253,
        253, 254, 254, 254, 253,
        253, 254, 255, 254, 253,
        253, 254, 254, 254, 253,
        253, 253, 253, 253, 253
      ]
    )

    const mediumOak = generateSchematic(
      create(7, 7, 7),
      {
        " ": "air",
        "I": "oak_tree",
        "H": "oak_leaves"
      },
      {
        "I": true
      },
      concat(
        "       ",
        "       ",
        "       ",
        "   H   ",
        "  HHH  ",
        "       ",
        "       ",
        /////////
        "       ",
        "       ",
        "   H   ",
        "  HHH  ",
        " HHHHH ",
        "       ",
        "       ",
        /////////
        "       ",
        "   H   ",
        "  HHH  ",
        " HHHHH ",
        "HHHHHHH",
        "       ",
        "       ",
        /////////
        "   H   ",
        "  HHH  ",
        " HHIHH ",
        "HHHIHHH",
        "HHHIHHH",
        "   I   ",
        "   I   ",
        /////////
        "       ",
        "   H   ",
        "  HHH  ",
        " HHHHH ",
        "HHHHHHH",
        "       ",
        "       ",
        /////////
        "       ",
        "       ",
        "   H   ",
        "  HHH  ",
        " HHHHH ",
        "       ",
        "       ",
        "       ",
        /////////
        "       ",
        "       ",
        "   H   ",
        "  HHH  ",
        "       ",
        "       "
      ),
      [
        252, 252, 252, 252, 252, 252, 252,
        252, 253, 253, 253, 253, 253, 252,
        252, 253, 254, 254, 254, 253, 252,
        252, 253, 254, 255, 254, 253, 252,
        252, 253, 254, 254, 254, 253, 252,
        252, 253, 253, 253, 253, 253, 252,
        252, 252, 252, 252, 252, 252, 252,
      ]
    )

    const largeOak = generateSchematic(
      create(9, 9, 9),
      {
        " ": "air",
        "I": "oak_tree",
        "H": "oak_leaves"
      },
      {
        "I": true
      },
      concat(
        "         ",
        "         ",
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "   HHH   ",
        "         ",
        "         ",
        ////////////
        "         ",
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        "  HHHHH  ",
        "         ",
        "         ",
        ////////////
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        " HHHHHHH ",
        " HHHHHHH ",
        "         ",
        "         ",
        ////////////
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        " HHHHHHH ",
        "HHHHHHHHH",
        "HHHHHHHHH",
        "         ",
        "         ",
        ////////////
        "    H    ",
        "   HHH   ",
        "  HHIHH  ",
        " HHHIHHH ",
        "HHHHIHHHH",
        "HHHHIHHHH",
        "HHHHIHHHH",
        "    I    ",
        "    I    ",
        ////////////
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        " HHHHHHH ",
        "HHHHHHHHH",
        "HHHHHHHHH",
        "         ",
        "         ",
        ////////////
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        " HHHHHHH ",
        " HHHHHHH ",
        "         ",
        "         ",
        ////////////
        "         ",
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "  HHHHH  ",
        "  HHHHH  ",
        "         ",
        "         ",
        "         ",
        "         ",
        "         ",
        "         ",
        "    H    ",
        "   HHH   ",
        "   HHH   ",
        "         ",
        "         "
      ),
      [
        251, 251, 251, 251, 251, 251, 251, 251, 251,
        251, 252, 252, 252, 252, 252, 252, 252, 251,
        251, 252, 253, 253, 253, 253, 253, 252, 251,
        251, 252, 253, 254, 254, 254, 253, 252, 251,
        251, 252, 253, 254, 255, 254, 253, 252, 251,
        251, 252, 253, 254, 254, 254, 253, 252, 251,
        251, 252, 253, 253, 253, 253, 253, 252, 251,
        251, 252, 252, 252, 252, 252, 252, 252, 251,
        251, 251, 251, 251, 251, 251, 251, 251, 251,
      ]
    )
    {
      const smallID = minetest.register_schematic(smallOak)
      const mediumID = minetest.register_schematic(mediumOak)
      const largeID = minetest.register_schematic(largeOak)
      const oakSize = ["small", "medium", "large"]
      const oakIDs = [smallID, mediumID, largeID]
      oakIDs.forEach((id, key) => {
        minetest.register_decoration({
          name: "oak_" + oakSize[key],
          deco_type: DecorationType.schematic,
          place_on: "grass",
          biomes: ["Forgotten Fields"],
          schematic: id,
          fill_ratio: 0.01,
          place_offset_y: 1,
          flags: "place_center_x, place_center_z",
        })
      })
    }
  }

  utility.loadFiles(["ores"])
}