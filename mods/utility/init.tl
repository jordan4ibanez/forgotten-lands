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
global function generate_schematic(size: Vec3, keys: {string : string}, force_place: {string: boolean}, data: string, yslice_prob: {number}): SchematicDefinition
  local new_schematic = {
    size = size,
    data = {},
    yslice_prob = {}
  }
  local length = #data
  local countdown = length
  for _ = 1, length do
    local databit = data:sub(countdown,countdown)
    local element = {name = keys[databit], force_place = false}
    if force_place[databit] then
      element.force_place = true
    end
    table.insert(new_schematic.data, element)
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

global function random_range(min: number, max: number): number
  return (math.random() * (max - min) + min)
end

local rr = random_range

function vector.random(min_x: number, max_x: number, min_y: number, max_y: number, min_z: number, max_z: number): Vec3
  return vector.new(
    rr(min_x, max_x),
    rr(min_y, max_y),
    rr(min_z, max_z)
  )
end