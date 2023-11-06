local files_to_load = {
  "blocks",
  "world_generation"
}

do 
  local mod_directory = minetest.get_modpath("world") .. "/"
  for _,k in ipairs(files_to_load) do
    dofile(mod_directory .. k .. ".lua")
  end
end