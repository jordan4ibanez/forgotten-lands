// Everything was just dumped in as I looked down the lua_api.md
interface minetest {
  get_current_modname(): string
  get_modpath(string): string
  get_modnames(): string[]
  get_game_info(): GameInfo
  get_worldpath(): string
  is_singleplayer(): boolean
  features(): MinetestFeatures
  has_feature(string): boolean
  get_player_information(string): PlayerInformation
  get_player_window_information(string): WindowInformation
  mkdir(string): boolean
  rmdir(string): boolean
  cpdir(string): boolean
  mvdir(string): boolean
  get_dir_list(string, boolean): string[]
  safe_file_write(string, string): boolean
  get_version(): MinetestInfo
  sha1(any, boolean): string
  colorspec_to_colorstring(DynamicColorSpec): string
  colorspec_to_bytes(DynamicColorSpec): string
  encode_png(number, number, ColorSpec[] | string, number): string
  urlencode(string): string
  debug(string): void
  log(LogLevel, string): void
  register_node(string, NodeDefinition): void
  register_craftitem(string, ItemDefinition): void
  register_tool(string, ItemDefinition): void
  override_item(string, {any : any}): void
  unregister_item(string): void
  register_entity(string, EntityDefinition): void
  register_abm(ABMDefinition): void
  register_lbm(LBMDefinition): void
  register_alias(string, string): void
  register_alias_force(string, string): void
  register_ore(OreDefinition): void
  register_biome(BiomeDefinition): void
  unregister_biome(string): void
  register_decoration(DecorationDefinition): void
  register_schematic(SchematicDefinition): number
  clear_registered_biomes(): void
  clear_registered_decorations(): void
  clear_registered_ores(): void
  clear_registered_schematics(): void
  register_craft(CraftRecipeDefinition): void
  clear_craft(CraftRecipeDefinition): void
  register_chatcommand(string, ChatCommandDefinition): void
  override_chatcommand(string, ChatCommandDefinition): void
  unregister_chatcommand(string): void
  register_privilege(string, PrivilegeDefinition): void
  register_authentication_handler(AuthenticationHandlerDefinition): void
  register_globalstep(function(number): void): void
  register_on_mods_loaded(function(): void): void
  register_on_shutdown(function(): void): void
  register_on_placenode(function(Vec3, NodeTable, ObjectRef, NodeTable, ItemStackObject, PointedThing): void): void
  register_on_dignode(function(Vec3, NodeTable, ObjectRef): void): void
  register_on_punchnode(function(Vec3, NodeTable, ObjectRef, PointedThing): void): void
  register_on_generated(function(Vec3, Vec3, number): void): void
  register_on_newplayer(function(ObjectRef): void): void
  register_on_punchplayer(function(ObjectRef, ObjectRef, number, ToolCapabilities, Vec3, number): void): void
  register_on_rightclickplayer(function(ObjectRef, ObjectRef): void): void
  register_on_player_hpchange(function(ObjectRef, number, HPChangeReasonDefinition): void, boolean): void
  register_on_dieplayer(function(ObjectRef, HPChangeReasonDefinition): void): void
  register_on_respawnplayer(function(ObjectRef): void): void
  register_on_prejoinplayer(function(string, string): void): void
  register_on_joinplayer(function(ObjectRef, string): void): void
  register_on_leaveplayer(function(ObjectRef, boolean): void): void
  register_on_authplayer(function(string, string, boolean): void): void
  register_on_auth_fail(function(string, string): void): void
  register_on_cheat(function(ObjectRef, CheatDefinition): void): void
  register_on_chat_message(function(string, string): void): void
  register_on_chatcommand(function(string, string, string): boolean): void
  register_on_player_receive_fields(function(ObjectRef, string, {string : any}): void): void
  register_on_craft(function(ItemStackObject, ObjectRef, any[], string): void): void
  register_craft_predict(function(ItemStackObject, ObjectRef, any[], string): void): void
  register_allow_player_inventory_action(function(ObjectRef, string, string, ActionDefinition): void): void
  register_on_player_inventory_action(function(ObjectRef, string, string, ActionDefinition): void): void
  register_on_protection_violation(function(Vec3, string): void): void
  register_on_item_eat(function(number, boolean, ItemStackObject, ObjectRef, PointedThing): void): void
  register_on_item_pickup(function(ItemStackObject, ObjectRef, PointedThing, number, ...any): void): void
  register_on_priv_grant(function(string, string, string): void): void
  register_on_priv_revoke(function(string, string, string): void): void
  register_can_bypass_userlimit(function(string, string): void): void
  register_on_modchannel_message(function(string, string, string): void): void
  register_on_liquid_transformed(function(Vec3[], string[]): void): void
  register_on_mapblocks_changed(function(string[], number): void): void
  settings: MinetestSettingsObject
  setting_get_pos(string): Vec3
  string_to_privs(string, string): string
  privs_to_string(string, string): string
  get_player_privs(string): string[]
  check_player_privs(ObjectRef | string, string | string[]): boolean | boolean[]
  check_password_entry(string, string, string): boolean
  get_password_hash(string, string): string
  get_player_ip(string): string
  get_auth_handler(): AuthenticationHandlerDefinition
  notify_authentication_modified(string): void
  set_player_password(string, string): void
  set_player_privs(string, {string : boolean}): void
  auth_reload(): void
  chat_send_all(string): void
  chat_send_player(string, string): void
  format_chat_message(string, string): void
  set_node(Vec3, NodeTable): void
  add_node(Vec3, NodeTable): void
  bulk_set_node(Vec3[], NodeTable): void
  swap_node(Vec3, NodeTable): void
  remove_node(Vec3): void
  get_node(Vec3): NodeTable
  get_node_or_nil(Vec3): NodeTable | void
  get_node_light(Vec3, number): number
  get_natural_light(Vec3, number): number
  get_artificial_light(number): number
  place_node(Vec3, NodeTable)
  dig_node(Vec3): boolean
  punch_node(Vec3)
  spawn_falling_node(Vec3): {boolean, ObjectRef} | boolean
  find_nodes_with_meta(Vec3, Vec3): {Vec3}
  get_meta(Vec3): MetaData
  get_node_timer(Vec3): NodeTimerObject
  add_entity(Vec3, string, string): ObjectRef | nil
  add_item(Vec3, ItemStackObject | string): ObjectRef
  get_player_by_name(string): ObjectRef
  get_objects_inside_radius(Vec3, number): {ObjectRef}
  get_objects_in_area(Vec3, Vec3): {ObjectRef}
  set_timeofday(number)
  get_timeofday(): number
  get_gametime(): number
  get_day_count(): number
  find_node_near(Vec3, number, {string}, boolean): Vec3 | nil
  find_nodes_in_area(Vec3, Vec3, {string}, boolean): any[]
  find_nodes_in_area_under_air(Vec3, Vec3, {string}): Vec3[]
  get_perlin(NoiseParams): PerlinNoiseObject
  get_perlin(number, number, number, number): PerlinNoiseObject
  get_voxel_manip(Vec3, Vec3): VoxelManipObject
  set_gen_notify(GenNotifyFlags, {number})
  get_gen_notify(): {number}
  get_decoration_id(string): number
  get_mapgen_object(string): GenNotifyObject
  get_heat(Vec3): number
  get_humidity(Vec3): number
  get_biome_data(Vec3): BiomeDataDefinition | nil
  get_biome_id(string): number
  get_biome_name(number): string
  get_mapgen_setting(string): MapGenSettingsDefinition
  set_mapgen_params(MapGenSettingsDefinition)
  get_mapgen_edges(number, number)
  get_mapgen_setting(string): MapGenSettingsDefinition
  get_mapgen_setting_noiseparams(string): NoiseParams
  set_mapgen_setting(string, any, boolean)
  set_noiseparams(string, NoiseParams, boolean)
  get_noiseparams(string): NoiseParams
  generate_ores(VoxelManipObject, Vec3, Vec3)
  generate_decorations(VoxelManipObject, Vec3, Vec3)
  clear_objects(ClearObjectsOptions)
  load_area(Vec3, Vec3)
  emerge_area(Vec3, Vec3, EmergeAreaCallback, any)
  delete_area(Vec3, Vec3)
  line_of_sight(Vec3, Vec3): {boolean, Vec3}
  raycast(Vec3, Vec3, boolean, boolean): RaycastObject
  find_path(Vec3, Vec3, number, number, number, SearchAlgorithm)
  spawn_tree(Vec3, TreeDefinition)
  transforming_liquid_add(Vec3)
  get_node_max_level(Vec3): number
  get_node_level(Vec3): number
  set_node_level(Vec3, number): number
  add_node_level(Vec3, number): number
  fix_light(Vec3, Vec3): boolean
  check_single_for_falling(Vec3)
  check_for_falling(Vec3)
  get_spawn_level(number, number)
  mod_channel_join(string)
  get_inventory(Vec3): InvRef
  get_perlin_map(NoiseParams, Vec3): PerlinNoiseMapObject
  get_inventory(Vec3): InvRef
  create_detached_inventory(string, DetachedInventoryCallbacks, string): InvRef
  remove_detached_inventory(string): boolean
  do_item_eat(number, ItemStackObject, ItemStackObject, ObjectRef, PointedThing): ItemStackObject | nil
  show_formspec(string, string, Formspec)
  close_formspec(string, string)
  formspec_escape(string): string
  explode_table_event(string): {any : any}
  explode_textlist_event(string): {any : any}
  explode_scrollbar_event(string): {any : any}
  inventorycube(string, string, string): string
  get_pointed_thing_position(PointedThing, boolean): Vec3 | nil
  dir_to_facedir(Vec3, boolean): number
  facedir_to_dir(number): Vec3
  dir_to_fourdir(Vec3): number
  fourdir_to_dir(number): Vec3
  dir_to_wallmounted(Vec3): number
  wallmounted_to_dir(number): Vec3
  dir_to_yaw(Vec3): number
  yaw_to_dir(number): Vec3
  is_colored_paramtype(number): boolean
  strip_param2_color(number, paramtype2): number | nil
  get_node_drops(string | NodeTable, string): {string}
  get_craft_result(CraftRecipeDefinition): {ItemStackObject, ItemStackObject}
  get_craft_recipe(string | NodeTable): CraftRecipeDefinition | nil
  get_all_craft_recipes(string | NodeTable): {CraftRecipeDefinition} | nil
  handle_node_drops(Vec3, {string}, ObjectRef)
  itemstring_with_palette(ItemStackObject, number): string
  itemstring_with_color(ItemStackObject, DynamicColorSpec): string
  rollback_get_node_actions(Vec3, number, number, number): {Rollback}
  rollback_revert_actions_by(string, number): {boolean, string}
  item_place_node(ItemStackObject, ObjectRef, PointedThing, number, boolean): ItemStackObject, Vec3
  item_place_object(ItemStackObject, ObjectRef, PointedThing): ItemStackObject
  item_place(ItemStackObject, ObjectRef, PointedThing, number)
  item_pickup(ItemStackObject, ObjectRef, PointedThing, number, ...any): ItemStackObject
  item_drop(ItemStackObject, ObjectRef, Vec3): ItemStackObject
  item_eat(number, string)
  node_punch(Vec3, NodeTable, ObjectRef, PointedThing)
  node_dig(Vec3, NodeTable, ObjectRef)
  after(number, function, ...any): Job
  handle_async(function, function, ...any)
  register_async_dofile(string)
  request_shutdown(string, boolean, number)
  cancel_shutdown_requests()
  get_server_status(string, boolean)
  get_server_uptime(): number
  get_server_max_lag(): number
  remove_player(string): number
  remove_player_auth(string): boolean
  dynamic_add_media(DynamicAddMediaOptions, function(string))
  get_ban_list(): string
  get_ban_description(string): string
  ban_player(string): boolean
  unban_player_or_ip(string)
  kick_player(string, string): boolean
  disconnect_player(string, string): boolean
  add_particle(ParticleDefinition)
  add_particlespawner(ParticleSpawnerDefinition): number
  delete_particlespawner(number, string)
  create_schematic(Vec3, Vec3, {SchematicProbability}, string, {SchematicSliceProbability})
  place_schematic(Vec3, SchematicDefinition | string, SchematicRotation, {string : string}, boolean, {SchematicPlacementFlag})
  place_schematic_on_vmanip(VoxelManipObject, Vec3, SchematicDefinition, SchematicRotation, {string : string}, boolean, {SchematicPlacementFlag})
  serialize_schematic(SchematicDefinition, SchematicFormat, {SchematicSerializationOption})
  read_schematic(SchematicDefinition | string, {SchematicReadOptionYSlice}): table
  request_http_api(): HTTPApi
  get_mod_storage(): MetaRef
  get_connected_players(): {ObjectRef}
  is_player(ObjectRef): boolean
  player_exists(string): boolean
  hud_replace_builtin(HudReplaceBuiltinOption, HudDefinition)
  parse_relative_number(ParseRelativeNumberArgument, number): number | nil
  send_join_message(string)
  send_leave_message(string, boolean)
  hash_node_position(Vec3): number
  get_position_from_hash(number): Vec3
  get_item_group(string, string): number
  raillike_group(string): number
  get_content_id(string): number
  get_name_from_content_id(number): string
  parse_json(string, any): {any}
  write_json({any}, boolean): string | nil
  serialize(any): string
  deserialize(string, boolean): {any : any}
  compress(string, CompressionMethod, ...any): string
  decompress(string, CompressionMethod, ...any): string
  rgba(number, number, number, number): string
  encode_base64(string): string
  decode_base64(string): string
  is_protected(Vec3, string): boolean
  record_protection_violation(Vec3, string)
  is_creative_enabled(string): boolean
  is_area_protected(Vec3, Vec3, string, number): boolean
  rotate_and_place(ItemStackObject, ObjectRef, PointedThing, boolean,RotateAndPlaceOrientationFlag, boolean): ItemStackObject
  rotate_node(ItemStackObject, ObjectRef, PointedThing)
  calculate_knockback(ObjectRef, ObjectRef, number, ToolCapabilities, Vec3, number, number)
  forceload_block(Vec3, boolean, number)
  forceload_free_block(Vec3, boolean)
  compare_block_status(Vec3, BlockStatusCondition): boolean | nil
  request_insecure_environment(): any
  global_exists(string): boolean

  registered_items: {string : ItemDefinition}
  registered_nodes: {string : NodeDefinition}
  registered_craftitems: {string : ItemDefinition}
  registered_tools: {string : ItemDefinition}
  registered_entities: {string : EntityDefinition}
  object_refs: {string : ObjectRef}
  luaentities: {string : LuaEntity}
  registered_abms: {ABMDefinition}
  registered_lbms: {LBMDefinition}
  registered_aliases: {string : string}
  registered_ores: {string : OreDefinition}
  registered_biomes: {string : BiomeDefinition}
  registered_decorations: {number : DecorationDefinition}
  registered_schematics: {string : SchematicDefinition}
  registered_chatcommands: {string : ChatCommandDefinition}
  registered_privileges: {string : PrivilegeDefinition}
  
  wrap_text(string, number, boolean): string | {string}
  pos_to_string(Vec3, number): string
  string_to_pos(string): Vec3
  string_to_area(string, Vec3): Vec3, Vec3
  formspec_escape(string): string
  is_yes(any): boolean
  is_nan(number): boolean
  get_us_time(): number
  pointed_thing_to_face_pos(ObjectRef, PointedThing): Vec3
  get_tool_wear_after_use(number, number): number
  get_dig_params({string}, ToolCapabilities, number): DigParamsReturn
  get_hit_params({string}, ToolCapabilities, number, number): HitParamsReturn

  get_translator(string): Translator
  translate(string, ...string): string

  sound_play(SimpleSoundSpec, SoundParameterTable, boolean): number
  sound_stop(number)
  sound_fade(number, number, number)
}

interface SimpleSoundSpec {
  name: string
  gain: number
  pitch: number
  fade: number
}

interface SoundParameterTable extends SimpleSoundSpec {
  start_time: number
  loop: boolean
  pos: Vec3
  object: ObjectRef
  to_player: string
  max_hear_distance: number
}

enum paramtype1 {
  "light",
  "none"
}

enum paramtype2 {
  "flowingliquid",
  "wallmounted",
  "facedir",
  "4dir",
  "leveled",
  "degrotate",
  "meshoptions",
  "color",
  "colorfacedir",
  "color4dir",
  "colorwallmounted",
  "glasslikeliquidlevel",
  "colordegrotate"
}

enum drawtype {
  "normal",
  "airlike",
  "liquid",
  "flowingliquid",
  "glasslike",
  "glasslike_framed",
  "glasslike_framed_optional",
  "allfaces",
  "allfaces_optional",
  "torchlike",
  "signlike",
  "plantlike",
  "firelike",
  "fencelike",
  "raillike",
  "nodebox",
  "mesh",
  "plantlike_rooted"
}



interface NodeBox {
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
}

type box = {number}

type boxTable = {box}

enum nodeboxtype {
  "regular",
  "fixed",
  "wallmounted",
  "connected"
}

type itemstring = string


interface GameInfo {
  id: string
  title: string
  author: string
  path: string
}

interface MinetestFeatures {
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
}

interface PlayerInformation {
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
}

interface WindowInformation {
  size: Vec2
  max_formspec_size: Vec2
  real_gui_scaling: number
  real_hud_scaling: number
}

interface MinetestInfo {
  project: string
  string: string
  proto_min: string
  proto_max: string
  hash: string
  is_dev: boolean
}

interface ColorSpec {
  a: number
  r: number
  g: number
  b: number
}

enum LogLevel {
  "none",
  "error",
  "warning",
  "action",
  "info",
  "verbose"
}

enum TextureAlpha {
  "opaque",
  "clip",
  "blend"
}

enum LiquidType {
  "none",
  "source",
  "flowing"
}

enum NodeBoxConnections {
  "top",
  "bottom",
  "front",
  "left",
  "back",
  "right"
}

interface NodeSoundSpec {
  footstep: SimpleSoundSpec
  dig: SimpleSoundSpec | string
  dug: SimpleSoundSpec
  place: SimpleSoundSpec
  place_failed: SimpleSoundSpec
  fall: SimpleSoundSpec
}

interface ItemDropSpec {
  tools: {string}
  rarity: number
  items: {string}
  inherit_color: boolean
  tool_groups: string | {string}
}

interface NodeDropSpec {
  max_items: number
  items: {ItemDropSpec}
}

interface MapNode {
  name: string
  prob: number
  param2: number
  force_place: boolean
}

interface NodeTable {
  name: string
  param1: number
  param2: number
}

interface PointedThing {
  type: string
  under: Vec3
  above: Vec3
  ref: ObjectRef
}

interface ToolCapabilities {
  full_punch_interval: number
  max_drop_level: number
  groupcaps: {string : any}
  damage_groups: {string : number}
  punch_attack_uses: number
}

interface ItemSounds {
  breaks: SimpleSoundSpec
  eat: SimpleSoundSpec
  punch_use: SimpleSoundSpec
  punch_use_air: SimpleSoundSpec
}

enum EntityVisual {
  "cube",
  "sprite",
  "upright_sprite",
  "mesh",
  "wielditem",
  "item"
}

interface Collision {
  type: string
  axis: string
  node_pos: Vec3
  object: ObjectRef
  old_velocity: Vec3
  new_velocity: Vec3
}

interface MoveResult {
  touching_ground: boolean
  collides: boolean
  standing_on_object: boolean
  collisions: {Collision}
}


type DynamicColorSpec = (ColorSpec | string)

interface ItemDefinition {
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
  on_place(ItemStackObject, ObjectRef, PointedThing)
  on_secondary_use(ItemStackObject, ObjectRef, PointedThing)
  on_drop(ItemStackObject, ObjectRef, Vec3)
  on_pickup(ItemStackObject, ObjectRef, PointedThing, number, ...any)
  on_use(ItemStackObject, ObjectRef, PointedThing)
  after_use(ItemStackObject, ObjectRef, NodeTable, {string : any})
}

interface NodeDefinition {
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
  groups: {string : number}
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
  on_construct(Vec3)
  on_destruct(Vec3)
  after_destruct(Vec3, MapNode)
  on_flood(Vec3, NodeTable, NodeTable)
  preserve_metadata(Vec3, NodeTable, NodeTable, {ItemStackObject})
  after_place_node(Vec3, ObjectRef, ItemStackObject, PointedThing)
  after_dig_node(Vec3, NodeTable, string, ObjectRef)
  can_dig(Vec3, ObjectRef | string) //Unknown, documentation doesn't say
  on_punch(Vec3, NodeTable, ObjectRef, PointedThing)
  on_rightclick(Vec3, NodeTable, ObjectRef, ItemStackObject, PointedThing)
  on_dig(Vec3, NodeTable, ObjectRef)
  on_timer(Vec3, number)
  on_receive_fields(Vec3, string, {string : any}, ObjectRef)
  allow_metadata_inventory_move(Vec3, string, number, string, number, number, ObjectRef)
  allow_metadata_inventory_put(Vec3, string, number, ItemStackObject, ObjectRef)
  allow_metadata_inventory_take(Vec3, string, number, ItemStackObject, ObjectRef)
  on_metadata_inventory_move(Vec3, string, number, string, number, string, ObjectRef)
  on_metadata_inventory_put(Vec3, string, number, ItemStackObject, ObjectRef)
  on_metadata_inventory_take(Vec3, string, number, ItemStackObject, ObjectRef)
  on_blast(Vec3, number)
  mod_origin: string
}

interface ABMDefinition {
  label: string
  nodenames: {string}
  neighbors: {string}
  interval: number
  chance: number
  min_y: number
  max_y: number
  catch_up: number
  action: function(Vec3, NodeTable, number, number)
}

interface LBMDefinition {
  label: string
  name: string
  nodenames: {string}
  run_at_every_load: boolean
  action: function(Vec3, NodeTable, number)
}


enum SchematicRotation {
  "0",
  "90",
  "180",
  "270",
  "random"
}

enum SchematicPlacementFlag {
  "place_center_x",
  "place_center_y",
  "place_center_z"
}

enum SchematicFormat {
  "mts",
  "lua"
}

enum SchematicSerializationOption {
  "lua_use_comments",
  "lua_num_indent_spaces"
}

enum SchematicReadOptionYSlice {
  "none",
  "low",
  "all"
}

interface SchematicReadOptionYSlice {
  write_yslice_prob: SchematicReadOptionYSlice
}

interface SchematicData {
  name: string
  prob: number
  param1: number
  param2: number
  force_place: boolean
}

interface SchematicProbability {
  pos: Vec3
  prob: number
}

interface SchematicSliceProbability {
  ypos: number
  prob: number
}

interface SchematicDefinition {
  size: Vec3
  data: SchematicData[]
  yslice_prob: number[][]
}

enum HTTPRequestMethod {
  "GET",
  "POST",
  "PUT",
  "DELETE"
}

interface HTTPrequestDefinition {
  url: string
  timeout: number
  method: HTTPRequestMethod
  data: string | {string : string}
  user_agent: string
  extra_headers: {string}
  multipart: boolean
  post_data: string | {string : string}
}

interface HTTPRequestResult {
  completed: boolean
  succeeded: boolean
  timeout: boolean
  code: number
  data: string
}

interface HTTPApi {
  fetch: function(HTTPrequestDefinition, function(HTTPRequestResult))
  fetch_async: function(HTTPrequestDefinition): number
  fetch_async_get: function(number): HTTPRequestResult
}

enum OreType {
  "scatter",
  "sheet",
  "puff",
  "blob",
  "vein",
  "stratum"
}

enum OreFlags {
  "puff_cliffs",
  "puff_additive_composition"
}

enum NoiseFlags {
  "defaults",
  "eased",
  "absvalue"
}

interface NoiseParams {
  offset: number
  scale: number
  spread: Vec3
  seed: number
  octaves: number
  persistence: number
  lacunarity: number
  flags: NoiseFlags
}

interface OreDefinition {
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
}

interface BiomeDefinition {
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
}


enum DecorationType {
  "simple",
  "schematic"
}

enum DecorationFlags {
  "liquid_surface",
  "force_placement",
  "all_floors",
  "all_ceilings",
  "place_center_x",
  "place_center_y",
  "place_center_z"
}

interface DecorationDefinition {
  name: string
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
  flags: string | {string : boolean}
  decoration: string | {string}
  height: number
  height_max: number
  param2: number
  param2_max: number
  place_offset_y: number
  schematic: string | SchematicDefinition | number
  replacements: {string : string}
  rotation: string
}

enum CraftRecipeType {
  "shapless",
  "toolrepair",
  "cooking",
  "fuel"
}

interface CraftRecipeDefinition {
  type: CraftRecipeType
  output: string
  recipe: {string} | string
  replacements: {string}
  additional_wear: number
  cooktime: number
  burntime: number
}

interface ChatCommandDefinition {
  params: string
  description: string
  privs: {string}
  func: function(string, string)
}

interface PrivilegeDefinition {
  description: string
  give_to_singleplayer: boolean
  give_to_admin: boolean
  on_grant: function(string, string)
  on_revoke: function(string, string)
}

interface AuthenticationHandlerDefinition {
  get_auth: function(string)
  create_auth: function(string, string)
  delete_auth: function(string)
  set_password: function(string, string)
  set_privileges: function(string, {string})
  reload: function()
  record_login: function(string)
  iterate: function()
}


enum HPChangeReasonType {
  "set_hp",
  "punch",
  "fall",
  "node_damage",
  "drown",
  "respawn"
}

interface HPChangeReasonDefinition {
  type: HPChangeReasonType
  node: string
  node_pos: Vec3
  object: ObjectRef
  from: string
}

enum CheatType {
  "moved_too_fast",
  "interacted_too_far",
  "interacted_with_self",
  "interacted_while_dead",
  "finished_unknown_dig",
  "dug_unbreakable",
  "dug_too_fast"
}

interface ActionDefinition {
  from_list: string
  to_list: string
  from_index: number
  to_index: number
  count: number
  listname: string
  index: number
  stack: ItemStackObject
}


interface CheatDefinition {
  type: CheatType
}

enum ClearObjectsOptions {
  "full",
  "quick"
}


type EmergeAreaCallback = function(Vec3, any, number, any)

enum GenNotifyFlags {
  "dungeon",
  "temple",
  "cave_begin",
  "cave_end",
  "large_cave_begin",
  "large_cave_end",
  "decoration"
}

interface BiomeDataDefinition {
  biome: number
  heat: number
  humidity: number
}

interface MapGenSettingsDefinition {
  mgname: string
  seed: number
  chnksize: number
  water_level: number
  flags: string
}

enum SearchAlgorithm{
  "A*_noprefetch",
  "A*",
  "Dijkstra"
}

interface MetaData {
  fields: {string : any}
  inventory: {string : {number : string}}
}

interface MetaRef {
  set_tool_capabilities: function(MetaRef, ToolCapabilities)
  contains: function(MetaRef, string): boolean
  get: function(MetaRef, string): string
  set_string: function(MetaRef, string, string)
  get_string: function(MetaRef, string): string
  set_int: function(MetaRef, string, number)
  get_int: function(MetaRef, string): number
  set_float: function(MetaRef, string, number)
  get_float: function(MetaRef, string): number
  get_keys: function(MetaRef): {string}
  to_table: function(MetaRef): MetaData | nil
  from_table: function(MetaRef, MetaData): boolean
  equals: function(MetaRef, MetaRef): boolean
  //! FIXME: USE INHERITENCE!
  // node
  get_inventory: function(MetaRef): InvRef
  mark_as_private: function(MetaRef, string | {string})
  // timer
  set: function(MetaRef, number, number)
  start: function(MetaRef, number)
  stop: function(MetaRef)
  get_timeout: function(MetaRef): number
  get_elapsed: function(MetaRef): number
  is_started: function(MetaRef): boolean
}


function ItemStack(_: ItemStackObject | string): ItemStackObject {}
interface ItemStackObject {
  name: string
  count: number
  wear: number
  metadata: string

  is_empty: function(ItemStackObject): boolean
  get_name: function(ItemStackObject): string
  set_name: function(ItemStackObject, string): boolean
  get_count: function(ItemStackObject): number
  set_count: function(ItemStackObject, number): boolean
  get_wear: function(ItemStackObject): number
  set_wear: function(ItemStackObject, number): boolean
  get_meta: function(ItemStackObject): MetaRef
  get_description: function(ItemStackObject): string
  get_short_description: function(ItemStackObject): string
  clear: function(ItemStackObject)
  replace: function(ItemStackObject, ItemStackObject | string)
  to_string: function(ItemStackObject): string
  to_table: function(ItemStackObject): {any}
  get_stack_max: function(ItemStackObject): number
  get_free_space: function(ItemStackObject): number
  is_known: function(ItemStackObject): boolean
  get_definition: function(ItemStackObject): ItemDefinition
  get_tool_capabilities: function(ItemStackObject): ToolCapabilities
  add_wear: function(ItemStackObject, number)
  add_wear_by_uses: function(ItemStackObject, number)
  add_item: function(ItemStackObject, ItemStackObject): ItemStackObject
  item_fits: function(ItemStackObject, ItemStackObject): boolean
  take_item: function(ItemStackObject, number): ItemStackObject
  peek_item: function(ItemStackObject, number): ItemStackObject
  equals: function(ItemStackObject, ItemStackObject): boolean
}


interface InvRefLocation {
  type: string
  name: string
  pos: Vec3
}

interface InvRef {
  is_empty: function(InvRef, string): boolean
  get_size: function(InvRef, string): number
  set_size: function(InvRef, string, number): boolean
  get_width: function(InvRef, string): number
  set_width: function(InvRef, string, number)
  get_stack: function(InvRef, string, number): ItemStackObject
  set_stack: function(InvRef, string, number, ItemStackObject)
  get_list: function(InvRef, string): {ItemStackObject}
  set_list: function(InvRef, string, {ItemStackObject})
  get_lists: function(InvRef): {string}
  set_lists: function(InvRef, {ItemStackObject})
  add_item: function(InvRef, string, ItemStackObject | string): boolean
  room_for_item: function(InvRef, string, ItemStackObject | string): boolean
  contains_item: function(InvRef, string, ItemStackObject | string, boolean): boolean
  remove_item: function(InvRef, string, ItemStackObject | string): {ItemStackObject}
  get_location: function(InvRef): InvRefLocation
}

interface TreeDefinition {
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
}
  
type GenNotifyObject = {string : {Vec3}}

function VoxelManip(_pos1: Vec3, _pos2: Vec3): VoxelManipObject {}
interface VoxelManipObject {
  read_from_map: function(VoxelManipObject, Vec3, Vec3)
  write_to_map: function(VoxelManipObject, boolean)
  get_node_at: function(VoxelManipObject, Vec3): MapNode
  set_node_at: function(VoxelManipObject, Vec3, MapNode)
  get_data: function(VoxelManipObject, {number}): {number}
  set_data: function(VoxelManipObject, {number})
  set_lighting: function(VoxelManipObject, number, Vec3, Vec3)
  get_light_data: function(VoxelManipObject, {number}): {number}
  set_light_data: function(VoxelManipObject, {number})
  get_param2_data: function(VoxelManipObject, {number}): {number}
  set_param2_data: function(VoxelManipObject, {number})
  calc_lighting: function(VoxelManipObject, Vec3, Vec3, boolean)
  update_liquids: function(VoxelManipObject)
  was_modified: function(VoxelManipObject): boolean
  get_emerged_area: function(VoxelManipObject): Vec3, Vec3
}

interface VoxelAreaInitializer {
  MinEdge: Vec3
  MaxEdge: Vec3
}

function VoxelArea(_min: Vec3, _max: Vec3): VoxelAreaObject {}
interface VoxelAreaObject {
  ystride: number
  zstride: number
  new: function(VoxelAreaInitializer): VoxelAreaObject
  getExtent: function(VoxelAreaObject): Vec3
  index: function(VoxelAreaObject, number, number, number): number
  indexp: function(VoxelAreaObject, Vec3): number
  position: function(VoxelAreaObject, number): Vec3
  contains: function(VoxelAreaObject, number, number, number): boolean
  containsp: function(VoxelAreaObject, Vec3): boolean
  containsi: function(VoxelAreaObject, number): boolean
  iter: function(VoxelAreaObject, number, number, number, number, number, number): function(): number
  iterp: function(VoxelAreaObject, Vec3, Vec3): function(): number
}

interface HeightMapObject {

}

interface BiomeMapObject {

}

interface HeatMapObject {

}

interface HumidityMapObject {

}

function Raycast(_pos1: Vec3, _pos2: Vec3, _object: boolean, _liquids: boolean): RaycastObject {}
interface RaycastObject {
   __call: function(RaycastObject): PointedThing | nil
}

function SecureRandom(): SecureRandomObject {}
interface SecureRandomObject {
  next_bytes: function(SecureRandomObject, number): string
}

function Settings(_: string): MinetestSettingsObject {}
interface MinetestSettingsObject {
  get: function(MinetestSettingsObject, string): any
  get_bool: function(MinetestSettingsObject, string): boolean | nil
  get_np_group: function(MinetestSettingsObject, string): NoiseParams
  get_flags: function(MinetestSettingsObject, string): {string : boolean}
  set: function(MinetestSettingsObject, string, string)
  set_bool: function(MinetestSettingsObject, string, boolean)
  set_np_group: function(MinetestSettingsObject, string, NoiseParams)
  remove: function(MinetestSettingsObject, string): boolean
  get_names: function(MinetestSettingsObject): {string}
  has: function(MinetestSettingsObject, string): boolean
  write: function(MinetestSettingsObject): boolean
  to_table: function(MinetestSettingsObject): {string : any}
}

interface NametagAttributes {
  text: string
  color: RGBA
  bgcolor: RGBA
}

interface AttachRef {
  parent: ObjectRef
  bone: string
  position: Vec3
  rotation: Vec3
  forced_visible: boolean
}


interface ObjectRef {
  get_pos: function(ObjectRef): Vec3
  set_pos: function(ObjectRef, Vec3)
  get_velocity: function(ObjectRef): Vec3
  add_velocity: function(ObjectRef, Vec3)
  move_to: function(ObjectRef, Vec3, boolean)
  punch: function(ObjectRef, ObjectRef, number, ToolCapabilities, Vec3)
  right_click: function(ObjectRef, ObjectRef)
  get_hp: function(ObjectRef): number
  set_hp: function(ObjectRef, number, HPChangeReasonType)
  get_inventory: function(ObjectRef): InvRef
  get_wield_list: function(ObjectRef): string
  get_wield_index: function(ObjectRef): number
  get_wielded_item: function(ObjectRef): ItemStackObject
  set_wielded_item: function(ObjectRef, ItemStackObject): boolean
  get_armor_groups: function(ObjectRef): {string : number}
  set_armor_groups: function(ObjectRef, {string : number})
  set_animation: function(ObjectRef, Vec2, number, number, boolean)
  set_animation_frame_speed: function(ObjectRef, number)
  set_attach: function(ObjectRef, ObjectRef, string, Vec3, Vec3, boolean)
  get_attach: function(ObjectRef): AttachRef | nil
  get_children: function(ObjectRef): {ObjectRef}
  set_detach: function(ObjectRef)
  set_bone_position: function(ObjectRef, string, Vec3, Vec3)
  set_properties: function(ObjectRef, {any : any})
  get_properties: function(ObjectRef): {any : any}
  is_player: function(ObjectRef): boolean
  get_nametag_attributes: function(ObjectRef): NametagAttributes
  set_nametag_attributes: function(ObjectRef, NametagAttributes)
  remove: function(ObjectRef)
  set_velocity: function(ObjectRef, Vec3)
  set_acceleration: function(ObjectRef, Vec3)
  get_acceleration: function(ObjectRef): Vec3
  set_rotation: function(ObjectRef, Vec3)
  get_rotation: function(ObjectRef): Vec3
  set_yaw: function(ObjectRef, number)
  get_yaw: function(ObjectRef): number
  set_texture_mod: function(ObjectRef, string)
  get_texture_mod: function(ObjectRef, string)
  set_sprite: function(ObjectRef, Vec2, number, number, boolean)
  name: string
  get_luaentity: function(ObjectRef): LuaEntity
  get_player_name: function(ObjectRef): string
  get_look_dir: function(ObjectRef): Vec3
  get_look_vertical: function(ObjectRef): number
  get_look_horizontal: function(ObjectRef): number
  set_look_vertical: function(ObjectRef, number)
  set_look_horizontal: function(ObjectRef, number)
  get_look_pitch: function(ObjectRef): number
  get_look_yaw: function(ObjectRef): number
  set_look_pitch: function(ObjectRef, number)
  set_look_yaw: function(ObjectRef, number)
  get_breath: function(ObjectRef): number
  set_breath: function(ObjectRef, number)
  set_fov: function(ObjectRef, number, boolean, number)
  get_fov: function(ObjectRef): number
  get_meta: function(ObjectRef): MetaRef
  set_inventory_formspec: function(ObjectRef, Formspec)
  get_inventory_formspec: function(ObjectRef): Formspec
  set_formspec_prepend: function(ObjectRef, Formspec)
  get_formspec_prepend: function(ObjectRef): Formspec
  get_player_control: function(ObjectRef): PlayerControl
  get_player_control_bits: function(ObjectRef): number
  set_physics_override: function(ObjectRef, PhysicsOverride)
  get_physics_override: function(ObjectRef): PhysicsOverride
  hud_add: function(ObjectRef, HudDefinition): number
  hud_remove: function(ObjectRef, number)
  hud_change: function(ObjectRef, number, HudElementType, any)
  hud_get: function(ObjectRef, number): HudDefinition
  hud_set_flags: function(ObjectRef, HudFlags)
  hud_get_flags: function(ObjectRef): HudFlags
  hud_set_hotbar_itemcount: function(ObjectRef, number)
  hud_get_hotbar_itemcount: function(ObjectRef): number
  hud_set_hotbar_image: function(ObjectRef, string)
  hud_get_hotbar_image: function(ObjectRef): string
  hud_set_hotbar_selected_image: function(ObjectRef, string)
  hud_get_hotbar_selected_image: function(ObjectRef): string
  set_minimap_modes: function(ObjectRef, MinimapModes, number)
  set_sky: function(ObjectRef, SkyParameters)
  get_sky: function(ObjectRef, boolean): SkyParameters
  set_sun: function(ObjectRef, SunParameters)
  get_sun: function(ObjectRef): SunParameters
  set_moon: function(ObjectRef, MoonParameters)
  get_moon: function(ObjectRef): MoonParameters
  set_stars: function(ObjectRef, StarParameters)
  get_stars: function(ObjectRef): StarParameters
  set_clouds: function(ObjectRef, CloudParameters)
  get_clouds: function(ObjectRef): CloudParameters
  override_day_night_ratio: function(ObjectRef, number | nil)
  get_day_night_ratio: function(ObjectRef): number | nil
  set_local_animation: function(ObjectRef, Vec2, Vec2, Vec2, Vec2, number)
  get_local_animation: function(ObjectRef): {Vec2, Vec2, Vec2, Vec2, number}
  set_eye_offset: function(ObjectRef, Vec3, Vec3, Vec3)
  get_eye_offset: function(ObjectRef): Vec3, Vec3, Vec3
  send_mapblock: function(ObjectRef, Vec3)
  set_lighting: function(ObjectRef, LightingDefinition)
  get_lighting: function(ObjectRef): LightingDefinition
  respawn: function(ObjectRef)
}

function PcgRandom(_seed: number, _sequence: {number}): PcgRandomObject {}
interface PcgRandomObject {
  next: function(PcgRandomObject): number
  next: function(PcgRandomObject, number, number): number
  rand_normal_dist: function(PcgRandomObject, number, number, number): number
}

function PerlinNoise(_params: NoiseParams): PerlinNoiseObject {}
interface PerlinNoiseObject {
  get_2d: function(PerlinNoiseObject, Vec2): number
  get_3d: function(PerlinNoiseObject, Vec3): number
}

function PerlinNoiseMap(_params: NoiseParams, _size: Vec3): PerlinNoiseMapObject {}
interface PerlinNoiseMapObject {
  get_2d_map: function(PerlinNoiseMapObject, Vec2): number[][]
  get_3d_map: function(PerlinNoiseMapObject, Vec3): number[][][]
  get_2d_map_flat: function(PerlinNoiseMapObject, Vec2, {any}): {number}
  get_3d_map_flat: function(PerlinNoiseMapObject, Vec3, {any}): {number}
  calc_2d_map: function(PerlinNoiseMapObject, Vec2)
  calc_3d_map: function(PerlinNoiseMapObject, Vec3)
  get_map_slice: function(PerlinNoiseMapObject, Vec3, Vec3, {any}): {number}
}

function PseudoRandom(_seed: number): PseudoRandomObject {}
interface PseudoRandomObject {
  next: function(PseudoRandomObject): number
  next: function(PseudoRandomObject, number, number): number
}

interface PhysicsOverride {
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
}


interface PlayerControl {
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
}

enum SkyParametersType {
  "regular",
  "skybox",
  "plain"
}

enum SkyParametersFogTintType {
  "custom",
  "default"
}

interface SkyParametersColor {
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
}

interface SkyParametersFog {
  fog_distance: number
  fog_start: number
}

interface SkyParameters {
  base_color: DynamicColorSpec
  body_orbit_tilt: number
  type: SkyParametersType
  textures: {string}
  clouds: boolean
  sky_color: SkyParametersColor
  fog: SkyParametersFog
}

interface SunParameters {
  visible: boolean
  texture: string
  tonemap: string
  sunrise: string
  sunrise_visible: boolean
  scale: number
}

interface MoonParameters {
  visible: boolean
  texture: string
  tonemap: string
  scale: number
}

interface StarParameters {
  visible: boolean
  day_opacity: number
  count: number
  star_color: DynamicColorSpec
  scale: number
}

interface CloudParameters {
  density: number
  color: DynamicColorSpec
  ambient: DynamicColorSpec
  height: number
  thickness: number
  speed: Vec2
}

interface LightShadowsSpec {
  intensity: number
}

interface LightExposureSpec {
  luminance_min: number
  luminance_max: number
  exposure_correction: number
  speed_dark_bright: number
  speed_bright_dark: number
  center_weight_power: number
}

interface LightingDefinition {
  saturation: number
  shadows: LightShadowsSpec
  exposure: LightExposureSpec
}

type CollisionBox = Array<number>

interface ObjectProperties {
  hp_max: number
  breath_max: number
  zoom_fov: number
  eye_height: number
  physical: boolean
  collide_with_objects: boolean
  collisionbox: CollisionBox
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
}

interface EntityDefinition {
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
}

interface LuaEntity {
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
}

enum MinimapType {
  "off",
  "surface",
  "radar",
  "texture"
}

interface MinimapModes {
  type: MinimapType
  label: string
  size: number
  texture: string
  scale: number
}

interface HudFlags {
  hotbar: boolean
  healthbar: boolean
  crosshair: boolean
  wielditem: boolean
  breathbar: boolean
  minimap: boolean
  minimap_radar: boolean
  basic_debug: boolean
}

enum HudElementType {
  "image",
  "text",
  "statbar",
  "inventory",
  "waypoint",
  "image_waypoint",
  "compass",
  "minimap"
}

interface HudDefinition {
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
}

enum HudReplaceBuiltinOption {
  "breath",
  "health"
}

type Formspec = string

enum ParseRelativeNumberArgument {
  "<number>",
  "~<number>",
  "~"
}

enum CompressionMethod {
  "deflate",
  "zstd"
}

enum RotateAndPlaceOrientationFlag {
  "invert_wall",
  "force_wall",
  "force_ceiling",
  "force_floor",
  "force_facedir"
}

enum BlockStatusCondition {
  "unknown",
  "emerging",
  "loaded",
  "active"
}

enum TileAnimationType {
  "vertical_frames",
  "sheed_2d"
}

interface TileAnimationDefinition {
  type: TileAnimationType
  aspect_w: number
  aspect_h: number
  length: number
  frames_w: number
  frames_h: number
  frame_length: number
}

interface DetachedInventoryCallbacks {
  allow_move: function(InvRef, string, number, string, number, number, ObjectRef)
  allow_put: function(InvRef, string, number, ItemStackObject, ObjectRef)
  allow_take: function(InvRef, string, number, ItemStackObject, ObjectRef)
  on_move: function(InvRef, string, number, string, number, number, ObjectRef)
  on_put: function(InvRef, string, number, ItemStackObject, ObjectRef)
  on_take: function(InvRef, string, number, ItemStackObject, ObjectRef)
}

interface Rollback {
  actor: string
  pos: Vec3
  time: number
  oldnode: string
  newnode: string
}

interface Job {
  cancel: function()
}

interface DynamicAddMediaOptions {
  filepath: string
  to_player: string
  ephemeral: boolean
}

interface ParticleBounceDefinition {
  min: number
  max: number
  bias: number
}

interface ParticleDefinition {
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
}

enum ParticleSpawnerTweenStyle {
  "fwd",
  "rev",
  "pulse",
  "flicker"
}

interface ParticleSpawnerTweenDefinition extends Array<number | ParticleSpawnerRangeDefinition> {
  // {number | ParticleSpawnerRangeDefinition}
  style: ParticleSpawnerTweenStyle
  reps: number
  start: number
}

interface ParticleSpawnerRangeDefinition {
  min: Vec3
  max: Vec3
  bias: number
  pos_tween: ParticleSpawnerTweenDefinition
  x: number
  y: number
  z: number
}

enum ParticleSpawnerTextureBlend {
  "alpha",
  "add",
  "screen",
  "sub"
}

type ParticleSpawnerTextureScaleTween = Array<Vec2>

interface ParticleSpawnerTextureDefinition {
  name: string
  alpha: number
  alpha_tween: {number}
  scale: number | Vec2
  scale_tween: ParticleSpawnerTextureScaleTween
  blend: ParticleSpawnerTextureBlend
  animation: TileAnimationDefinition
}

interface TexturePoolComponentTweenDefinition extends Array<number> {
  style: ParticleSpawnerTweenStyle
  reps: number
}

enum TexturePoolComponentFade {
  "in",
  "out"
}

interface TexturePoolComponentDefinition {
  name: string
  fade: TexturePoolComponentFade
  alpha: number
  scale: number
  animation: TileAnimationDefinition
  alpha_tween: TexturePoolComponentTweenDefinition
}

type ParticleSpawnerTexturePoolDefinition = Array<string | TexturePoolComponentDefinition>

enum ParticleSpawnerAttractionType {
  "none",
  "point",
  "line",
  "plane"
}

interface ParticleSpawnerAttractionDefinition {
  kind: ParticleSpawnerAttractionType
  strength: Vec2
  origin: Vec3
  direction: Vec3
  origin_attached: ObjectRef
  direction_attached: ObjectRef
  die_on_contact: boolean
}

interface ParticleSpawnerDefinition {
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
}

enum AreaStoreType{
  "LibSpatial"
}

interface AreaStoreArea {
  min: Vec3
  max: Vec3
  data: string
}

interface AreaStoreCacheDefinition {
  enabled: boolean
  block_radius: number
  limit: number
}

function AreaStore(_: AreaStoreType): AreaStoreObject {}
interface AreaStoreObject {
  get_area: function(AreaStoreObject, number, boolean, boolean): AreaStoreArea[] | boolean[] | nil
  get_areas_for_pos: function(AreaStoreObject, Vec3, boolean, boolean): AreaStoreArea[] | boolean[] | nil
  get_areas_in_area: function(AreaStoreObject, Vec3, Vec3, boolean, boolean, boolean): AreaStoreArea[] | boolean[] | nil
  insert_area: function(AreaStoreObject, Vec3, Vec3, string, number): number
  reserve: function(AreaStoreObject, number)
  remove_area: function(AreaStoreObject, number): boolean
  set_cache_params: function(AreaStoreObject, AreaStoreCacheDefinition)
  to_string: function(AreaStoreObject): string
  to_file: function(AreaStoreObject, string)
  from_string: function(AreaStoreObject, string): [boolean, string] | nil
  from_file: function(AreaStoreObject, string): [boolean, string] | nil
}

interface vector {
  new: function(number, number, number): Vec3
  zero: function(): Vec3
  copy: function(Vec3): Vec3
  from_string: function(string, string): Vec3
  to_string: function(Vec3): string
  direction: function(Vec3, Vec3): Vec3
  distance: function(Vec3, Vec3): number
  length: function(Vec3): number
  normalize: function(Vec3): Vec3
  floor: function(Vec3): Vec3
  round: function(Vec3): Vec3
  apply: function(Vec3, function(number): number): Vec3
  combine: function(Vec3, Vec3, function()): Vec3
  equals: function(Vec3, Vec3): boolean
  sort: function(Vec3, Vec3): Vec3, Vec3
  angle: function(Vec3, Vec3): number
  dot: function(Vec3, Vec3): number
  cross: function(Vec3, Vec3): number
  check: function(Vec3): boolean
  in_area: function(Vec3, Vec3, Vec3): boolean

  add: function(Vec3, Vec3 | number): Vec3
  subtract: function(Vec3, Vec3 | number): Vec3
  multiply: function(Vec3, Vec3 | number): Vec3
  divide: function(Vec3, Vec3 | number): Vec3

  rotate: function(Vec3, number): Vec3
  rotate_around_axis: function(Vec3, Vec3, number): Vec3
  dir_to_rotation: function(Vec3, Vec3): Vec3

  random: function(number, number, number, number, number, number): Vec3
}

interface Vec2 {
  x: number
  y: number
}

interface Vec3 extends Vec2 {
  __eq: function(Vec3, Vec3): boolean
  __unm: function(Vec3): Vec3
  __add: function(Vec3, Vec3): Vec3
  __sub: function(Vec3, Vec3): Vec3
  __mul: function(Vec3, Vec3): Vec3
  __div: function(Vec3, Vec3): Vec3

  z: number
}

interface Vec3RangeBias {
  min: Vec3
  max: Vec3
  bias: Vec3
}

interface RGBA {
  r: number
  g: number
  b: number
  a: number
}

interface DigParamsReturn {
  diggable: boolean
  time: number
  wear: number
  groups: {string}
  tool_capabilities: ToolCapabilities
}

interface HitParamsReturn {
  hp: number
  wear: number
  groups: {string}
  tool_capabilities: ToolCapabilities
  time_from_last_punch: number
}

interface NodeTimerObject {
  set: function(NodeTimerObject, number, number)
  start: function(NodeTimerObject, number)
  stop: function(NodeTimerObject)
  get_timeout: function(NodeTimerObject): number
  get_elapsed: function(NodeTimerObject): number
  is_started: function(NodeTimerObject): boolean
}

interface Translator {
  __call: function(Translator, ...string): string
}

function dump(_: any, _: string, _: table): string {}

function dump2(_: any, _: table): string {}


// Getting around redecleration warnings with this little trick.
math.hypot = function(_: number, _: number): number {}
math.sign = function(_: number, _: number): number {}
math.factorial = function(_: number): number {}
math.round = function(_: number): number {}

string.split = function(_: string, _: string, _: box, _: NodeSoundSpec, _: boolean): string {}
string.trim = function(_: string): string {}

table.copy = function(_: table): table {}
table.indexof = function(_: table, _: number): number {}
table.insert_all = function(_: table, _: table): table {}
table.key_value_swap = function(_: table): table {}
table.shuffle = function(_: table, _: number, _: number, _: function): table {}