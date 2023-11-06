local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs

function println(...) end


function switch(input, ...)
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
      "else", function(input) print(input); return "" end)

   end
   print(builder)
end



minetest.register_globalstep(function(_delta)
   local blah = minetest.get_player_by_name("singleplayer")
   println("hi there\n",
   "this is a test\n",
   "of the thing\n", 1234, "\n", blah, "\n", { "test", 123, test = "hi" })
end)
