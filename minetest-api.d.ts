// Everything was just dumped in as I looked down the lua_api.md

interface minetest {
  get_current_modname(): string
  get_modpath(modName: string): string
  get_modnames(): string[]
  get_game_info(): GameInfo
  get_worldpath(): string
  is_singleplayer(): boolean
  features(): MinetestFeatures
  has_feature(featureName: string): boolean
  get_player_information(playerName: string): PlayerInformation
  get_player_window_information(playerName: string): WindowInformation
  mkdir(dir: string): boolean
  rmdir(dir: string): boolean
  cpdir(dir: string, dst: string): boolean
  mvdir(dir: string): boolean
  get_dir_list(dir: string, isDir: boolean): string[]
  safe_file_write(path: string, content: string): boolean
  get_version(): MinetestInfo
  sha1(data: any, raw: boolean): string
  colorspec_to_colorstring(colorSpec: ColorSpec): string
  colorspec_to_bytes(colorSpec: ColorSpec): string
  encode_png(width: number, height: number, data: ColorSpec[] | string, compression: number): string
  urlencode(url: string): string
  debug(anything: string): void
  log(level: LogLevel, text: string): void
  register_node(nodeName: string, definition: NodeDefinition): void
  register_craftitem(craftItemName: string, definition: ItemDefinition): void
  register_tool(toolName: string, definition: ItemDefinition): void
  override_item(itemName: string, {any : any}): void
  unregister_item(itemName: string): void
  register_entity(entityName: string, definition: EntityDefinition): void
  register_abm(abm: ABMDefinition): void
  register_lbm(lbm: LBMDefinition): void
  register_alias(alias: string, originalName: string): void
  register_alias_force(alias: string, originalName: string): void
  register_ore(ore: OreDefinition): void
  register_biome(biome: BiomeDefinition): void
  unregister_biome(biomeName: string): void
  register_decoration(decoration: DecorationDefinition): void
  register_schematic(schematic: SchematicDefinition): number
  clear_registered_biomes(): void
  clear_registered_decorations(): void
  clear_registered_ores(): void
  clear_registered_schematics(): void
  register_craft(craftRecipe: CraftRecipeDefinition): void
  clear_craft(craftRecipe: CraftRecipeDefinition): void
  register_chatcommand(commandName: string, definition: ChatCommandDefinition): void
  override_chatcommand(commandName: string, definition: ChatCommandDefinition): void
  unregister_chatcommand(commandName: string): void
  register_privilege(privilegeName: string, definition: PrivilegeDefinition): void
  register_authentication_handler(authHandler: AuthenticationHandlerDefinition): void
  register_globalstep(fun: function(number): void): void
  register_on_mods_loaded(fun: function(): void): void
  register_on_shutdown(fun: function(): void): void
  register_on_placenode(fun: function(Vec3, NodeTable, ObjectRef, NodeTable, ItemStackObject, PointedThing): void): void
  register_on_dignode(fun: function(Vec3, NodeTable, ObjectRef): void): void
  register_on_punchnode(fun: function(Vec3, NodeTable, ObjectRef, PointedThing): void): void
  register_on_generated(fun: function(Vec3, Vec3, number): void): void
  register_on_newplayer(fun: function(ObjectRef): void): void
  register_on_punchplayer(fun: function(ObjectRef, ObjectRef, number, ToolCapabilities, Vec3, number): void): void
  register_on_rightclickplayer(fun: function(ObjectRef, ObjectRef): void): void
  register_on_player_hpchange(fun: function(ObjectRef, number, HPChangeReasonDefinition): void, modifier: boolean): void
  register_on_dieplayer(fun: function(ObjectRef, HPChangeReasonDefinition): void): void
  register_on_respawnplayer(fun: function(ObjectRef): void): void
  register_on_prejoinplayer(fun: function(string, string): void): void
  register_on_joinplayer(fun: function(ObjectRef, string): void): void
  register_on_leaveplayer(fun: function(ObjectRef, boolean): void): void
  register_on_authplayer(fun: function(string, string, boolean): void): void
  register_on_auth_fail(fun: function(string, string): void): void
  register_on_cheat(fun: function(ObjectRef, CheatDefinition): void): void
  register_on_chat_message(fun: function(string, string): void): void
  register_on_chatcommand(fun: function(string, string, string): boolean): void
  register_on_player_receive_fields(fun: function(ObjectRef, string, {string : any}): void): void
  register_on_craft(fun: function(ItemStackObject, ObjectRef, any[], string): void): void
  register_craft_predict(fun: function(ItemStackObject, ObjectRef, any[], string): void): void
  register_allow_player_inventory_action(fun: function(ObjectRef, string, string, ActionDefinition): void): void
  register_on_player_inventory_action(fun: function(ObjectRef, string, string, ActionDefinition): void): void
  register_on_protection_violation(fun: function(Vec3, string): void): void
  register_on_item_eat(fun: function(number, boolean, ItemStackObject, ObjectRef, PointedThing): void): void
  register_on_item_pickup(fun: function(ItemStackObject, ObjectRef, PointedThing, number, ...any): void): void
  register_on_priv_grant(fun: function(string, string, string): void): void
  register_on_priv_revoke(fun: function(string, string, string): void): void
  register_can_bypass_userlimit(fun: function(string, string): void): void
  register_on_modchannel_message(fun: function(string, string, string): void): void
  register_on_liquid_transformed(fun: function(Vec3[], string[]): void): void
  register_on_mapblocks_changed(fun: function(string[], number): void): void
  settings: MinetestSettingsObject
  setting_get_pos(name: string): Vec3
  string_to_privs(str: string, delim: string): string
  privs_to_string(privs: string, delim: string): string
  get_player_privs(playerName: string): string[]
  check_player_privs(playerOrName: ObjectRef | string, stringListOrMap: string | Map<string, boolean>): boolean | boolean[]
  check_password_entry(playerName: string, entry: string, password: string): boolean
  get_password_hash(playerName: string, rawPassword: string): string
  get_player_ip(playerName: string): string
  get_auth_handler(): AuthenticationHandlerDefinition
  notify_authentication_modified(playerName: string): void
  set_player_password(playerName: string, passwordHash: string): void
  set_player_privs(playerName: string, {string : boolean}): void
  auth_reload(): void
  chat_send_all(message: string): void
  chat_send_player(playerName: string, message: string): void
  format_chat_message(playerName: string, message: string): void
  set_node(position: Vec3, nodeTable: NodeTable): void
  add_node(position: Vec3, nodeTable: NodeTable): void
  bulk_set_node(positions: Vec3[], nodeTable: NodeTable): void
  swap_node(position: Vec3, nodeTable: NodeTable): void
  remove_node(position: Vec3): void
  get_node(position: Vec3): NodeTable
  get_node_or_nil(position: Vec3): NodeTable | void
  get_node_light(position: Vec3, timeOfDay: number): number
  get_natural_light(position: Vec3, timeOfDay: number): number
  get_artificial_light(param1: number): number
  place_node(position: Vec3, nodeTable: NodeTable): void
  dig_node(position: Vec3): boolean
  punch_node(position: Vec3): void
  spawn_falling_node(position: Vec3): [boolean, ObjectRef] | boolean
  find_nodes_with_meta(pos1: Vec3, pos2: Vec3): Vec3[]
  get_meta(position: Vec3): MetaData
  get_node_timer(position: Vec3): NodeTimerObject
  add_entity(position: Vec3, entityName: string, staticData: string): ObjectRef | void
  add_item(position: Vec3, item: ItemStackObject | string): ObjectRef
  get_player_by_name(playerName: string): ObjectRef
  get_objects_inside_radius(position: Vec3, radius: number): ObjectRef[]
  get_objects_in_area(pos1: Vec3, pos2: Vec3): ObjectRef[]
  set_timeofday(newTimeOfDay: number): void
  get_timeofday(): number
  get_gametime(): number
  get_day_count(): number
  find_node_near(position: Vec3, radius: number, nodeNames: string[], searchCenter: boolean): Vec3 | void
  find_nodes_in_area(pos1: Vec3, pos2: Vec3, nodeNames: string[], grouped: boolean): any[] //! FIXME: returns a very specific thing, turn it into an interface
  find_nodes_in_area_under_air(pos1: Vec3, pos2: Vec3, nodeNames: string[]): Vec3[]
  get_perlin(nodeParams: NoiseParams): PerlinNoiseObject
  get_perlin(seedDiff: number, octaves: number, persistence: number, spread: number): PerlinNoiseObject
  get_voxel_manip(pos1: Vec3, pos2: Vec3): VoxelManipObject
  set_gen_notify(flags: GenNotifyFlags, decorationIDs: number[]): void
  get_gen_notify(): number[]
  get_decoration_id(decorationName: string): number
  get_mapgen_object(objectName: string): GenNotifyObject
  get_heat(position: Vec3): number
  get_humidity(position: Vec3): number
  get_biome_data(position: Vec3): BiomeDataDefinition | void
  get_biome_id(biomeName: string): number
  get_biome_name(biomeID: number): string
  get_mapgen_setting(settingName: string): MapGenSettingsDefinition
  set_mapgen_params(mapgenParams: MapGenSettingsDefinition): void
  get_mapgen_edges(mapgenLimit: number, chunkSize: number): void
  get_mapgen_setting(settingName: string): MapGenSettingsDefinition
  get_mapgen_setting_noiseparams(settingName: string): NoiseParams
  set_mapgen_setting(name: string, value: any, overrideMeta: boolean): void
  set_noiseparams(name: string, noiseParams: NoiseParams, overrideMeta: boolean): void
  get_noiseparams(name: string): NoiseParams
  generate_ores(voxelManip: VoxelManipObject, pos1: Vec3, pos2: Vec3): void
  generate_decorations(voxelManip: VoxelManipObject, pos1: Vec3, pos2: Vec3): void
  clear_objects(options: ClearObjectsOptions): void
  load_area(pos1: Vec3, pos2: Vec3): void
  emerge_area(pos1: Vec3, pos2: Vec3, fun: EmergeAreaCallback, param: any): void
  delete_area(pos1: Vec3, pos2: Vec3): void
  line_of_sight(pos1: Vec3, pos2: Vec3): [boolean, Vec3]
  raycast(pos1: Vec3, pos2: Vec3, hitObjects: boolean, hitLiquids: boolean): RaycastObject
  find_path(pos1: Vec3, pos2: Vec3, searchDistance: number, maxJump: number, maxDrop: number, algorithm: SearchAlgorithm): Vec3[]
  spawn_tree(position: Vec3, definition: TreeDefinition): void
  transforming_liquid_add(position: Vec3): void
  get_node_max_level(position: Vec3): number
  get_node_level(position: Vec3): number
  set_node_level(position: Vec3, level: number): number
  add_node_level(position: Vec3, level: number): number
  fix_light(pos1: Vec3, pos2: Vec3): boolean
  check_single_for_falling(position: Vec3): void
  check_for_falling(position: Vec3): void
  get_spawn_level(x: number, z: number): number | void
  mod_channel_join(channelName: string): void
  get_inventory(position: Vec3): InvRef
  get_perlin_map(params: NoiseParams, size: Vec3): PerlinNoiseMapObject
  get_inventory(position: Vec3): InvRef
  create_detached_inventory(name: string, callbacks: DetachedInventoryCallbacks, playerName: string): InvRef
  remove_detached_inventory(name: string): boolean
  do_item_eat(hpChange: number, replaceWithItem: ItemStackObject, itemStack: ItemStackObject, user: ObjectRef, pointedThing: PointedThing): ItemStackObject | void
  show_formspec(playerName: string, formName: string, formSpec: Formspec): void
  close_formspec(playerName: string, formName: string): void
  formspec_escape(escape: string): string
  explode_table_event(string: string): Map<any,any>
  explode_textlist_event(string: string): Map<any,any>
  explode_scrollbar_event(string: string): Map<any,any>
  inventorycube(img1: string, img2: string, img3: string): string
  get_pointed_thing_position(pointedThing: PointedThing, above: boolean): Vec3 | void
  dir_to_facedir(direction: Vec3, is6d: boolean): number
  facedir_to_dir(faceDir: number): Vec3
  dir_to_fourdir(direction: Vec3): number
  fourdir_to_dir(faceDir: number): Vec3
  dir_to_wallmounted(direction: Vec3): number
  wallmounted_to_dir(faceDir: number): Vec3
  dir_to_yaw(direction: Vec3): number
  yaw_to_dir(yaw: number): Vec3
  is_colored_paramtype(pType: number): boolean
  strip_param2_color(param2: number, paramType2: ParamType2): number | void
  get_node_drops(node: string | NodeTable, toolName: string): string[]
  get_craft_result(input: CraftRecipeDefinition): [ItemStackObject, ItemStackObject] //! TESTME: This documentation is confusing!
  get_craft_recipe(output: string | NodeTable): CraftRecipeDefinition | void
  get_all_craft_recipes(queryItem: string | NodeTable): CraftRecipeDefinition[] | void
  handle_node_drops(position: Vec3, drops: string[], digger: ObjectRef): void
  itemstring_with_palette(item: ItemStackObject, paletteIndex: number): string
  itemstring_with_color(item: ItemStackObject, colorString: DynamicColorSpec): string
  rollback_get_node_actions(position: Vec3, range: number, seconds: number, limit: number): Rollback[]
  rollback_revert_actions_by(actor: string, seconds: number): [boolean, string]
  item_place_node(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing, param2: number, preventAfterPlace: boolean): [ItemStackObject, Vec3 | void]
  //? Deprectated.
  // item_place_object(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing): ItemStackObject 
  item_place(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing, param2: number): [ItemStackObject, Vec3 | void]
  item_pickup(itemStack: ItemStackObject, picker: ObjectRef, pointedThing: PointedThing, timeFromLastPunch: number, ...any: any): ItemStackObject
  item_drop(itemStack: ItemStackObject, dropper: ObjectRef, position: Vec3): ItemStackObject
  item_eat(hpChange: number, replaceWithItem: string): void
  node_punch(position: Vec3, nodeTable: NodeTable, puncher: ObjectRef, pointedThing: PointedThing): void
  node_dig(position: Vec3, nodeTable: NodeTable, digger: ObjectRef): void
  after(seconds: number, fun: function(...any): void, ...any: any): Job
  handle_async(fun: function(...any): any, callback: function(...any): any, ...any: any): any // any any any any
  register_async_dofile(path: string): void
  request_shutdown(message: string, reconnect: boolean, delay: number): void
  cancel_shutdown_requests(): void
  get_server_status(name: string, joined: boolean): void
  get_server_uptime(): number
  get_server_max_lag(): number
  remove_player(playerName: string): number
  remove_player_auth(playerName: string): boolean
  dynamic_add_media(options: DynamicAddMediaOptions, fun: function(string): void): void
  get_ban_list(): string
  get_ban_description(ipOrName: string): string
  ban_player(playerName: string): boolean
  unban_player_or_ip(ipOrName: string): void
  kick_player(playerName: string, reason: string): boolean
  disconnect_player(name: string, reason: string): boolean
  add_particle(definition: ParticleDefinition): void
  add_particlespawner(definition: ParticleSpawnerDefinition): number
  delete_particlespawner(id: number, playerName: string): void
  create_schematic(pos1: Vec3, pos2: Vec3, probabilityList: SchematicProbability[], fileName: string, sliceProbList: SchematicSliceProbability[]): void
  place_schematic(position: Vec3, schematic: SchematicDefinition | string, rotation: SchematicRotation, replacements: Map<string, string>, forcePlacement: boolean, flags: SchematicPlacementFlag[]): void
  place_schematic_on_vmanip(voxelManip: VoxelManipObject, position: Vec3, schematic: SchematicDefinition, rotation: SchematicRotation, replacement: Map<string, string>, forcePlacement: boolean, flags: SchematicPlacementFlag[]): void
  serialize_schematic(schematic: SchematicDefinition, format: SchematicFormat, options: SchematicSerializationOption[]): void
  read_schematic(schematic: SchematicDefinition | string, options: SchematicReadOptionYSlice[]): Array<any>
  request_http_api(): HTTPApi
  get_mod_storage(): MetaRef
  get_connected_players(): ObjectRef[]
  is_player(thing: ObjectRef): boolean
  player_exists(playerName: string): boolean
  hud_replace_builtin(name: HudReplaceBuiltinOption, definition: HudDefinition): void
  parse_relative_number(arg: ParseRelativeNumberArgument, relativeTo: number): number | void
  send_join_message(playerName: string): void
  send_leave_message(playerName: string, timedOut: boolean): void
  hash_node_position(position: Vec3): number
  get_position_from_hash(hash: number): Vec3
  get_item_group(name: string, group: string): number
  raillike_group(name: string): number
  get_content_id(name: string): number
  get_name_from_content_id(id: number): string
  parse_json(string: string, nullValue: any): Array<any>
  write_json(data: any[], styled: boolean): string | void
  serialize(any: any): string
  deserialize(string: string, safe: boolean): Map<any, any>
  compress(data: string, method: CompressionMethod, ...any: any): string
  decompress(data: string, method: CompressionMethod, ...any: any): string
  rgba(red: number, green: number, blue: number, alpha: number): string
  encode_base64(string: string): string
  decode_base64(string: string): string
  is_protected(position: Vec3, name: string): boolean
  record_protection_violation(position: Vec3, name: string): void
  is_creative_enabled(name: string): boolean
  is_area_protected(pos1: Vec3, pos2: Vec3, playerName: string, interval: number): boolean
  rotate_and_place(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing, infiniteStacks: boolean, orientFlags: RotateAndPlaceOrientationFlag, preventAfterPlace: boolean): ItemStackObject
  rotate_node(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing): void
  calculate_knockback(player: ObjectRef, hitter: ObjectRef, timeFromLastPunch: number, toolCapabilities: ToolCapabilities, dir: Vec3, distance: number, damage: number): number
  forceload_block(position: Vec3, transient: boolean, limit: number): boolean
  forceload_free_block(position: Vec3, transient: boolean): void
  compare_block_status(position: Vec3, condition: BlockStatusCondition): boolean | void
  request_insecure_environment(): any
  global_exists(name: string): boolean

  registered_items: {string : ItemDefinition}
  registered_nodes: {string : NodeDefinition}
  registered_craftitems: {string : ItemDefinition}
  registered_tools: {string : ItemDefinition}
  registered_entities: {string : EntityDefinition}
  object_refs: {string : ObjectRef}
  luaentities: {string : LuaEntity}
  registered_abms: ABMDefinition[]
  registered_lbms: LBMDefinition[]
  registered_aliases: {string : string}
  registered_ores: {string : OreDefinition}
  registered_biomes: {string : BiomeDefinition}
  registered_decorations: {number : DecorationDefinition}
  registered_schematics: {string : SchematicDefinition}
  registered_chatcommands: {string : ChatCommandDefinition}
  registered_privileges: {string : PrivilegeDefinition}
  
  wrap_text(str: string, limit: number, asTable: boolean): string | string[]
  pos_to_string(position: Vec3, decimalPlaces: number): string
  string_to_pos(string: string): Vec3
  string_to_area(positions: string, relativeTo: Vec3): [Vec3, Vec3]
  formspec_escape(string: string): string
  is_yes(arg: any): boolean
  is_nan(arg: number): boolean
  get_us_time(): number
  pointed_thing_to_face_pos(placer: ObjectRef, pointedThing: PointedThing): Vec3
  get_tool_wear_after_use(uses: number, initialWear: number): number
  get_dig_params(groups: string[], toolCapabilities: ToolCapabilities, wear: number): DigParamsReturn
  get_hit_params(groups: string[], toolCapabilities: ToolCapabilities, timeFromLastPunch: number, wear: number): HitParamsReturn

  get_translator(textDomain: string): Translator
  translate(textDomain: string, ...string: string[]): string

  sound_play(spec: SimpleSoundSpec, parameters: SoundParameterTable, ephemeral: boolean): number
  sound_stop(handle: number): void
  sound_fade(handle: number, step: number, gain: number): void
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

enum ParamType1 {
  "light",
  "none"
}

enum ParamType2 {
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

type box = number[]

type boxTable = box[]

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
  tools: string[]
  rarity: number
  items: string[]
  inherit_color: boolean
  tool_groups: string | string[]
}

interface NodeDropSpec {
  max_items: number
  items: ItemDropSpec[]
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
  collisions: Collision[]
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
  on_place(itemStack: ItemStackObject, placer: ObjectRef, pointedThing: PointedThing): void
  on_secondary_use(itemStack: ItemStackObject, user: ObjectRef, pointedThing: PointedThing): void
  on_drop(itemStack: ItemStackObject, dropper: ObjectRef, position: Vec3): void
  on_pickup(itemStack: ItemStackObject, picker: ObjectRef, pointedThing: PointedThing, timeFromLastPunch: number, ...any: any): void
  on_use(itemStack: ItemStackObject, user: ObjectRef, pointedThing: PointedThing): void
  after_use(itemStack: ItemStackObject, user: ObjectRef, nodeTable: NodeTable, {string : any}): void
}

interface NodeDefinition {
  drawtype: drawtype
  visual_scale: number
  tiles: string[]
  overlay_tiles: string[]
  special_tiles: string[]
  color: DynamicColorSpec
  use_texture_alpha: TextureAlpha
  palette: string
  post_effect_color: DynamicColorSpec
  post_effect_color_shaded: boolean
  paramtype: ParamType1
  paramtype2: ParamType2
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
  connects_to: string[]
  connect_sides: NodeBoxConnections
  mesh: string
  selection_box: NodeBox
  collision_box: NodeBox
  legacy_facedir_simple: boolean
  legacy_wallmounted: boolean
  waving: number
  sounds: NodeSoundSpec
  drop: NodeDropSpec | string
  on_construct(position: Vec3): void
  on_destruct(position: Vec3): void
  after_destruct(position: Vec3, oldNode: MapNode): void
  on_flood(position: Vec3, oldNode: NodeTable, newNode: NodeTable): void
  preserve_metadata(position: Vec3, oldNode: NodeTable, oldMeta: NodeTable, drops: ItemStackObject[]): void
  after_place_node(position: Vec3, placer: ObjectRef, itemStack: ItemStackObject, pointedThing: PointedThing): void
  after_dig_node(position: Vec3, oldNode: NodeTable, oldMeta: string, digger: ObjectRef): void
  can_dig(position: Vec3, canDig: ObjectRef): boolean
  on_punch(position: Vec3, node: NodeTable, puncher: ObjectRef, pointedThing: PointedThing): void
  on_rightclick(position: Vec3, node: NodeTable, clicker: ObjectRef, itemStack: ItemStackObject, pointedThing: PointedThing): void
  on_dig(position: Vec3, node: NodeTable, digger: ObjectRef): void
  on_timer(position: Vec3, elapsed: number): void
  on_receive_fields(position: Vec3, formName: string, fields: Map<string, any>, sender: ObjectRef): void
  allow_metadata_inventory_move(position: Vec3, fromList: string, fromIndex: number, toList: string, toIndex: number, count: number, player: ObjectRef): void
  allow_metadata_inventory_put(position: Vec3, listName: string, index: number, stack: ItemStackObject, player: ObjectRef): void
  allow_metadata_inventory_take(position: Vec3, listName: string, index: number, stack: ItemStackObject, player: ObjectRef): void
  on_metadata_inventory_move(position: Vec3, fromList: string, fromIndex: number, toList: string, toIndex: number, count: number, player: ObjectRef): void
  on_metadata_inventory_put(position: Vec3, listName: string, index: number, stack: ItemStackObject, player: ObjectRef): void
  on_metadata_inventory_take(position: Vec3, listName: string, index: number, stack: ItemStackObject, player: ObjectRef): void
  on_blast(position: Vec3, intensity: number): void
  mod_origin: string
}

interface ABMDefinition {
  label: string
  nodenames: string[]
  neighbors: string[]
  interval: number
  chance: number
  min_y: number
  max_y: number
  catch_up: number
  action(pos: Vec3, node: NodeTable, activeObjectCount: number, activeObjectCountWider: number): void
}

interface LBMDefinition {
  label: string
  name: string
  nodenames: string[]
  run_at_every_load: boolean
  action(pos: Vec3, node: NodeTable, delta: number): void
}


enum SchematicRotation {
  zero = "0",
  ninety = "90",
  oneEighty = "180",
  twoSeventy = "270",
  random = "random"
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

const enum SchematicSerializationOption {
  "lua_use_comments",
  "lua_num_indent_spaces"
}

enum SchematicReadOptionYSliceOption {
  "none",
  "low",
  "all"
}

interface SchematicReadOptionYSlice {
  write_yslice_prob: SchematicReadOptionYSliceOption
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
  extra_headers: string[]
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
  fetch(req: HTTPrequestDefinition, callback: (res: HTTPRequestResult) => void): void
  fetch_async(req: HTTPrequestDefinition): number
  fetch_async_get(handle: number): HTTPRequestResult
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
  biomes: string[]
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
  node_cave_liquid: string | string[]
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
  biomes: string[]
  y_min: number
  y_max: number
  spawn_by: string
  check_offset: number
  num_spawn_by: number
  flags: string | {string : boolean}
  decoration: string | string[]
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
  recipe: string[] | string
  replacements: string[]
  additional_wear: number
  cooktime: number
  burntime: number
}

interface ChatCommandDefinition {
  params: string
  description: string
  privs: string[]
  func(name: string, param: string): [boolean, string]
}

interface PrivilegeDefinition {
  description: string
  give_to_singleplayer: boolean
  give_to_admin: boolean
  on_grant(name: string, granterName: string): void
  on_revoke(name: string, revokerName: string): void
}

interface AuthenticationHandlerDefinition {
  get_auth(name: string): void
  create_auth(name: string, password: string): void
  delete_auth(name: string): void
  set_password(name: string, password: string): void
  set_privileges(name: string, privileges: Map<any,any>): void // ! fixme: this needs to be checked.
  reload(): void
  record_login(name: string): void
  iterate(): void
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


type EmergeAreaCallback = (blockPos: Vec3, action: any, callsRemaining: number, param: any) => void // ! FIXME: figure out what minetest.EMERGE_CANCELLED EVEN IS!

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
  set_tool_capabilities(toolCapabilities: ToolCapabilities): void
  contains(key: string): boolean
  get(key: string): string
  set_string(key: string, value: string): void
  get_string(key: string): string
  set_int(key: string, value: number): void
  get_int(key: string): number
  set_float(key: string, value: number): void
  get_float(key: string): number
  get_keys(): string[]
  to_table(): MetaData | void
  from_table(data: MetaData): boolean
  equals(other: MetaRef): boolean
  //! FIXME: USE INHERITENCE!
  // node
  get_inventory(): InvRef
  mark_as_private(nameOrArray: string | string[]): void
  // timer
  set(timeOut: number, elapsed: number): void
  start(timeOut: number): void
  stop(): void
  get_timeout(): number
  get_elapsed(): number
  is_started(): boolean
}


function ItemStack(_: ItemStackObject | string): ItemStackObject
interface ItemStackObject {
  name: string
  count: number
  wear: number
  metadata: string

  is_empty(): boolean
  get_name(): string
  set_name(name: string): boolean
  get_count(): number
  set_count(count: number): boolean
  get_wear(): number
  set_wear(wear: number): boolean
  get_meta(): MetaRef
  get_description(): string
  get_short_description(): string
  clear(): void
  replace(item: ItemStackObject | string): void
  to_string(): string
  to_table(): any[]
  get_stack_max(): number
  get_free_space(): number
  is_known(): boolean
  get_definition(): ItemDefinition
  get_tool_capabilities(): ToolCapabilities
  add_wear(wear: number): void
  add_wear_by_uses(maxUses: number): void
  add_item(item: ItemStackObject): ItemStackObject
  item_fits(item: ItemStackObject): boolean
  take_item(n: number): ItemStackObject
  peek_item(n: number): ItemStackObject
  equals(other: ItemStackObject): boolean
}


interface InvRefLocation {
  type: string
  name: string
  pos: Vec3
}

interface InvRef {
  is_empty(listName: string): boolean
  get_size(listName: string): number
  set_size(listName: string, size: number): boolean
  get_width(listName: string): number
  set_width(listName: string, size: number): void
  get_stack(listName: string, i: number): ItemStackObject
  set_stack(listName: string, i: number, stack: ItemStackObject): void
  get_list(listName: string): ItemStackObject[]
  set_list(listName: string, list: ItemStackObject[]): void
  get_lists(): string[]
  set_lists(lists: ItemStackObject[]): void
  add_item(listName: string, stack: ItemStackObject | string): ItemStackObject
  room_for_item(listName: string, stack: ItemStackObject | string): boolean
  contains_item(listName: string, stack: ItemStackObject | string, matchMeta: boolean): boolean
  remove_item(listName: string, stack: ItemStackObject | string): ItemStackObject[]
  get_location(): InvRefLocation
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
  
type GenNotifyObject = Map<string, Vec3[]>

function VoxelManip(_pos1: Vec3, _pos2: Vec3): VoxelManipObject
interface VoxelManipObject {
  read_from_map(pos1: Vec3, pos2: Vec3): [Vec3, Vec3]
  write_to_map(light: boolean): void
  get_node_at(position: Vec3): MapNode
  set_node_at(position: Vec3, node: MapNode): void
  get_data(buffer?: number[]): number[]
  set_data(buffer?: number[]): number[]
  set_lighting(light: number, p1: Vec3, p2: Vec3): void
  get_light_data(buffer: number[]): number[]
  set_light_data(lightData: number[]): void
  get_param2_data(buffer: number[]): number[]
  set_param2_data(param2Data: number[]): void
  calc_lighting(p1: Vec3, p2: Vec3, propagateShadows: boolean): void
  update_liquids(): void
  was_modified(): boolean
  get_emerged_area(): [Vec3, Vec3]
}

interface VoxelAreaInitializer {
  MinEdge: Vec3
  MaxEdge: Vec3
}

function VoxelArea(_min: Vec3, _max: Vec3): VoxelAreaObject
interface VoxelAreaObject {
  ystride: number
  zstride: number
  new(init: VoxelAreaInitializer): VoxelAreaObject
  getExtent(): Vec3
  index(x: number, y: number, z: number): number
  indexp(p: Vec3): number
  position(i: number): Vec3
  contains(x: number, y: number, z: number): boolean
  containsp(p: Vec3): boolean
  containsi(i: number): boolean
  iter(minX: number, minY: number, minZ: number, maxX: number, maxY: number, maxZ: number): Iterator<number>
  iterp(minp: Vec3, maxp: Vec3): Iterator<number>
}

interface HeightMapObject {

}

interface BiomeMapObject {

}

interface HeatMapObject {

}

interface HumidityMapObject {

}

function Raycast(_pos1: Vec3, _pos2: Vec3, _object: boolean, _liquids: boolean): RaycastObject
interface RaycastObject {
   __call(): Iterator<PointedThing>
}

function SecureRandom(): SecureRandomObject
interface SecureRandomObject {
  next_bytes(count: number): string
}

function Settings(_: string): MinetestSettingsObject
interface MinetestSettingsObject {
  get(key: string): any
  get_bool(key: string, defaul?: boolean): boolean | null
  get_np_group(key: string): NoiseParams
  get_flags(key: string): {string : boolean}
  set(key: string, value: string): void
  set_bool(key: string, value: boolean): void
  set_np_group(key: string, value: NoiseParams): void
  remove(key: string): boolean
  get_names(): string[]
  has(key: string): boolean
  write(): boolean
  to_table(): Map<string, any>
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
  get_pos(): Vec3
  set_pos(position: Vec3): void
  get_velocity(): Vec3
  add_velocity(velocity: Vec3): void
  move_to(newPos: Vec3, continuous: boolean): void
  punch(puncher: ObjectRef, timeFromLastPunch: number, toolCapabilities: ToolCapabilities, dir: Vec3): void
  right_click(clicker: ObjectRef): void
  get_hp(): number
  set_hp(hp: number, reason: HPChangeReasonType): void
  get_inventory(): InvRef
  get_wield_list(): string
  get_wield_index(): number
  get_wielded_item(): ItemStackObject
  set_wielded_item(item: ItemStackObject): boolean
  get_armor_groups(): {string : number}
  set_armor_groups(groups: {string : number}): void
  get_animation(): Array<Vec2 | number>
  set_animation(frameRange: Vec2, frameSpeed: number, frameBlend: number, loop: boolean): void
  set_animation_frame_speed(speed: number): void
  set_attach(parent: ObjectRef, bone: string, position: Vec3, rotation: Vec3, forcedVisible: boolean): void
  get_attach(): AttachRef | void
  get_children(): ObjectRef[]
  set_detach(): void
  set_bone_position(bone: string, position: Vec3, rotation: Vec3): void
  set_properties(objectPropertiesTable: {any : any}): void
  get_properties(): {any : any}
  is_player(): boolean
  get_nametag_attributes(): NametagAttributes
  set_nametag_attributes(attributes: NametagAttributes): void
  remove(): void
  set_velocity(velocity: Vec3): void
  set_acceleration(acceleration: Vec3): void
  get_acceleration(): Vec3
  set_rotation(rotation: Vec3): void
  get_rotation(): Vec3
  set_yaw(yaw: number): void
  get_yaw(): number
  set_texture_mod(mod: string): void
  get_texture_mod(): string
  set_sprite(startFrame: Vec2, numberOfFrames: number, frameLength: number, selectXByCamera: boolean): void
  name: string
  get_luaentity(): LuaEntity
  get_player_name(): string
  get_look_dir(): Vec3
  get_look_vertical(): number
  get_look_horizontal(): number
  set_look_vertical(radians: number): void
  set_look_horizontal(radians: number): void
  get_look_pitch(): number
  get_look_yaw(): number
  set_look_pitch(radians: number): void
  set_look_yaw(radians: number): void
  get_breath(): number
  set_breath(value: number): void
  set_fov(fov: number, isMultiplier: boolean, transitionTime: number): void
  get_fov(): number
  get_meta(): MetaRef
  set_inventory_formspec(formSpec: Formspec): void
  get_inventory_formspec(): Formspec
  set_formspec_prepend(formSpec: Formspec): void
  get_formspec_prepend(): Formspec
  get_player_control(): PlayerControl
  get_player_control_bits(): number
  set_physics_override(override: PhysicsOverride): void
  get_physics_override(): PhysicsOverride
  hud_add(definition: HudDefinition): number
  hud_remove(id: number): void
  hud_change(id: number, stat: HudElementType, value: any): void
  hud_get(id: number): HudDefinition
  hud_set_flags(flags: HudFlags): void
  hud_get_flags(): HudFlags
  hud_set_hotbar_itemcount(count: number): void
  hud_get_hotbar_itemcount(): number
  hud_set_hotbar_image(textureName: string): void
  hud_get_hotbar_image(): string
  hud_set_hotbar_selected_image(textureName: string): void
  hud_get_hotbar_selected_image(): string
  set_minimap_modes(mode: MinimapModes, selectedMode: number): void
  set_sky(parameters: SkyParameters): void
  get_sky(asTable: true): SkyParameters
  set_sun(parameters: SunParameters): void
  get_sun(): SunParameters
  set_moon(parameters: MoonParameters): void
  get_moon(): MoonParameters
  set_stars(parameters: StarParameters): void
  get_stars(): StarParameters
  set_clouds(parameters: CloudParameters): void
  get_clouds(): CloudParameters
  override_day_night_ratio(ratio: number | void): void
  get_day_night_ratio(): number | void
  set_local_animation(idle: Vec2, walk: Vec2, dig: Vec2, walkWhileDig: Vec2, frameSpeed: number): void
  get_local_animation(): [Vec2, Vec2, Vec2, Vec2, number]
  set_eye_offset(firstPerson: Vec3, thirdPersonBack: Vec3, thirdPersonFront: Vec3): void
  get_eye_offset(): [Vec3, Vec3, Vec3]
  send_mapblock(blockPos: Vec3): boolean
  set_lighting(definition: LightingDefinition): void
  get_lighting(): LightingDefinition
  respawn(): void
}

function PcgRandom(seed: number, sequence: number[]): PcgRandomObject
interface PcgRandomObject {
  next(): number
  next(min: number, max: number): number
  rand_normal_dist(min: number, max: number, trials: number): number
}

function PerlinNoise(params: NoiseParams): PerlinNoiseObject
interface PerlinNoiseObject {
  get_2d(position: Vec2): number
  get_3d(position: Vec3): number
}

function PerlinNoiseMap(params: NoiseParams, size: Vec3): PerlinNoiseMapObject
interface PerlinNoiseMapObject {
  get_2d_map(pos: Vec2): number[][]
  get_3d_map(pos: Vec3): number[][][]
  get_2d_map_flat(pos: Vec2, buffer: number[]): number[]
  get_3d_map_flat(pos: Vec3, buffer: number[]): number[]
  calc_2d_map(pos: Vec2): void
  calc_3d_map(pos: Vec3): void
  get_map_slice(sliceOffset: Vec3, sliceSize: Vec3, buffer: number[]): number[]
}

function PseudoRandom(seed: number): PseudoRandomObject
interface PseudoRandomObject {
  next(): number
  next(min: number, max: number): number
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
  textures: string[]
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
  selectionbox: number[]
  pointable: boolean
  visual: EntityVisual
  visual_size: Vec3
  mesh: string
  textures: string[]
  colors: DynamicColorSpec[]
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
  on_activate(LuaEntity, string, number)
  on_deactivate(LuaEntity, boolean)
  on_step(LuaEntity, number, MoveResult)
  on_punch(LuaEntity, ObjectRef, number, ToolCapabilities, Vec3, number)
  on_death(LuaEntity, ObjectRef)
  on_rightclick(LuaEntity, ObjectRef)
  on_attach_child(LuaEntity, ObjectRef)
  on_detach_child(LuaEntity, ObjectRef)
  on_detach(LuaEntity, ObjectRef)
  get_staticdata(LuaEntity)
}

interface LuaEntity {
  initial_properties: ObjectProperties
  name: string
  object: ObjectRef
  on_activate(LuaEntity, string, number)
  on_deactivate(LuaEntity, boolean)
  on_step(LuaEntity, number, MoveResult)
  on_punch(LuaEntity, ObjectRef, number, ToolCapabilities, Vec3, number)
  on_death(LuaEntity, ObjectRef)
  on_rightclick(LuaEntity, ObjectRef)
  on_attach_child(LuaEntity, ObjectRef)
  on_detach_child(LuaEntity, ObjectRef)
  on_detach(LuaEntity, ObjectRef)
  get_staticdata(LuaEntity)
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