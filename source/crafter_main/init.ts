namespace main {
    const path: string | null = core.get_modpath("crafter_main");
    if (!path) {
        throw new Error("crafter_main doesn't exist!?");
    }

    utility.loadFiles([
        `${path}/sounds.lua`,
        `${path}/nodes.lua`,
        `${path}/grass_spread.lua`,
        `${path}/saplings.lua`,
        `${path}/ore.lua`,
        `${path}/items.lua`,
        `${path}/schematics.lua`,
        `${path}/mapgen.lua`,
        `${path}/tools.lua`,
        `${path}/settings.lua`,
        `${path}/craft_recipes.lua`,
        `${path}/falling.lua`,
        `${path}/bucket.lua`,
        `${path}/lava_cooling.lua`,
        `${path}/command_overrides.lua`
    ]);
}
