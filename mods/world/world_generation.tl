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


do
  minetest.register_decoration({
    name = "apple_tree_creator",
    deco_type = "simple",
    place_on = "grass",
    biomes = {"Forgotten Fields"},
    decoration = "apple_tree_creator",
    fill_ratio = 0.01
  })
  local decoration_id: number = minetest.get_decoration_id("apple_tree_creator")
  print(decoration_id)
  minetest.set_gen_notify("decoration", {decoration_id})
  local apple_tree: TreeDefinition = {
    axiom = "FFFFFFF",
    trunk = "sand",
    leaves = "gravel",
    angle = 30,
    iterations = 1,
    random_level = 0,
    trunk_type = "single",
    fruit_chance = 10,
    fruit = "stone"
  }

  local id: number = minetest.get_content_id("apple_tree_creator")

  minetest.register_on_generated(function()
    local mapgen: GenNotifyObject = minetest.get_mapgen_object("gennotify")
    local iteration = mapgen["decoration#1"]
    if (iteration == nil) then return end
    for _,pos in ipairs(iteration) do
      minetest.get_node_timer(pos):start(math.random() * 10)
    end
  end)
  -- minetest.register_lbm({
  --   label = "apple_tree_creator",
  --   name = ":apple_tree_creator",
  --   nodenames = {"apple_tree_creator"},
  --   run_at_every_load = true,
  --   action = function(pos: Vec3)
  --     minetest.remove_node(pos)
  --     minetest.spawn_tree(pos, apple_tree)
  --   end
  -- })
end