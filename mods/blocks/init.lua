local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local sound_dispatcher = get_game_sounds()
local mod_directory = minetest.get_modpath("blocks") .. "/"

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
      buildable_to = true,
      sounds = sound_dispatcher.plant_sounds(),
      groups = {
         break_instant = 1,
      },
      drop = "",
   })
end


local files = { "normal" }

for _, file in ipairs(files) do
   dofile(mod_directory .. file .. ".lua")
end
