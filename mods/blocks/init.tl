local sound_dispatcher: GameSoundDispatcher = get_game_sounds()

for i = 1,5 do
  local height: string = tostring(i)
  minetest.register_node(":tall_grass_" .. height, {
    drawtype = "plantlike",
    walkable = false,
    waving = 1,
    paramtype = "light",
    paramtype2 = "degrotate",
    tiles = {
      "default_grass_" .. height .. ".png",
    },
    buildable_to = true,
    sounds = sound_dispatcher.plant_sounds(),
    groups = {
      break_instant = 1
    },
    drop = ""
  })
end

minetest.register_node(":glass", {
	drawtype = "glasslike_framed_optional",
	tiles = {
    "default_glass.png",
    "default_glass_detail.png"
  },
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
  sounds = sound_dispatcher.glass_sounds(),
	groups = {
    glass = 1
  },
  drop = "",
})

