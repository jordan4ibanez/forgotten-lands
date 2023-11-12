local sound_dispatcher: GameSoundDispatcher = get_game_sounds()
local mod_directory = minetest.get_modpath("blocks") .. "/"

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


local files = {"normal"}

for _,file in ipairs(files) do
  dofile(mod_directory .. file .. ".lua")
end
