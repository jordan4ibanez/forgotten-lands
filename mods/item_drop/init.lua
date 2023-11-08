local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs

function minetest.handle_node_drops(pos, drops, _digger)












   for _, drop in ipairs(drops) do
      local item = minetest.add_item(pos, drop)
      if item then
         (item):add_velocity(
         vector.random(
         -1, 1,
         1, 2,
         -1, 1))


      end
   end
end
