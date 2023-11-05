global record minetest
  -- Everything was just dumped in as I looked down the lua_api.md
  register_alias_force: function(string, string)
  register_alis: function(string, string)
  registered_nodes: any
  register_globalstep: function(function(number))
  get_item_group: function(string, string): number
  get_current_modname: function(): string
  get_modpath: function(string): string
  get_modnames: function(): {string}
  get_game_info: function(): GameInfo
  get_worldpath: function(): string
  is_singleplayer: function(): boolean
  features: function(): MinetestFeatures
  has_feature: function(string): boolean
  get_player_information: function(string): PlayerInformation
  get_player_window_information: function(string): WindowInformation
  mkdir: function(string): boolean
  rmdir: function(string): boolean
  cpdir: function(string): boolean
  mvdir: function(string): boolean
  get_dir_list: function(string, boolean): {string}
  safe_file_write: function(string, string): boolean
  get_version: function(): MinetestInfo
  sha1: function(any, boolean): string
  colorspec_to_colorstring: function(DynamicColorSpec): string
  colorspec_to_bytes: function(DynamicColorSpec): string
  encode_png: function(number, number, {ColorSpec} | string, number): string
  urlencode: function(string): string
  debug: function(string)
  log: function(LogLevel, string)

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



global record NodeBox 
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

global record GameInfo
  id: string
  title: string
  author: string
  path: string
end

global record MinetestFeatures
  glasslike_framed: boolean
  nodebox_as_selectionbox: boolean
  get_all_craft_recipes_works: boolean
  use_texture_alpha: boolean
  no_legacy_abms: boolean
  texture_names_parens: boolean
  area_store_custom_ids: boolean
  add_entity_with_staticdata: boolean
  no_chat_message_prediction: boolean
  object_use_texture_alpha: boolean
  object_independent_selectionbox: boolean
  httpfetch_binary_data: boolean
  formspec_version_element: boolean
  area_store_persistent_ids: boolean
  pathfinder_works: boolean
  object_step_has_moveresult: boolean
  direct_velocity_on_players: boolean
  use_texture_alpha_string_modes: boolean
  degrotate_240_steps: boolean
  abm_min_max_y: boolean
  dynamic_add_media_table: boolean
  particlespawner_tweenable: boolean
  get_sky_as_table: boolean
  get_light_data_buffer: boolean
  mod_storage_on_disk: boolean
  compress_zstd: boolean
end

global record PlayerInformation
  address: string
  ip_version: number
  connection_uptime: number
  protocol_version: number
  formspec_version: number
  lang_code: string
  min_rtt: number
  max_rtt: number
  avg_rtt: number
  min_jitter: number
  max_jitter: number
  avg_jitter: number 
end

global record WindowInformation
  size: Vec2
  max_formspec_size: Vec2
  real_gui_scaling: number
  real_hud_scaling: number
end

global record MinetestInfo
  project: string
  string: string
  proto_min: string
  proto_max: string
  hash: string
  is_dev: boolean
end

global record ColorSpec
  a: number
  r: number
  g: number
  b: number
end

global enum LogLevel
  "none"
  "error"
  "warning"
  "action"
  "info"
  "verbose"
end

global enum TextureAlpha
  "opaque"
  "clip"
  "blend"
end

global enum LiquidType
  "none"
  "source"
  "flowing"
end

global enum NodeBoxConnections
  "top"
  "bottom"
  "front"
  "left"
  "back"
  "right"
end

global record NodeSoundSpec
  footstep: SimpleSoundSpec
  dig: SimpleSoundSpec | string
  dug: SimpleSoundSpec
  place: SimpleSoundSpec
  place_failed: SimpleSoundSpec
  fall: SimpleSoundSpec
end

global record ItemDropSpec
  tools: {string}
  rarity: number
  items: {string}
  inherit_color: boolean
  tool_groups: string | {string}
end

global record NodeDropSpec
  max_items: number
  items: {ItemDropSpec}
end

global record MapNode
  name: string
  prob: number
  param2: number
  force_place: boolean
end

global record NodeTable
  name: string
  param1: number
  param2: number
  
end

global record PointedThing
  type: string
  under: Vec3
  above: Vec3
  ref: ObjectRef
end

global record ToolCapabilities
  full_punch_interval: number
  max_drop_level: number
  groupcaps: {string : any}
  damage_groups: {string : number}
  punch_attack_uses: number
end

global record ItemSounds
  breaks: SimpleSoundSpec
  eat: SimpleSoundSpec
  punch_use: SimpleSoundSpec
  punch_use_air: SimpleSoundSpec
end


global type DynamicColorSpec = ColorSpec | number | string

global record ItemDefinition
  description: string
  short_description: string
  groups: {string: number}
  inventory_image: string
  inventory_overlay: string
  wield_image: string
  wield_overlay: string
  wield_scale: Vec3
  palette: string
  color: string
  stack_max: number
  range: number
  liquids_pointable: boolean
  light_source: number
  tool_capabilities: ToolCapabilities
  node_placement_prediction: string
  node_dig_prediction: string
  sound: SimpleSoundSpec
  on_place: function(ItemStack, ObjectRef, PointedThing)
  on_secondary_use: function(ItemStack, ObjectRef, PointedThing)
  on_drop: function(ItemStack, ObjectRef, Vec3)
  on_pickup: function(ItemStack, ObjectRef, PointedThing, number, ...: any)
  on_use: function(ItemStack, ObjectRef, PointedThing)
  after_use: function(ItemStack, ObjectRef, NodeTable, {string : any})
end

global record NodeDefinition
  drawtype: drawtype
  visual_scale: number
  tiles: {string}
  overlay_tiles: {string}
  special_tiles: {string}
  color: DynamicColorSpec
  use_texture_alpha: TextureAlpha
  palette: string
  post_effect_color: DynamicColorSpec
  post_effect_color_shaded: boolean
  paramtype: paramtype1
  paramtype2: paramtype2
  place_param2: number
  is_ground_content: boolean
  sunlight_propagates: boolean
  walkable: boolean
  pointable: boolean
  diggable: boolean
  climbable: boolean
  move_resistance: number
  buildable_to: boolean
  floodable: boolean
  liquidtype: LiquidType
  liquid_alternative_flowing: string
  liquid_alternative_source: string
  liquid_viscosity: number
  liquid_renewable: boolean
  liquid_move_physics: boolean
  leveled: number
  leveled_max: number
  liquid_range: number
  drowning: number
  damage_per_second: number
  node_box: NodeBox
  connects_to: {string}
  connect_sides: NodeBoxConnections
  mesh: string
  selection_box: NodeBox
  collision_box: NodeBox
  legacy_facedir_simple: boolean
  legacy_wallmounted: boolean
  waving: number
  sounds: NodeSoundSpec
  drop: NodeDropSpec | string
  on_construct: function(Vec3)
  on_destruct: function(Vec3)
  after_destruct: function(Vec3, MapNode)
  on_flood: function(Vec3, NodeTable, NodeTable)
  preserve_metadata: function(Vec3, NodeTable, NodeTable, {ItemStack})
  after_place_node: function(Vec3, ObjectRef, ItemStack, PointedThing)
  after_dig_node: function(Vec3, NodeTable, string, ObjectRef)
  can_dig: function(Vec3, ObjectRef | string) -- Unknown, documentation doesn't say
  on_punch: function(Vec3, NodeTable, ObjectRef, PointedThing)
  on_rightclick: function(Vec3, NodeTable, ObjectRef, ItemStack, PointedThing)
  on_dig: function(Vec3, NodeTable, ObjectRef)
  on_timer: function(Vec3, number)
  on_receive_fields: function(Vec3, string, {string : any}, ObjectRef)
  allow_metadata_inventory_move: function(Vec3, string, number, string, number, number, ObjectRef)
  allow_metadata_inventory_put: function(Vec3, string, number, ItemStack, ObjectRef)
  allow_metadata_inventory_take: function(Vec3, string, number, ItemStack, ObjectRef)
  on_metadata_inventory_move: function(Vec3, string, number, string, number, string, ObjectRef)
  on_metadata_inventory_put: function(Vec3, string, number, ItemStack, ObjectRef)
  on_metadata_inventory_take: function(Vec3, string, number, ItemStack, ObjectRef)
  on_blast: function(Vec3, number)
  mod_origin: string
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