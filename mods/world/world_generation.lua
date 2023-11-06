local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local table = _tl_compat and _tl_compat.table or table
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
   node_stone = "stone",
})


do
   local grass = {}
   for i = 1, 5 do
      local height = tostring(i)
      table.insert(grass, "tall_grass_" .. height)
   end

   minetest.register_decoration({
      deco_type = "simple",
      place_on = "grass",
      biomes = { "Forgotten Fields" },
      decoration = grass,
      param2 = 0,
      param2_max = 239,
      fill_ratio = 0.98,
   })
end


do
   minetest.register_decoration({
      name = "apple_tree_creator",
      deco_type = "simple",
      place_on = "grass",
      biomes = { "Forgotten Fields" },
      decoration = "apple_tree_creator",
      fill_ratio = 0.01,
   })
   local decoration_id = minetest.get_decoration_id("apple_tree_creator")
   print(decoration_id)
   minetest.set_gen_notify("decoration", { decoration_id })
   local apple_tree = {
      axiom = "FFFFFFF",
      trunk = "sand",
      leaves = "gravel",
      angle = 30,
      iterations = 1,
      random_level = 0,
      trunk_type = "single",
      fruit_chance = 10,
      fruit = "stone",
   }

   local id = minetest.get_content_id("apple_tree_creator")

   minetest.register_on_generated(function(min, max)
      local mapgen = minetest.get_mapgen_object("gennotify")
      local iteration = mapgen["decoration#1"]
      if (iteration == nil) then return end
      for _, v in ipairs(iteration) do
         print(dump(v))
      end
   end)










end
