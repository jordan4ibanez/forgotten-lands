-- Everything was just dumped in as I looked down the lua_api.md
global record minetest
  registered_nodes: {NodeDefinition}
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
  register_node: function(string, NodeDefinition)
  register_craftitem: function(string, ItemDefinition)
  register_tool: function(string, ItemDefinition)
  override_item: function(string: {any : any})
  unregister_item: function(string)
  register_entity: function(string, EntityDefinition)
  register_abm: function(ABMDefinition)
  register_lbm: function(LBMDefinition)
  register_alias: function(string, string)
  register_alias_force: function(string, string)
  register_ore: function(OreDefinition)
  register_biome: function(BiomeDefinition)
  unregister_biome: function(string)
  register_decoration: function(DecorationDefinition)
  register_schematic: function(SchematicDefinition)
  clear_registered_biomes: function()
  clear_registered_decorations: function()
  clear_registered_ores: function()
  clear_registered_schematics: function()
  register_craft: function(CraftRecipeDefinition)
  clear_craft: function(CraftRecipeDefinition)
  register_chatcommand: function(string, ChatCommandDefinition)
  override_chatcommand: function(string, ChatCommandDefinition)
  unregister_chatcommand: function(string)
  register_privilege: function(string, PrivilegeDefinition)
  register_authentication_handler: function(AuthenticationHandlerDefinition)
  register_globalstep: function(function(number))
  register_on_mods_loaded: function(function())
  register_on_shutdown: function(function())
  register_on_placenode: function(function(Vec3, NodeTable, ObjectRef, NodeTable, ItemStack, PointedThing))
  register_on_dignode: function(function(Vec3, NodeTable, ObjectRef))
  register_on_punchnode: function(function(Vec3, NodeTable, ObjectRef, PointedThing))
  register_on_generated: function(function(Vec3, Vec3, number))
  register_on_newplayer: function(function(ObjectRef))
  register_on_punchplayer: function(function(ObjectRef, ObjectRef, number, ToolCapabilities, Vec3, number))
  register_on_rightclickplayer: function(function(ObjectRef, ObjectRef))
  register_on_player_hpchange: function(function(ObjectRef, number, HPChangeReasonDefinition), boolean)
  register_on_dieplayer: function(function(ObjectRef, HPChangeReasonDefinition))
  register_on_respawnplayer: function(function(ObjectRef))
  
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

global enum EntityVisual
  "cube"
  "sprite"
  "upright_sprite"
  "mesh"
  "wielditem"
  "item"
end

global record Collision
  type: string
  axis: string
  node_pos: Vec3
  object: ObjectRef
  old_velocity: Vec3
  new_velocity: Vec3
end

global record MoveResult
  touching_ground: boolean
  collides: boolean
  standing_on_object: boolean
  collisions: {Collision}
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

global record EntityDefinition
  hp_max: number
  breath_max: number
  zoom_fov: number
  eye_height: number
  physical: boolean
  collide_with_objects: boolean
  collisionbox: {number}
  selectionbox: {number}
  pointable: boolean
  visual: EntityVisual
  visual_size: Vec3
  mesh: string
  textures: {string}
  colors: {DynamicColorSpec}
  use_texture_alpha: boolean
  spritediv: Vec2
  initial_sprite_basepos: Vec2
  is_visible: boolean
  makes_footstep_sound: boolean
  automatic_rotate: number
  stepheight: number
  automatic_face_movement_dir: number
  automatic_face_movement_max_rotation_per_sec: number
  backface_culling: boolean
  glow: number
  nametag: string
  nametag_color: ColorSpec
  nametag_bgcolor: ColorSpec
  infotext: string
  static_save: boolean
  damage_texture_modifier: string
  shaded: boolean
  show_on_minimap: boolean
  on_activate: function(LuaEntity, string, number)
  on_deactivate: function(LuaEntity, boolean)
  on_step: function(LuaEntity, number, MoveResult)
  on_punch: function(LuaEntity, ObjectRef, number, ToolCapabilities, Vec3, number)
  on_death: function(LuaEntity, ObjectRef)
  on_rightclick: function(LuaEntity, ObjectRef)
  on_attach_child: function(LuaEntity, ObjectRef)
  on_detach_child: function(LuaEntity, ObjectRef)
  on_detach: function(LuaEntity, ObjectRef)
  get_staticdata: function(LuaEntity)
end

global record ABMDefinition
  label: string
  nodenames: {string}
  neighbors: {string}
  interval: number
  chance: number
  min_y: number
  max_y: number
  catch_up: number
  action: function(Vec3, NodeTable, number, number)
end

global record LBMDefinition
  label: string
  name: string
  nodenames: {string}
  run_at_every_load: boolean
  action: function(Vec3, NodeTable, number)
end

global record SchematicData
  name: string
  param1: number
  param2: number
end
global record SchematicProbability
  ypos: number
  prob: number
end

global record SchematicDefinition
  size: Vec3
  data: {SchematicData}
  yslice_prob: {SchematicProbability}
end

global enum OreType
  "scatter"
  "sheet"
  "puff"
  "blob"
  "vein"
  "stratum"
end

global enum OreFlags
  "puff_cliffs"
  "puff_additive_composition"
end

global enum NoiseFlags
  "defaults"
  "eased"
  "absvalue"
end

global record NoiseParams
  offset: number
  scale: number
  spread: Vec3
  seed: number
  octaves: number
  persistence: number
  lacunarity: number
  flags: NoiseFlags
end

global record OreDefinition
  ore_type: OreType
  ore: string
  ore_param2: number
  wherein: string
  clust_scarcity: number
  clust_num_ores: number
  clust_size: number
  y_min: number
  y_max: number
  flags: OreFlags
  noise_threshold: number
  noise_params: NoiseParams
  biomes: {string}
  column_height_min: number
  column_height_max: number
  column_midpoint_factor: number
  np_puff_top: NoiseParams
  np_puff_bottom: NoiseParams
  random_factor: number
  np_stratum_thickness: NoiseParams
  stratum_thickness: number
end

global record BiomeDefinition
  name: string
  node_dust: string
  node_top: string
  depth_top: number
  node_filler: string
  depth_filler: number
  node_stone: string
  node_water_top: string
  depth_water_top: number
  node_water: string
  node_river_water: string
  node_riverbed: string
  depth_riverbed: number
  node_cave_liquid: string | {string}
  node_dungeon: string
  node_dungeon_alt: string
  node_dungeon_stair: string
  y_max: number
  y_min: number
  max_pos: Vec3
  min_pos: Vec3
  vertical_blend: number
  heat_point: number
  humidity_point: number
end


global enum DecorationType
  "simple"
  "schematic"
end

global enum DecorationFlags
  "liquid_surface"
  "force_placement"
  "all_floors"
  "all_ceilings"
  "place_center_x"
  "place_center_y"
  "place_center_z"
end

global record DecorationDefinition
  deco_type: DecorationType
  place_on: string
  sidelen: number
  fill_ratio: number
  noise_params: NoiseParams
  biomes: {string}
  y_min: number
  y_max: number
  spawn_by: string
  check_offset: number
  num_spawn_by: number
  flags: DecorationFlags
  decoration: string
  height: number
  height_max: number
  param2: number
  param2_max: number
  place_offset_y: number
  schematic: string | SchematicDefinition
  replacements: {string : string}
  rotation: string
end

global enum CraftRecipeType
  "shapless"
  "toolrepair"
  "cooking"
  "fuel"
end

global record CraftRecipeDefinition
  type: CraftRecipeType
  output: string
  recipe: {string} | string
  replacements: {string}
  additional_wear: number
  cooktime: number
  burntime: number
end

global record ChatCommandDefinition
  params: string
  description: string
  privs: {string}
  func: function(string, string)
end

global record PrivilegeDefinition
  description: string
  give_to_singleplayer: boolean
  give_to_admin: boolean
  on_grant: function(string, string)
  on_revoke: function(string, string)
end

global record AuthenticationHandlerDefinition
  get_auth: function(string)
  create_auth: function(string, string)
  delete_auth: function(string)
  set_password: function(string, string)
  set_privileges: function(string, {string})
  reload: function()
  record_login: function(string)
  iterate: function()
end


global enum HPChangeReasonType
  "set_hp"
  "punch"
  "fall"
  "node_damage"
  "drown"
  "respawn"
end

global record HPChangeReasonDefinition
  type: HPChangeReasonType
  node: string
  node_pos: Vec3
  object: ObjectRef
  from: string
end

global record ObjectRef

end

global record LuaEntity

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