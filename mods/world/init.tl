local files_to_load = {
  "blocks",
  "world_generation"
}

local mod_directory = minetest.get_modpath("world") .. "/"
for _,k in ipairs(files_to_load) do
  dofile(mod_directory .. k .. ".lua")
end

local inPos1 = false
local inPos2 = false
local pos1: Vec3 = vector.new(0,0,0)
local pos2: Vec3 = vector.new(0,0,0)

minetest.register_chatcommand("pos1", {
  func = function()
    inPos1 = true
  end
})

minetest.register_chatcommand("pos2", {
  func = function()
    inPos2 = true
  end
})



local schem = generate_schematic(
  vector.new(5,5,5),
  {
    [" "] = "air",
    ["I"] = "oak_tree",
    ["H"] = "oak_leaves"
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

minetest.register_chatcommand("DO", {
  func = function()
    local pos = minetest.get_player_by_name("singleplayer"):get_pos()
    minetest.place_schematic(pos, schem)
  end
})


minetest.register_on_punchnode(function(newpos: Vec3)
  if (inPos1) then
    pos1.x = newpos.x
    pos1.y = newpos.y
    pos1.z = newpos.z
    inPos1 = false
    print("pos1 is ", pos1.x, pos1.y, pos1.z)
  end
  if (inPos2) then
    pos2.x = newpos.x
    pos2.y = newpos.y
    pos2.z = newpos.z
    inPos2 = false
    print("pos2 is ", pos2.x, pos2.y, pos2.z)
  end
end)

-- local pathy = minetest.get_worldpath() .. "/"
-- local thing = minetest.read_schematic(pathy .. "oak_small.mts")

-- print(dump(thing))