//? Note: This is a special hack to globalize components without a namespace.

let globalEnvironment = _G as unknown as {
	[key: string]: { [key: string]: string };
};

//! Done.
globalEnvironment.EntityVisual = {
	cube: "cube",
	sprite: "sprite",
	upright_sprite: "upright_sprite",
	mesh: "mesh",
	wielditem: "wielditem",
	item: "item",
};

globalEnvironment.SchematicRotation = {
	zero: "0",
	ninety: "90",
	oneEighty: "180",
	twoSeventy: "270",
	random: "random",
};

globalEnvironment.SchematicPlacementFlag = {
	place_center_x: "place_center_x",
	place_center_y: "place_center_y",
	place_center_z: "place_center_z",
};

globalEnvironment.SchematicFormat = {
	mts: "mts",
	lua: "lua",
};

globalEnvironment.SchematicSerializationOption = {
	lua_use_comments: "lua_use_comments",
	lua_num_indent_spaces: "lua_num_indent_spaces",
};

globalEnvironment.SchematicReadOptionYSliceOption = {
	none: "none",
	low: "low",
	all: "all",
};

globalEnvironment.HTTPRequestMethod = {
	GET: "GET",
	POST: "POST",
	PUT: "PUT",
	DELETE: "DELETE",
};

globalEnvironment.OreType = {
	scatter: "scatter",
	sheet: "sheet",
	puff: "puff",
	blob: "blob",
	vein: "vein",
	stratum: "stratum",
};

globalEnvironment.OreFlags = {
	puff_cliffs: "puff_cliffs",
	puff_additive_composition: "puff_additive_composition",
};

globalEnvironment.NoiseFlags = {
	defaults: "defaults",
	eased: "eased",
	absvalue: "absvalue",
};

globalEnvironment.DecorationType = {
	simple: "simple",
	schematic: "schematic",
};

globalEnvironment.DecorationFlags = {
	liquid_surface: "liquid_surface",
	force_placement: "force_placement",
	all_floors: "all_floors",
	all_ceilings: "all_ceilings",
	place_center_x: "place_center_x",
	place_center_y: "place_center_y",
	place_center_z: "place_center_z",
};

globalEnvironment.ParamType1 = {
	light: "light",
	none: "none",
};

globalEnvironment.ParamType2 = {
	flowingliquid: "flowingliquid",
	wallmounted: "wallmounted",
	facedir: "facedir",
	fourdir: "4dir",
	leveled: "leveled",
	degrotate: "degrotate",
	meshoptions: "meshoptions",
	color: "color",
	colorfacedir: "colorfacedir",
	color4dir: "color4dir",
	colorwallmounted: "colorwallmounted",
	glasslikeliquidlevel: "glasslikeliquidlevel",
	colordegrotate: "colordegrotate",
};

globalEnvironment.Drawtype = {
	normal: "normal",
	airlike: "airlike",
	liquid: "liquid",
	flowingliquid: "flowingliquid",
	glasslike: "glasslike",
	glasslike_framed: "glasslike_framed",
	glasslike_framed_optional: "glasslike_framed_optional",
	allfaces: "allfaces",
	allfaces_optional: "allfaces_optional",
	torchlike: "torchlike",
	signlike: "signlike",
	plantlike: "plantlike",
	firelike: "firelike",
	fencelike: "fencelike",
	raillike: "raillike",
	nodebox: "nodebox",
	mesh: "mesh",
	plantlike_rooted: "plantlike_rooted",
};

globalEnvironment.Nodeboxtype = {
	regular: "regular",
	fixed: "fixed",
	wallmounted: "wallmounted",
	connected: "connected",
};

globalEnvironment.LogLevel = {
	none: "none",
	error: "error",
	warning: "warning",
	action: "action",
	info: "info",
	verbose: "verbose",
};

globalEnvironment.TextureAlpha = {
	opaque: "opaque",
	clip: "clip",
	blend: "blend",
};

globalEnvironment.LiquidType = {
	none: "none",
	source: "source",
	flowing: "flowing",
};

globalEnvironment.NodeBoxConnections = {
	top: "top",
	bottom: "bottom",
	front: "front",
	left: "left",
	back: "back",
	right: "right",
};

globalEnvironment.CraftRecipeType = {
	shapeless: "shapeless",
	toolrepair: "toolrepair",
	cooking: "cooking",
	fuel: "fuel",
};

globalEnvironment.CraftCheckType = {
	normal: "normal",
	cooking: "cooking",
	fuel: "fuel",
};

globalEnvironment.HPChangeReasonType = {
	set_hp: "set_hp",
	punch: "punch",
	fall: "fall",
	node_damage: "node_damage",
	drown: "drown",
	respawn: "respawn",
};

globalEnvironment.CheatType = {
	moved_too_fast: "moved_too_fast",
	interacted_too_far: "interacted_too_far",
	interacted_with_self: "interacted_with_self",
	interacted_while_dead: "interacted_while_dead",
	finished_unknown_dig: "finished_unknown_dig",
	dug_unbreakable: "dug_unbreakable",
	dug_too_fast: "dug_too_fast",
};

globalEnvironment.ClearObjectsOptions = {
	full: "full",
	quick: "quick",
};

globalEnvironment.GenNotifyFlags = {
	dungeon: "dungeon",
	temple: "temple",
	cave_begin: "cave_begin",
	cave_end: "cave_end",
	large_cave_begin: "large_cave_begin",
	large_cave_end: "large_cave_end",
	decoration: "decoration",
};

globalEnvironment.SearchAlgorithm = {
	aStarNoprefetch: "A*_noprefetch",
	aStar: "A*",
	dijkstra: "Dijkstra",
};

globalEnvironment.SkyParametersType = {
	regular: "regular",
	skybox: "skybox",
	plain: "plain",
};

globalEnvironment.SkyParametersFogTintType = {
	custom: "custom",
	default: "default",
};

globalEnvironment.MinimapType = {
	off: "off",
	surface: "surface",
	radar: "radar",
	texture: "texture",
};

globalEnvironment.HudElementType = {
	image: "image",
	text: "text",
	statbar: "statbar",
	inventory: "inventory",
	waypoint: "waypoint",
	image_waypoint: "image_waypoint",
	compass: "compass",
	minimap: "minimap",
};

globalEnvironment.HudReplaceBuiltinOption = {
	breath: "breath",
	health: "health",
};

globalEnvironment.ParseRelativeNumberArgument = {
	number: "<number>",
	relativeToPlus: "~<number>",
	relativeTo: "~",
};

globalEnvironment.CompressionMethod = {
	deflate: "deflate",
	zstd: "zstd",
};

globalEnvironment.RotateAndPlaceOrientationFlag = {
	invert_wall: "invert_wall",
	force_wall: "force_wall",
	force_ceiling: "force_ceiling",
	force_floor: "force_floor",
	force_facedir: "force_facedir",
};

globalEnvironment.BlockStatusCondition = {
	unknown: "unknown",
	emerging: "emerging",
	loaded: "loaded",
	active: "active",
};

globalEnvironment.TileAnimationType = {
	vertical_frames: "vertical_frames",
	sheet_2d: "sheet_2d",
};

globalEnvironment.ParticleSpawnerTweenStyle = {
	fwd: "fwd",
	rev: "rev",
	pulse: "pulse",
	flicker: "flicker",
};

globalEnvironment.ParticleSpawnerTextureBlend = {
	alpha: "alpha",
	add: "add",
	screen: "screen",
	sub: "sub",
};

globalEnvironment.ParticleSpawnerAttractionType = {
	none: "none",
	point: "point",
	line: "line",
	plane: "plane",
};

globalEnvironment.AreaStoreType = {
	libSpatial: "LibSpatial",
};

globalEnvironment.TexturePoolComponentFade = {
	in: "in",
	out: "out",
};

/**
 * Available keyboard & mouse keys.
 */
globalEnvironment._Keys = {
	up: "up",
	down: "down",
	left: "left",
	right: "right",
	jump: "jump",
	aux1: "aux1",
	sneak: "sneak",
	dig: "dig",
	place: "place",
	LMB: "LMB",
	RMB: "RMB",
	zoom: "zoom",
};

globalEnvironment.ToolType = {
	pickaxe: "pickaxe",
	shovel: "shovel",
	axe: "axe",
	hoe: "hoe",
	sword: "sword",
	shears: "shears",
};

globalEnvironment.BlockType = {
	break_instant: "break_instant",
	soil: "soil",
	wood: "wood",
	leaf: "leaf",
	stone: "stone",
	metal: "metal",
	glass: "glass",
	wool: "wool",
	planks: "planks",
	tree: "tree",
	sand: "sand",
	lava_cooling: "lava_cooling",
	liquid: "liquid",
	water: "water",
	attached_node: "attached_node",
};

// This one is quite useful for crafting recipes.
globalEnvironment.CraftingBlockType = {
	soil: "group:soil",
	wood: "group:wood",
	leaf: "group:leaf",
	stone: "group:stone",
	metal: "group:metal",
	glass: "group:glass",
	wool: "group:wool",
	planks: "group:planks",
	tree: "group:tree",
	sand: "group:sand",
};

globalEnvironment.DamageGroup = {
	flesh: "flesh",
	metal: "metal",
	bone: "bone",
};

globalEnvironment.CraftRecipeType = {
	shapeless: "shapeless",
	toolrepair: "toolrepair",
	cooking: "cooking",
	fuel: "fuel",
};

globalEnvironment.EntityVisual = {
	cube: "cube",
	sprite: "sprite",
	upright_sprite: "upright_sprite",
	mesh: "mesh",
	wielditem: "wielditem",
	item: "item",
};

globalEnvironment.LogLevel = {
	none: "none",
	error: "error",
	warning: "warning",
	action: "action",
	info: "info",
	verbose: "verbose",
};

namespace types {
	/** Typescript Luaentity. :) */
	export abstract class Entity implements LuaEntity {
		// Name is required.
		abstract name: string;
		object: ObjectRef = utility.fakeRef();

		// Abstract members.
		initial_properties?: ObjectProperties | undefined;
		on_activate?(staticData: string, delta: number): void;
		on_deactivate?(removal: boolean): void;
		on_step?(delta: number, moveResult: MoveResult): void;
		on_punch?(
			puncher: ObjectRef,
			timeFromLastPunch: number,
			toolCapabilities: ToolCapabilities,
			dir: Vec3,
			damage: number
		): void;
		on_death?(killer: ObjectRef): void;
		on_rightclick?(clicker: ObjectRef): void;
		on_attach_child?(child: ObjectRef): void;
		on_detach_child?(child: ObjectRef): void;
		on_detach?(parent: ObjectRef): void;
		get_staticdata?(): string;
	}
}
