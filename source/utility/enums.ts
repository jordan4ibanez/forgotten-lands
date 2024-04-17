// This file simply makes this function with the minetest-api.d.ts file. :)
// It creates the actual data. If you don't have utility as a dependency in a mod. This blows up.
// Hooray!

export enum EntityVisual {
  cube = "cube",
  sprite = "sprite",
  upright_sprite = "upright_sprite",
  mesh = "mesh",
  wielditem = "wielditem",
  item = "item"
}

export enum SchematicRotation {
  zero = "0",
  ninety = "90",
  oneEighty = "180",
  twoSeventy = "270",
  random = "random"
}

export enum SchematicPlacementFlag {
  place_center_x = "place_center_x",
  place_center_y = "place_center_y",
  place_center_z = "place_center_z"
}

export enum SchematicFormat {
  mts = "mts",
  lua = "lua"
}

export enum SchematicSerializationOption {
  lua_use_comments = "lua_use_comments",
  lua_num_indent_spaces = "lua_num_indent_spaces"
}

export enum SchematicReadOptionYSliceOption {
  none = "none",
  low = "low",
  all = "all"
}

export enum HTTPRequestMethod {
  GET = "GET",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE"
}


export enum OreType {
  scatter = "scatter",
  sheet = "sheet",
  puff = "puff",
  blob = "blob",
  vein = "vein",
  stratum = "stratum"
}

export enum OreFlags {
  puff_cliffs = "puff_cliffs",
  puff_additive_composition = "puff_additive_composition"
}

export enum NoiseFlags {
  defaults = "defaults",
  eased = "eased",
  absvalue = "absvalue"
}

export enum DecorationType {
  simple = "simple",
  schematic = "schematic"
}

export enum DecorationFlags {
  liquid_surface = "liquid_surface",
  force_placement = "force_placement",
  all_floors = "all_floors",
  all_ceilings = "all_ceilings",
  place_center_x = "place_center_x",
  place_center_y = "place_center_y",
  place_center_z = "place_center_z"
}


export enum ParamType1 {
  light = "light",
  none = "none"
}

export enum ParamType2 {
  flowingliquid = "flowingliquid",
  wallmounted = "wallmounted",
  facedir = "facedir",
  fourdir = "4dir",
  leveled = "leveled",
  degrotate = "degrotate",
  meshoptions = "meshoptions",
  color = "color",
  colorfacedir = "colorfacedir",
  color4dir = "color4dir",
  colorwallmounted = "colorwallmounted",
  glasslikeliquidlevel = "glasslikeliquidlevel",
  colordegrotate = "colordegrotate"
}

export enum Drawtype {
  normal = "normal",
  airlike = "airlike",
  liquid = "liquid",
  flowingliquid = "flowingliquid",
  glasslike = "glasslike",
  glasslike_framed = "glasslike_framed",
  glasslike_framed_optional = "glasslike_framed_optional",
  allfaces = "allfaces",
  allfaces_optional = "allfaces_optional",
  torchlike = "torchlike",
  signlike = "signlike",
  plantlike = "plantlike",
  firelike = "firelike",
  fencelike = "fencelike",
  raillike = "raillike",
  nodebox = "nodebox",
  mesh = "mesh",
  plantlike_rooted = "plantlike_rooted"
}


export enum Nodeboxtype {
  regular = "regular",
  fixed = "fixed",
  wallmounted = "wallmounted",
  connected = "connected"
}


export enum LogLevel {
  none = "none",
  error = "error",
  warning = "warning",
  action = "action",
  info = "info",
  verbose = "verbose"
}

export enum TextureAlpha {
  opaque = "opaque",
  clip = "clip",
  blend = "blend"
}

export enum LiquidType {
  none = "none",
  source = "source",
  flowing = "flowing"
}

export enum NodeBoxConnections {
  top = "top",
  bottom = "bottom",
  front = "front",
  left = "left",
  back = "back",
  right = "right"
}

export enum CraftRecipeType {
  shapeless = "shapeless",
  toolrepair = "toolrepair",
  cooking = "cooking",
  fuel = "fuel"
}

export enum CraftCheckType {
  normal = "normal",
  cooking = "cooking",
  fuel = "fuel"
}

export enum HPChangeReasonType {
  set_hp = "set_hp",
  punch = "punch",
  fall = "fall",
  node_damage = "node_damage",
  drown = "drown",
  respawn = "respawn"
}

export enum CheatType {
  moved_too_fast = "moved_too_fast",
  interacted_too_far = "interacted_too_far",
  interacted_with_self = "interacted_with_self",
  interacted_while_dead = "interacted_while_dead",
  finished_unknown_dig = "finished_unknown_dig",
  dug_unbreakable = "dug_unbreakable",
  dug_too_fast = "dug_too_fast"
}

export enum ClearObjectsOptions {
  full = "full",
  quick = "quick"
}

export enum GenNotifyFlags {
  dungeon = "dungeon",
  temple = "temple",
  cave_begin = "cave_begin",
  cave_end = "cave_end",
  large_cave_begin = "large_cave_begin",
  large_cave_end = "large_cave_end",
  decoration = "decoration"
}

export enum SearchAlgorithm {
  aStarNoprefetch = "A*_noprefetch",
  aStar = "A*",
  dijkstra = "Dijkstra"
}


export enum SkyParametersType {
  regular = "regular",
  skybox = "skybox",
  plain = "plain"
}

export enum SkyParametersFogTintType {
  custom = "custom",
  default = "default"
}

export enum MinimapType {
  off = "off",
  surface = "surface",
  radar = "radar",
  texture = "texture"
}

export enum HudElementType {
  image = "image",
  text = "text",
  statbar = "statbar",
  inventory = "inventory",
  waypoint = "waypoint",
  image_waypoint = "image_waypoint",
  compass = "compass",
  minimap = "minimap"
}

export enum HudReplaceBuiltinOption {
  breath = "breath",
  health = "health"
}


export enum ParseRelativeNumberArgument {
  number = "<number>",
  relativeToPlus = "~<number>",
  relativeTo = "~"
}

export enum CompressionMethod {
  deflate = "deflate",
  zstd = "zstd"
}

export enum RotateAndPlaceOrientationFlag {
  invert_wall = "invert_wall",
  force_wall = "force_wall",
  force_ceiling = "force_ceiling",
  force_floor = "force_floor",
  force_facedir = "force_facedir"
}

export enum BlockStatusCondition {
  unknown = "unknown",
  emerging = "emerging",
  loaded = "loaded",
  active = "active"
}

export enum TileAnimationType {
  vertical_frames = "vertical_frames",
  sheet_2d = "sheet_2d"
}

export enum ParticleSpawnerTweenStyle {
  fwd = "fwd",
  rev = "rev",
  pulse = "pulse",
  flicker = "flicker"
}

export enum ParticleSpawnerTextureBlend {
  alpha = "alpha",
  add = "add",
  screen = "screen",
  sub = "sub"
}

export enum ParticleSpawnerAttractionType {
  none = "none",
  point = "point",
  line = "line",
  plane = "plane"
}

export enum AreaStoreType {
  libSpatial = "LibSpatial"
}

export enum TexturePoolComponentFade {
  in = "in",
  out = "out"
}
