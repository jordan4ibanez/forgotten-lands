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
})

for i = 1, 5 do
   local height = tostring(i)
   minetest.register_node(":tall_grass_" .. height, {
      drawtype = "plantlike",
      walkable = false,
      paramtype = "light",
      paramtype2 = "degrotate",
      tiles = {
         "default_grass_" .. height .. ".png",
      },
   })
end

minetest.register_node(":apple_tree_creator", {
   drawtype = "airlike",
   walkable = false,
   paramtype = "light",
   on_timer = function(pos)
      print(dump(pos))
   end,
})
