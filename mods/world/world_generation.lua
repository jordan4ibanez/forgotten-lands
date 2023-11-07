local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local table = _tl_compat and _tl_compat.table or table
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
