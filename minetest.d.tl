global record minetest
  -- Everything was just dumped in as I looked down the lua_api.md
  register_alias_force: function(string, string)
  register_alis: function(string, string)
  registered_nodes: any
  register_globalstep: function(function(number))
  get_item_group: function(string, string): number
  
end

global record SimpleSoundSpec
  name: string
  gain: number
  pitch: number
  fade: number
end

global record SoundParameterTable
  gain: number
  pitch: number
  fade: number
  start_time: number
  loop: boolean
  pos: Vec3
  object: ObjectRef
  to_player: string
  max_hear_distance: number
end

global enum paramtype1
  "light"
  "none"
end

global enum paramtype2
  "flowingliquid"
  "wallmounted"
  "facedir"
  "4dir"
  "leveled"
  "degrotate"
  "meshoptions"
  "color"
  "colorfacedir"
  "color4dir"
  "colorwallmounted"
  "glasslikeliquidlevel"
  "colordegrotate"
end

global enum drawtype
  "normal"
  "airlike"
  "liquid"
  "flowingliquid"
  "glasslike"
  "glasslike_framed"
  "glasslike_framed_optional"
  "allfaces"
  "allfaces_optional"
  "torchlike"
  "signlike"
  "plantlike"
  "firelike"
  "fencelike"
  "raillike"
  "nodebox"
  "mesh"
  "plantlike_rooted"
end



global record nodebox 
  type: nodeboxtype
  fixed: boxTable
  wall_top: box
  wall_bottom: box
  wall_side: box
  connect_top: box
  connect_bottom: box
  connect_front: box
  connect_left: box
  connect_back: box
  connect_right: box
  disconnected_top: box
  disconnected_bottom: box
  disconnected_front: box
  disconnected_left: box
  disconnected_back: box
  disconnected_right: box
  disconnected: box 
  disconnected_sides: box
end

global type box = {number}

global type boxTable = {box}

global enum nodeboxtype
  "regular"
  "fixed"
  "wallmounted"
  "connected"
end

global type itemstring = string

global record ItemStack
  name: string
  count: number
  wear: number
  metadata: string
end





global record ObjectRef

end

global record Vec2
  x: number
  y: number
end

global record Vec3
  x: number
  y: number
  z: number
end