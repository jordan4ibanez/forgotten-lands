

global function println(...: any) end


global function switch(input: any, ...: any | function(any): any): any
  local tableized = {...}
  for k,v in ipairs(tableized) do
    if ((k + 1) % 2 == 0) then
      if (input == v or v == "else") then
        local foundType = type(tableized[k + 1])
        if (foundType == "function") then
          return (tableized[k + 1] as function)(input)
        else
          return tableized[k + 1]
        end
      end
    end
  end
end

local switch = switch

global function println(...: any)
  local builder: string = ""
  for _,val in ipairs({...}) do
    builder = builder .. switch(type(val), 
      "string", val,
      "number", function(): string return tostring(val) end,
      "table", function(): string return dump(val) end,
      "userdata", function(): string
        local thing = val as ObjectRef
        if (thing:is_player()) then return thing:get_player_name() end
        return thing.name
      end,
      "else", function(input: any): string print("failure:",input) return "" end
    ) as string
  end
  print(builder)
end



-- minetest.register_globalstep(function(_delta: number)
--   local blah: ObjectRef = minetest.get_player_by_name("singleplayer")
--   println(
--     "hi there\n",
--     "this is a test\n",
--     "of the thing\n", 
--     1234, "\n", 
--     blah, "\n", 
--     {"test", 123, test = "hi"}
--   )
-- end)