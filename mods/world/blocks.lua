local sound_dispatcher = get_game_sounds()

minetest.register_node(":stone", {
   drawtype = "normal",
   tiles = {
      "default_stone.png",
      "default_stone.png",
      "default_stone.png",
      "default_stone.png",
      "default_stone.png",
      "default_stone.png",
   },

   groups = {
      stone = 1,
   },
})

minetest.register_node(":dirt", {
   drawtype = "normal",
   tiles = {
      "default_dirt.png",
      "default_dirt.png",
      "default_dirt.png",
      "default_dirt.png",
      "default_dirt.png",
      "default_dirt.png",
   },

   groups = {
      soil = 1,
   },
})

minetest.register_node(":grass", {
   drawtype = "normal",
   tiles = {
      "default_grass.png",
      "default_dirt.png",
      "default_dirt.png^default_grass_side.png",
      "default_dirt.png^default_grass_side.png",
      "default_dirt.png^default_grass_side.png",
      "default_dirt.png^default_grass_side.png",
   },
   sounds = sound_dispatcher.grass_sounds(),
   groups = {
      soil = 1,
   },
})

minetest.register_node(":sand", {
   drawtype = "normal",
   tiles = {
      "default_sand.png",
      "default_sand.png",
      "default_sand.png",
      "default_sand.png",
      "default_sand.png",
      "default_sand.png",
   },

   groups = {
      soil = 1,
   },
})

minetest.register_node(":gravel", {
   drawtype = "normal",
   tiles = {
      "default_gravel.png",
      "default_gravel.png",
      "default_gravel.png",
      "default_gravel.png",
      "default_gravel.png",
      "default_gravel.png",
   },

   groups = {
      soil = 1,
   },
})

minetest.register_node(":oak_tree", {
   drawtype = "normal",
   tiles = {
      "default_tree_top.png",
      "default_tree_top.png",
      "default_tree.png",
      "default_tree.png",
      "default_tree.png",
      "default_tree.png",
   },

   groups = {
      wooden = 1,
   },
})

minetest.register_node(":oak_leaves", {
   drawtype = "allfaces_optional",
   paramtype = "light",
   waving = 1,
   tiles = {
      "default_leaves.png",
   },

   groups = {
      leafy = 1,
   },
})

for i = 1, 5 do
   local height = tostring(i)
   minetest.register_node(":tall_grass_" .. height, {
      drawtype = "plantlike",
      walkable = false,
      waving = 1,
      paramtype = "light",
      paramtype2 = "degrotate",
      tiles = {
         "default_grass_" .. height .. ".png",
      },

      groups = {
         break_instant = 1,
      },
   })
end
