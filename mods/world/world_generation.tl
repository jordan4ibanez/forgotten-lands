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

local small_oak = generate_schematic(
  vector.new(5,5,5),
  {
    [" "] = "air",
    ["I"] = "oak_tree",
    ["H"] = "oak_leaves"
  },
  {
    ["I"] = true
  },
  concat(
    "     ",
    "     ",
    "  H  ",
    " HHH ",
    "     ",
    --------
    "     ",
    "  H  ",
    " HHH ",
    "HHHHH",
    "     ",
    -------
    "  H  ",
    " HHH ",
    "HHIHH",
    "HHIHH",
    "  I  ",
    --------
    "     ",
    "  H  ",
    " HHH ",
    "HHHHH",
    "     ",
    --------
    "     ",
    "     ",
    "  H  ",
    " HHH ",
    "     "
  ),
  {
    253,253,253,253,253,
    253,254,254,254,253,
    253,254,255,254,253,
    253,254,254,254,253,
    253,253,253,253,253
  }
)

local medium_oak = generate_schematic(
  vector.new(7,7,7),
  {
    [" "] = "air",
    ["I"] = "oak_tree",
    ["H"] = "oak_leaves"
  },
  {
    ["I"] = true
  },
  concat(
    "       ",
    "       ",
    "       ",
    "   H   ",
    "  HHH  ",
    "       ",
    "       ",
    ---------
    "       ",
    "       ",
    "   H   ",
    "  HHH  ",
    " HHHHH ",
    "       ",
    "       ",
    ---------
    "       ",
    "   H   ",
    "  HHH  ",
    " HHHHH ",
    "HHHHHHH",
    "       ",
    "       ",
    ---------
    "   H   ",
    "  HHH  ",
    " HHIHH ",
    "HHHIHHH",
    "HHHIHHH",
    "   I   ",
    "   I   ",
    ---------
    "       ",
    "   H   ",
    "  HHH  ",
    " HHHHH ",
    "HHHHHHH",
    "       ",
    "       ",
    ---------
    "       ",
    "       ",
    "   H   ",
    "  HHH  ",
    " HHHHH ",
    "       ",
    "       ",
    "       ",
    "       ",
    "       ",
    "   H   ",
    "  HHH  ",
    "       ",
    "       "
  ),
  {
    252,252,252,252,252,252,252,
    252,253,253,253,253,253,252,
    252,253,254,254,254,253,252,
    252,253,254,255,254,253,252,
    252,253,254,254,254,253,252,
    252,253,253,253,253,253,252,
    252,252,252,252,252,252,252,
  }
)


local large_oak = generate_schematic(
  vector.new(9,9,9),
  {
    [" "] = "air",
    ["I"] = "oak_tree",
    ["H"] = "oak_leaves"
  },
  {
    ["I"] = true
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
    ------------
    "         ",
    "         ",
    "         ",
    "    H    ",
    "   HHH   ",
    "  HHHHH  ",
    "  HHHHH  ",
    "         ",
    "         ",
    ------------
    "         ",
    "         ",
    "    H    ",
    "   HHH   ",
    "  HHHHH  ",
    " HHHHHHH ",
    " HHHHHHH ",
    "         ",
    "         ",
    ------------
    "         ",
    "    H    ",
    "   HHH   ",
    "  HHHHH  ",
    " HHHHHHH ",
    "HHHHHHHHH",
    "HHHHHHHHH",
    "         ",
    "         ",
    ------------
    "    H    ",
    "   HHH   ",
    "  HHIHH  ",
    " HHHIHHH ",
    "HHHHIHHHH",
    "HHHHIHHHH",
    "HHHHIHHHH",
    "    I    ",
    "    I    ",
    ------------
    "         ",
    "    H    ",
    "   HHH   ",
    "  HHHHH  ",
    " HHHHHHH ",
    "HHHHHHHHH",
    "HHHHHHHHH",
    "         ",
    "         ",
    ------------
    "         ",
    "         ",
    "    H    ",
    "   HHH   ",
    "  HHHHH  ",
    " HHHHHHH ",
    " HHHHHHH ",
    "         ",
    "         ",
    ------------
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
  {
    251,251,251,251,251,251,251,251,251,
    251,252,252,252,252,252,252,252,251,
    251,252,253,253,253,253,253,252,251,
    251,252,253,254,254,254,253,252,251,
    251,252,253,254,255,254,253,252,251,
    251,252,253,254,254,254,253,252,251,
    251,252,253,253,253,253,253,252,251,
    251,252,252,252,252,252,252,252,251,
    251,251,251,251,251,251,251,251,251,
  }
)

local small_id = minetest.register_schematic(small_oak)
local medium_id = minetest.register_schematic(medium_oak)
local large_id = minetest.register_schematic(large_oak)


local oak_size = {"small", "medium", "large"}
for k,id in ipairs({small_id, medium_id, large_id}) do

  minetest.register_decoration({
    name = "oak_" .. oak_size[k],
    deco_type = "schematic",
    place_on = "grass",
    biomes = {"Forgotten Fields"},
    schematic = id,
    fill_ratio = 0.01,
    place_offset_y = 1,
    flags = "place_center_x, place_center_z",
  })
end