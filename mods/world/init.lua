local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local files_to_load = {
   "blocks",
   "world_generation",
}

local mod_directory = minetest.get_modpath("world") .. "/"
for _, k in ipairs(files_to_load) do
   dofile(mod_directory .. k .. ".lua")
end
