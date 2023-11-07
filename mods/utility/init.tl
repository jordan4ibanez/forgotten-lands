

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


-- Create a 3D schematic from ascii art "scans". Note, everything created by this is actually inside out!
global function generate_schematic(size: Vec3, keys: {string : string}, data: string, yslice_prob: {number}): SchematicDefinition
  local new_schematic = {
    size = size,
    data = {},
    yslice_prob = {}
  }
  local length = #data
  local countdown = length
  for _ = 1, length do
    local databit = data:sub(countdown,countdown)
    table.insert(new_schematic.data, {name = keys[databit]})
    countdown = countdown - 1
  end
  for _,databit in ipairs(yslice_prob) do
    table.insert(new_schematic.yslice_prob, {prob = databit})
  end
  return new_schematic
end

global function concat(...: string): string
  local accumulator = ""
  for _,v in ipairs({...}) do
    accumulator = accumulator .. v
  end
  return accumulator
end