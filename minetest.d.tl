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
  register_on_prejoinplayer: function(function(string, string))
  register_on_joinplayer: function(function(ObjectRef, string))
  register_on_leaveplayer: function(function(ObjectRef, boolean))
  register_on_authplayer: function(function(string, string, boolean))
  register_on_auth_fail: function(function(string, string))
  register_on_cheat: function(function(ObjectRef, CheatDefinition))
  register_on_chat_message: function(function(string, string))
  register_on_chatcommand: function(function(string, string, string): boolean)
  register_on_player_receive_fields: function(function(ObjectRef, string, {string : any}))
  register_on_craft: function(function(ItemStack, ObjectRef, {any}, string))
  register_craft_predict: function(function(ItemStack, ObjectRef, {any}, string))
  register_allow_player_inventory_action: function(function(ObjectRef, string, string, ActionDefinition))
  register_on_player_inventory_action: function(function(ObjectRef, string, string, ActionDefinition))
  register_on_protection_violation: function(function(Vec3, string))
  register_on_item_eat: function(function(number, boolean, ItemStack, ObjectRef, PointedThing))
  register_on_item_pickup: function(function(ItemStack, ObjectRef, PointedThing, number, ...: any))
  register_on_priv_grant: function(function(string, string, string))
  register_on_priv_revoke: function(function(string, string, string))
  register_can_bypass_userlimit: function(function(string, string))
  register_on_modchannel_message: function(function(string, string, string))
  register_on_liquid_transformed: function(function({Vec3}, {string}))
  register_on_mapblocks_changed: function(function({string}, number))
  settings: MinetestSettingsObject
  setting_get_pos: function(string): Vec3
  string_to_privs: function(string, string): string
  privs_to_string: function(string, string): string
  get_player_privs: function(string): {string}
  check_player_privs: function(ObjectRef | string, string | {string}): boolean | {boolean}
  check_password_entry: function(string, string, string): boolean
  get_password_hash: function(string, string): string
  get_player_ip: function(string): string
  get_auth_handler: function(): AuthenticationHandlerDefinition
  notify_authentication_modified: function(string)
  set_player_password: function(string, string)
  set_player_privs: function(string, {string : boolean})
  auth_reload: function()
  chat_send_all: function(string)
  chat_send_player: function(string, string)
  format_chat_message: function(string, string)
  set_node: function(Vec3, NodeTable)
  add_node: function(Vec3, NodeTable)
  bulk_set_node: function({Vec3}, NodeTable)
  swap_node: function(Vec3, NodeTable)
  remove_node: function(Vec3)
  get_node: function(Vec3): NodeTable
  get_node_or_nil: function(Vec3): NodeTable | nil
  get_node_light: function(Vec3, number): number
  get_natural_light: function(Vec3: number): number
  get_artificial_light: function(number): number
  place_node: function(Vec3, NodeTable)
  dig_node: function(Vec3): boolean
  punch_node: function(Vec3)
  spawn_falling_node: function(Vec3): {boolean, ObjectRef} | boolean
  find_nodes_with_meta: function(Vec3, Vec3): {Vec3}
  get_meta: function(Vec3): MetaData
  get_node_timer: function(Vec3): number
  add_entity: function(Vec3, string, string): ObjectRef | nil
  add_item: function(Vec3, ItemStack | string): ObjectRef | nil
  get_player_by_name: function(string): ObjectRef
  get_objects_inside_radius: function(Vec3, number): {ObjectRef}
  get_objects_in_area: function(Vec3, Vec3): {ObjectRef}
  set_timeofday: function(number)
  get_timeofday: function(): number
  get_gametime: function(): number
  get_day_count: function(): number
  find_node_near: function(Vec3, number, {string}, boolean): Vec3 | nil
  find_nodes_in_area: function(Vec3, Vec3, {string}, boolean): {any}
  find_nodes_in_area_under_air: function(Vec3, Vec3, {string}): {Vec3}
  get_perlin: function(NoiseParams): PerlinNoiseObject
  get_perlin: function(number, number, number, number): PerlinNoiseObject
  get_voxel_manip: function(Vec3, Vec3): VoxelManipObject
  set_gen_notify: function(GenNotifyFlags, {number})
  get_gen_notify: function(): {number}
  get_decoration_id: function(string): number
  get_mapgen_object: function(string): MapGenObjectDefinition
  get_heat: function(Vec3): number
  get_humidity: function(Vec3): number
  get_biome_data: function(Vec3): BiomeDataDefinition | nil
  get_biome_id: function(string): number
  get_biome_name: function(number): string
  get_mapgen_setting: function(string): MapGenSettingsDefinition
  set_mapgen_params: function(MapGenSettingsDefinition)
  get_mapgen_edges: function(number, number)
  get_mapgen_setting: function(string): MapGenSettingsDefinition
  get_mapgen_setting_noiseparams: function(string): NoiseParams
  set_mapgen_setting: function(string, any, boolean)
  set_noiseparams: function(string, NoiseParams, boolean)
  get_noiseparams: function(string): NoiseParams
  generate_ores: function(VoxelManipObject, Vec3, Vec3)
  generate_decorations: function(VoxelManipObject, Vec3, Vec3)
  clear_objects: function(ClearObjectsOptions)
  load_area: function(Vec3, Vec3)
  emerge_area: function(Vec3, Vec3, EmergeAreaCallback, any)
  delete_area: function(Vec3, Vec3)
  line_of_sight: function(Vec3, Vec3): {boolean, Vec3}
  raycast: function(Vec3, Vec3, boolean, boolean): RaycastObject
  find_path: function(Vec3, Vec3, number, number, number, SearchAlgorithm)
  spawn_tree: function(Vec3, TreeDefinition)
  transforming_liquid_add: function(Vec3)
  get_node_max_level: function(Vec3): number
  get_node_level: function(Vec3): number
  set_node_level: function(Vec3, number): number
  add_node_level: function(Vec3, number): number
  fix_light: function(Vec3, Vec3): boolean
  check_single_for_falling: function(Vec3)
  check_for_falling: function(Vec3)
  get_spawn_level: function(number, number)
  mod_channel_join: function(string)
  get_inventory: function(Vec3): InvRef
  get_perlin_map: function(NoiseParams, Vec3): PerlinNoiseMapObject
  get_inventory: function(Vec3): InvRef
  create_detached_inventory: function(string, DetachedInventoryCallbacks, string): InvRef
  remove_detached_inventory: function(string): boolean
  do_item_eat: function(number, ItemStack, ItemStack, ObjectRef, PointedThing): ItemStack | nil
  show_formspec: function(string, string, Formspec)
  close_formspec: function(string, string)
  formspec_escape: function(string): string
  explode_table_event: function(string): {any : any}
  explode_textlist_event: function(string): {any : any}
  explode_scrollbar_event: function(string): {any : any}
  inventorycube: function(string, string, string): string
  get_pointed_thing_position: function(PointedThing, boolean): Vec3 | nil
  dir_to_facedir: function(Vec3, boolean): number
  facedir_to_dir: function(number): Vec3
  dir_to_fourdir: function(Vec3): number
  fourdir_to_dir: function(number): Vec3
  dir_to_wallmounted: function(Vec3): number
  wallmounted_to_dir: function(number): Vec3
  dir_to_yaw: function(Vec3): number
  yaw_to_dir: function(number): Vec3
  is_colored_paramtype: function(number): boolean
  strip_param2_color: function(number, paramtype2): number | nil
  get_node_drops: function(string | NodeTable, string): {string}
  get_craft_result: function(CraftRecipeDefinition): {ItemStack, ItemStack}
  get_craft_recipe: function(string | NodeTable): CraftRecipeDefinition | nil
  get_all_craft_recipes: function(string | NodeTable): {CraftRecipeDefinition} | nil
  handle_node_drops: function(Vec3, {string}, ObjectRef)
  itemstring_with_palette: function(ItemStack, number): string
  itemstring_with_color: function(ItemStack, DynamicColorSpec): string
  rollback_get_node_actions: function(Vec3, number, number, number): {Rollback}
  rollback_revert_actions_by: function(string, number): {boolean, string}
  item_place_node: function(ItemStack, ObjectRef, PointedThing, number, boolean): ItemStack, Vec3
  item_place_object: function(ItemStack, ObjectRef, PointedThing): ItemStack
  item_place: function(ItemStack, ObjectRef, PointedThing, number)
  item_pickup: function(ItemStack, ObjectRef, PointedThing, number, ...: any): ItemStack
  item_drop: function(ItemStack, ObjectRef, Vec3): ItemStack
  item_eat: function(number, string)
  node_punch: function(Vec3, NodeTable, ObjectRef, PointedThing)
  node_dig: function(Vec3, NodeTable, ObjectRef)
  after: function(number, function, ...: any): Job
  handle_async: function(function, function, ...: any)
  register_async_dofile: function(string)
  request_shutdown: function(string, boolean, number)
  cancel_shutdown_requests: function()
  get_server_status: function(string, boolean)
  get_server_uptime: function(): number
  get_server_max_lag: function(): number
  remove_player: function(string): number
  remove_player_auth: function(string): boolean
  dynamic_add_media: function(DynamicAddMediaOptions, function(string))
  get_ban_list: function(): string
  get_ban_description: function(string): string
  ban_player: function(string): boolean
  unban_player_or_ip: function(string)
  kick_player: function(string, string): boolean
  disconnect_player: function(string, string): boolean
  add_particle: function(ParticleDefinition)
  add_particlespawner: function(ParticleSpawnerDefinition): number
  delete_particlespawner: function(number, string)

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


global type DynamicColorSpec = (ColorSpec | string)

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

global enum CheatType
  "moved_too_fast"
  "interacted_too_far"
  "interacted_with_self"
  "interacted_while_dead"
  "finished_unknown_dig"
  "dug_unbreakable"
  "dug_too_fast"
end

global record ActionDefinition
  from_list: string
  to_list: string
  from_index: number
  to_index: number
  count: number
  listname: string
  index: number
  stack: ItemStack
end




global record CheatDefinition
  type: CheatType
end

global enum ClearObjectsOptions
  "full"
  "quick"
end


global type EmergeAreaCallback = function(Vec3, any, number, any)

global enum GenNotifyFlags
  "dungeon"
  "temple"
  "cave_begin"
  "cave_end"
  "large_cave_begin"
  "large_cave_end"
  "decoration"
end

global record BiomeDataDefinition
  biome: number
  heat: number
  humidity: number
end

global record MapGenSettingsDefinition
  mgname: string
  seed: number
  chnksize: number
  water_level: number
  flags: string
end

global enum SearchAlgorithm
  "A*_noprefetch"
  "A*"
  "Dijkstra"
end

global record MetaData
  fields: {string : any}
  inventory: {string : {number : string}}
end

global record MetaRef
  set_tool_capabilities: function(ToolCapabilities)
  contains: function(string): boolean
  get: function(string): string
  set_string: function(string, string)
  get_string: function(string): string
  set_int: function(string, number)
  get_int: function(string): number
  set_float: function(string, number)
  get_float: function(string): number
  get_keys: function(): {string}
  to_table: function(): MetaData | nil
  from_table: function(MetaData): boolean
  equals: function(MetaRef): boolean
  -- node
  get_inventory: function(): InvRef
  mark_as_private: function(string | {string})
  -- timer
  set: function(number, number)
  start: function(number)
  stop: function()
  get_timeout: function(): number
  get_elapsed: function(): number
  is_started: function(): boolean

end

global record ItemStack
  name: string
  count: number
  wear: number
  metadata: string

  is_empty: function(): boolean
  get_name: function(): string
  set_name: function(string): boolean
  get_count: function(): number
  set_count: function(number): boolean
  get_wear: function(): number
  set_wear: function(number): boolean
  get_meta: function(): MetaRef
end


global record InvRefLocation
  type: string
  name: string
  pos: Vec3
end

global record InvRef
  is_empty: function(string): boolean
  get_size: function(string): number
  set_size: function(string, number): boolean
  get_width: function(string): number
  set_width: function(string, number)
  get_stack: function(string, number): ItemStack
  set_stack: function(string, number, ItemStack)
  get_list: function(string): {ItemStack}
  set_list: function(string, {ItemStack})
  get_lists: function(): {string}
  set_lists: function({ItemStack})
  add_item: function(string, {ItemStack}): boolean
  room_for_item: function(string, {ItemStack}): boolean
  contains_item: function(string, {ItemStack}, boolean): boolean
  remove_item: function(string, {ItemStack}): {ItemStack}
  get_location: function(): InvRefLocation
end

global record TreeDefinition
  axiom: string
  rules_a: string
  rules_b: string
  rules_c: string
  rules_d: string
  trunk: string
  leaves: string
  leaves2: string
  leaves2_chance: number
  angle: number
  iterations: number
  random_level: number
  trunk_type: string
  thin_branches: boolean
  fruit: string
  fruit_chance: number
  seed: number
end

global record MapGenObjectDefinition

end

global function VoxelManip(_pos1: Vec3, _pos2: Vec3): VoxelManipObject end
global record VoxelManipObject
  read_from_map: function(Vec3, Vec3)
  write_to_map: function(boolean)
  get_node_at: function(Vec3): MapNode
  set_node_at: function(Vec3, MapNode)
  get_data: function({number}): {number}
  set_data: function({number})
  set_lighting: function(number, Vec3, Vec3)
  get_light_data: function({number}): {number}
  set_light_data: function({number})
  get_param2_data: function({number}): {number}
  set_param2_data: function({number})
  calc_lighting: function(Vec3, Vec3, boolean)
  update_liquids: function()
  was_modified: function(): boolean
  get_emerged_area: function(): Vec3, Vec3
end

global record VoxelAreaInitializer
  MinEdge: Vec3
  MaxEdge: Vec3
end

global function VoxelArea(_min: Vec3, _max: Vec3): VoxelAreaObject end
global record VoxelAreaObject
  ystride: number
  zstride: number
  new: function(VoxelAreaInitializer): VoxelAreaObject
  getExtent: function(): Vec3
  index: function(number, number, number): number
  indexp: function(Vec3): number
  position: function(number): Vec3
  contains: function(number, number, number): boolean
  containsp: function(Vec3): boolean
  containsi: function(number): boolean
  iter: function(number, number, number, number, number, number): function(): number
  iterp: function(Vec3, Vec3): function(): number
end

global record HeightMapObject

end

global record BiomeMapObject

end

global record HeatMapObject

end

global record HumidityMapObject

end

global record GenNotifyObject

end

global function Raycast(_pos1: Vec3, _pos2: Vec3, _object: boolean, _liquids: boolean): RaycastObject end
global record RaycastObject
  metamethod __call: function(RaycastObject): PointedThing | nil
end

global function SecureRandom(): SecureRandomObject end
global record SecureRandomObject
  next_bytes: function(number): string
end

global function Settings(): MinetestSettingsObject end
global record MinetestSettingsObject
  get: function(string): any
  get_bool: function(string): boolean | nil
  get_np_group: function(string): NoiseParams
  get_flags: function(string): {string : boolean}
  set: function(string, string)
  set_bool: function(string, boolean)
  set_np_group: function(string, NoiseParams)
  remove: function(string): boolean
  get_names: function(): {string}
  has: function(string): boolean
  write: function(): boolean
  to_table: function(): {string : any}
end



global record NametagAttributes
  text: string
  color: RGBA
  bgcolor: RGBA
end

global record AttachRef
  parent: ObjectRef
  bone: string
  position: Vec3
  rotation: Vec3
  forced_visible: boolean
end


global record ObjectRef
  get_pos: function(): Vec3
  set_pos: function(Vec3)
  get_velocity: function(): Vec3
  add_velocity: function(Vec3)
  move_to: function(Vec3, boolean)
  punch: function(ObjectRef, number, ToolCapabilities, Vec3)
  right_click: function(ObjectRef)
  get_hp: function(): number
  set_hp: function(number, HPChangeReasonType)
  get_inventory: function(): InvRef
  get_wield_list: function(): string
  get_wield_index: function(): number
  get_wielded_item: function(): ItemStack
  set_wielded_item: function(ItemStack): boolean
  get_armor_groups: function(): {string : number}
  set_armor_groups: function({string : number})
  set_animation: function(Vec2, number, number, boolean)
  set_animation_frame_speed: function(number)
  set_attach: function(ObjectRef, string, Vec3, Vec3, boolean)
  get_attach: function(): AttachRef | nil
  get_children: function(): {ObjectRef}
  set_detach: function()
  set_bone_position: function(string, Vec3, Vec3)
  set_properties: function({any : any})
  get_properties: function(): {any : any}
  is_player: function(): boolean
  get_nametag_attributes: function(): NametagAttributes
  set_nametag_attributes: function(NametagAttributes)
  remove: function()
  set_velocity: function(Vec3)
  set_acceleration: function(Vec3)
  get_acceleration: function(): Vec3
  set_rotation: function(Vec3)
  get_rotation: function(): Vec3
  set_yaw: function(number)
  get_yaw: function(): number
  set_texture_mod: function(string)
  get_texture_mod: function(string)
  set_sprite: function(Vec2, number, number, boolean)
  name: string
  get_luaentity: function(): LuaEntity
  get_player_name: function(): string
  get_look_dir: function(): Vec3
  get_look_vertical: function(): number
  get_look_horizontal: function(): number
  set_look_vertical: function(number)
  set_look_horizontal: function(number)
  get_look_pitch: function(): number
  get_look_yaw: function(): number
  set_look_pitch: function(number)
  set_look_yaw: function(number)
  get_breath: function(): number
  set_breath: function(number)
  set_fov: function(number, boolean, number)
  get_fov: function(): number
  get_meta: function(): MetaRef
  set_inventory_formspec: function(Formspec)
  get_inventory_formspec: function(): Formspec
  set_formspec_prepend: function(Formspec)
  get_formspec_prepend: function(): Formspec
  get_player_control: function(): PlayerControl
  get_player_control_bits: function(): number
  set_physics_override: function(PhysicsOverride)
  get_physics_override: function(): PhysicsOverride
  hud_add: function(HudDefinition): number
  hud_remove: function(number)
  hud_change: function(number, HudElementType, any)
  hud_get: function(number): HudDefinition
  hud_set_flags: function(HudFlags)
  hud_get_flags: function(): HudFlags
  hud_set_hotbar_itemcount: function(number)
  hud_get_hotbar_itemcount: function(): number
  hud_set_hotbar_image: function(string)
  hud_get_hotbar_image: function(): string
  hud_set_hotbar_selected_image: function(string)
  hud_get_hotbar_selected_image: function(): string
  set_minimap_modes: function(MinimapModes, number)
  set_sky: function(SkyParameters)
  get_sky: function(boolean): SkyParameters
  set_sun: function(SunParameters)
  get_sun: function(): SunParameters
  set_moon: function(MoonParameters)
  get_moon: function(): MoonParameters
  set_stars: function(StarParameters)
  get_stars: function(): StarParameters
  set_clouds: function(CloudParameters)
  get_clouds: function(): CloudParameters
  override_day_night_ratio: function(number | nil)
  get_day_night_ratio: function(): number | nil
  set_local_animation: function(Vec2, Vec2, Vec2, Vec2, number)
  get_local_animation: function(): {Vec2, Vec2, Vec2, Vec2, number}
  set_eye_offset: function(Vec3, Vec3, Vec3)
  get_eye_offset: function(): Vec3, Vec3, Vec3
  send_mapblock: function(Vec3)
  set_lighting: function(LightingDefinition)
  get_lighting: function(): LightingDefinition
  respawn: function()
end

global function dump(...: any): string print(...) end

global function PcgRandom(_seed: number, _sequence: {number}): PcgRandomObject end
global record PcgRandomObject
  next: function(PcgRandomObject): number
  next: function(PcgRandomObject, number, number): number
  rand_normal_dist: function(PcgRandomObject, number, number, number): number
end

global function PerlinNoise(_params: NoiseParams): PerlinNoiseObject end
global record PerlinNoiseObject
  get_2d: function(PerlinNoiseObject, Vec2): number
  get_3d: function(PerlinNoiseObject, Vec3): number
end

global function PerlinNoiseMap(_params: NoiseParams, _size: Vec3): PerlinNoiseMapObject end
global record PerlinNoiseMapObject
  get_2d_map: function(PerlinNoiseMapObject, Vec2): {{number}}
  get_3d_map: function(PerlinNoiseMapObject, Vec3): {{{number}}}
  get_2d_map_flat: function(PerlinNoiseMapObject, Vec2, {any}): {number}
  get_3d_map_flat: function(PerlinNoiseMapObject, Vec3, {any}): {number}
  calc_2d_map: function(PerlinNoiseMapObject, Vec2)
  calc_3d_map: function(PerlinNoiseMapObject, Vec3)
  get_map_slice: function(PerlinNoiseMapObject, Vec3, Vec3, {any}): {number}
end

global function PseudoRandom(_seed: number): PseudoRandomObject end
global record PseudoRandomObject
  next: function(PseudoRandomObject): number
  next: function(PseudoRandomObject, number, number): number
end

global record PhysicsOverride
  speed: number
  jump: number
  gravity: number
  speed_climb: number
  speed_crouch: number
  liquid_fluidity: number
  liquid_fluidity_smooth: number
  liquid_sink: number
  acceleration_default: number
  acceleration_air: number
  sneak: boolean
  sneak_glitch: boolean
  new_move: boolean
end


global record PlayerControl
  up: boolean
  down: boolean
  left: boolean
  right: boolean
  jump: boolean
  aux1: boolean
  sneak: boolean
  dig: boolean
  place: boolean
  LMB: boolean
  RMB: boolean
  zoom: boolean
end

global enum SkyParametersType
  "regular"
  "skybox"
  "plain"
end

global enum SkyParametersFogTintType
  "custom"
  "default"
end

global record SkyParametersColor
  day_sky: DynamicColorSpec
  day_horizon: DynamicColorSpec
  dawn_sky: DynamicColorSpec
  dawn_horizon: DynamicColorSpec
  nigh_sky: DynamicColorSpec
  night_horizon: DynamicColorSpec
  indoors: DynamicColorSpec
  fog_sun_tint: DynamicColorSpec
  fog_moon_tint: DynamicColorSpec
  fog_tint_type: SkyParametersFogTintType
end

global record SkyParametersFog
  fog_distance: number
  fog_start: number
end

global record SkyParameters
  base_color: DynamicColorSpec
  body_orbit_tilt: number
  type: SkyParametersType
  textures: {string}
  clouds: boolean
  sky_color: SkyParametersColor
  fog: SkyParametersFog
end

global record SunParameters
  visible: boolean
  texture: string
  tonemap: string
  sunrise: string
  sunrise_visible: boolean
  scale: number
end

global record MoonParameters
  visible: boolean
  texture: string
  tonemap: string
  scale: number
end

global record StarParameters
  visible: boolean
  day_opacity: number
  count: number
  star_color: DynamicColorSpec
  scale: number
end

global record CloudParameters
  density: number
  color: DynamicColorSpec
  ambient: DynamicColorSpec
  height: number
  thickness: number
  speed: Vec2
end

global record LightShadowsSpec
  intensity: number
end

global record LightExposureSpec
  luminance_min: number
  luminance_max: number
  exposure_correction: number
  speed_dark_bright: number
  speed_bright_dark: number
  center_weight_power: number
end

global record LightingDefinition
  saturation: number
  shadows: LightShadowsSpec
  exposure: LightExposureSpec
end

global record ObjectProperties
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
end

global record EntityDefinition
  initial_properties: ObjectProperties
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

global record LuaEntity
  initial_properties: ObjectProperties
  name: string
  object: ObjectRef
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

global enum MinimapType
  "off"
  "surface"
  "radar"
  "texture"
end

global record MinimapModes
  type: MinimapType
  label: string
  size: number
  texture: string
  scale: number
end

global record HudFlags
  hotbar: boolean
  healthbar: boolean
  crosshair: boolean
  wielditem: boolean
  breathbar: boolean
  minimap: boolean
  minimap_radar: boolean
  basic_debug: boolean
end

global enum HudElementType
  "image"
  "text"
  "statbar"
  "inventory"
  "waypoint"
  "image_waypoint"
  "compass"
  "minimap"
end

global record HudDefinition
  hud_elem_type: HudElementType
  position: Vec2
  name: string
  scale: Vec2
  text: string
  text2: string
  number: number
  item: number
  direction: number
  alignment: Vec2
  offset: Vec2
  world_pos: Vec3
  size: Vec2
  z_index: number
  style: number
end

global type Formspec = string

global enum TileAnimationType
  "vertical_frames"
  "sheed_2d"
end

global record TileAnimationDefinition
  type: TileAnimationType
  aspect_w: number
  aspect_h: number
  length: number
  frames_w: number
  frames_h: number
  frame_length: number
end

global record DetachedInventoryCallbacks
  allow_move: function(InvRef, string, number, string, number, number, ObjectRef)
  allow_put: function(InvRef, string, number, ItemStack, ObjectRef)
  allow_take: function(InvRef, string, number, ItemStack, ObjectRef)
  on_move: function(InvRef, string, number, string, number, number, ObjectRef)
  on_put: function(InvRef, string, number, ItemStack, ObjectRef)
  on_take: function(InvRef, string, number, ItemStack, ObjectRef)
end

global record Rollback
  actor: string
  pos: Vec3
  time: number
  oldnode: string
  newnode: string
end

global record Job
  cancel: function()
end

global record DynamicAddMediaOptions
  filepath: string
  to_player: string
  ephemeral: boolean
end
global record ParticleBounceDefinition
  min: number
  max: number
  bias: number
end

global record ParticleDefinition
  pos: Vec3
  velocity: Vec3
  acceleration: Vec3
  expirationtime: number
  size: number
  collisiondetection: boolean
  collision_removal: boolean
  object_collision: boolean
  vertical: boolean
  texture: string
  playername: string
  animation: TileAnimationDefinition
  glow: number
  node: NodeTable
  node_tile: NodeSoundSpec
  drag: Vec3
  bounce: ParticleBounceDefinition
end

global enum ParticleSpawnerTweenStyle
  "fwd"
  "rev"
  "pulse"
  "flicker"
end

global record ParticleSpawnerTweenDefinition
  {number | ParticleSpawnerRangeDefinition}
  style: ParticleSpawnerTweenStyle
  reps: number
  start: number
end

global record ParticleSpawnerRangeDefinition
  min: Vec3
  max: Vec3
  bias: number
  pos_tween: ParticleSpawnerTweenDefinition
  x: number
  y: number
  z: number
end

global enum ParticleSpawnerTextureBlend
  "alpha"
  "add"
  "screen"
  "sub"
end

global record ParticleSpawnerTextureScaleTween
  {Vec2}
end

global record ParticleSpawnerTextureDefinition
  name: string
  alpha: number
  alpha_tween: {number}
  scale: number | Vec2
  scale_tween: ParticleSpawnerTextureScaleTween
  blend: ParticleSpawnerTextureBlend
  animation: TileAnimationDefinition
end

global record TexturePoolComponentTweenDefinition
  {number}
  style: ParticleSpawnerTweenStyle
  reps: number
end

global enum TexturePoolComponentFade
  "in"
  "out"
end

global record TexturePoolComponentDefinition
  name: string
  fade: TexturePoolComponentFade
  alpha: number
  scale: number
  animation: TileAnimationDefinition
  alpha_tween: TexturePoolComponentTweenDefinition
end

global record ParticleSpawnerTexturePoolDefinition
  {string | TexturePoolComponentDefinition}
end

global enum ParticleSpawnerAttractionType
  "none"
  "point"
  "line"
  "plane"
end

global record ParticleSpawnerAttractionDefinition
  kind: ParticleSpawnerAttractionType
  strength: Vec2
  origin: Vec3
  direction: Vec3
  origin_attached: ObjectRef
  direction_attached: ObjectRef
  die_on_contact: boolean
end


global record ParticleSpawnerDefinition
  maxpos: Vec3
  minpos: Vec3
  pos: number | ParticleSpawnerRangeDefinition
  vel: Vec3RangeBias
  acc: Vec3RangeBias
  jitter: Vec3RangeBias
  drag: Vec3RangeBias
  bounce: Vec3RangeBias
  exptime: Vec2
  attract: ParticleSpawnerAttractionDefinition
  radius: Vec3RangeBias
  pos_tween: ParticleSpawnerTweenDefinition
  texture: string | ParticleSpawnerTextureDefinition
  texpool: ParticleSpawnerTexturePoolDefinition
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

global record Vec3RangeBias
  min: Vec3
  max: Vec3
  bias: Vec3
end

global record RGBA
  r: number
  g: number
  b: number
  a: number
end