local sound_dispatcher: GameSoundDispatcher = get_game_sounds()

minetest.register_node(":stone", {
  drawtype = "normal",
  tiles = {
    "default_stone.png",
    "default_stone.png",
    "default_stone.png",
    "default_stone.png",
    "default_stone.png",
    "default_stone.png"
  },
  sounds = sound_dispatcher.stone_sounds(),
  groups = { stone = 1 }
})

minetest.register_node(":dirt", {
  drawtype = "normal",
  tiles = {
    "default_dirt.png",
    "default_dirt.png",
    "default_dirt.png",
    "default_dirt.png",
    "default_dirt.png",
    "default_dirt.png"
  },
  sounds = sound_dispatcher.dirt_sounds(),
  groups = { soil = 1 }
})

minetest.register_node(":grass", {
  drawtype = "normal",
  tiles = {
    "default_grass.png",
    "default_dirt.png",
    "default_dirt.png^default_grass_side.png",
    "default_dirt.png^default_grass_side.png",
    "default_dirt.png^default_grass_side.png",
    "default_dirt.png^default_grass_side.png"
  },
  groups = {break_instant = 1},
  sounds = sound_dispatcher.grass_sounds()
})

minetest.register_node(":sand", {
  drawtype = "normal",
  tiles = {
    "default_sand.png",
    "default_sand.png",
    "default_sand.png",
    "default_sand.png",
    "default_sand.png",
    "default_sand.png"
  },
  sounds = sound_dispatcher.sand_sounds(),
  groups = { soil = 1 }
})

minetest.register_node(":gravel", {
  drawtype = "normal",
  tiles = {
    "default_gravel.png",
    "default_gravel.png",
    "default_gravel.png",
    "default_gravel.png",
    "default_gravel.png",
    "default_gravel.png"
  },
  sounds = sound_dispatcher.gravel_sounds(),
  groups = { soil = 1}
})

minetest.register_node(":oak_tree", {
  drawtype = "normal",
  tiles = {
    "default_tree_top.png",
    "default_tree_top.png",
    "default_tree.png",
    "default_tree.png",
    "default_tree.png",
    "default_tree.png"
  },
  groups = { wooden = 1 },
  sounds = sound_dispatcher.wood_sounds()
})

minetest.register_node(":oak_leaves", {
  drawtype = "allfaces_optional",
  tiles = {
    "default_leaves.png",
    "default_leaves.png",
    "default_leaves.png",
    "default_leaves.png",
    "default_leaves.png",
    "default_leaves.png"
  },
  groups = { leafy = 1 },
  sounds = sound_dispatcher.grass_sounds()
})

for i = 1,5 do
  local height: string = tostring(i)
  minetest.register_node(":tall_grass_" .. height, {
    drawtype = "plantlike",
    walkable = false,
    paramtype = "light",
    paramtype2 = "degrotate",
    tiles = {
      "default_grass_" .. height .. ".png",
    },
    sounds = sound_dispatcher.grass_sounds({dug = {name = "", gain = 0}}),
    groups = {break_instant = 1}
  })
end
