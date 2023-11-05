global record minetest
  -- Everything was just dumped in as I looked down the lua_api.md
  register_alias_force: function(string, string)
  register_alis: function(string, string)
  registered_nodes: any


  register_globalstep: function(function(number))

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
  normal
  airlike
  liquid
  flowingliquid
  glasslike
  glasslike_framed
  glasslike_framed_optional
  allfaces
  allfaces_optional
  torchlike
  signlike
  plantlike
  firelike
  fencelike
  raillike
  nodebox
  mesh
  plantlike_rooted
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