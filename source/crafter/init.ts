namespace crafter {
	const path: string | null = core.get_modpath("crafter");
	if (!path) {
		throw new Error("crafter doesn't exist!?");
	}

	utility.loadFiles([
		"sounds",
		"nodes",
		"grass_spread",
		"saplings",
		"ore",
		"items",
		"schematics",
		"mapgen",
		"tools",
		"settings",
		"craft_recipes",
		"falling",
		"bucket",
		"lava_cooling",
		"command_overrides",
	]);
}
