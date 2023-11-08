local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; function switch(input, ...)
   local tableized = { ... }
   for k, v in ipairs(tableized) do
      if ((k + 1) % 2 == 0) then
         if (input == v or v == "else") then
            local foundType = type(tableized[k + 1])
            if (foundType == "function") then
               return (tableized[k + 1])(input)
            else
               return tableized[k + 1]
            end
         end
      end
   end
end

local switch = switch

function println(...)
   local builder = ""
   for _, val in ipairs({ ... }) do
      builder = builder .. switch(type(val),
      "string", val,
      "number", function() return tostring(val) end,
      "table", function() return dump(val) end,
      "userdata", function()
         local thing = val
         if (thing:is_player()) then return thing:get_player_name() end
         return thing.name
      end,
      "else", function(input) print("failure:", input); return "" end)

   end
   print(builder)
end



function generate_schematic(size, keys, force_place, data, yslice_prob)
   local new_schematic = {
      size = size,
      data = {},
      yslice_prob = {},
   }
   local length = #data
   local countdown = length
   for _ = 1, length do
      local databit = data:sub(countdown, countdown)
      local element = { name = keys[databit], force_place = false }
      if force_place[databit] then
         element.force_place = true
      end
      table.insert(new_schematic.data, element)
      countdown = countdown - 1
   end
   for _, databit in ipairs(yslice_prob) do
      table.insert(new_schematic.yslice_prob, { prob = databit })
   end
   return new_schematic
end

function concat(...)
   local accumulator = ""
   for _, v in ipairs({ ... }) do
      accumulator = accumulator .. v
   end
   return accumulator
end

function random_range(min, max)
   return (math.random() * (max - min) + min)
end

local rr = random_range

function vector.random(min_x, max_x, min_y, max_y, min_z, max_z)
   return vector.new(
   rr(min_x, max_x),
   rr(min_y, max_y),
   rr(min_z, max_z))

end