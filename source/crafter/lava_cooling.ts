core.register_abm({
	label: "Lava cooling",
	nodenames: ["main:lava"],
	neighbors: ["main:water", "main:waterflow"],
	interval: 1.0,
	chance: 5.0,
	catch_up: false,
	action: (pos: Vec3) => {
		core.set_node(pos, { name: "nether:obsidian" });
	},
});

core.register_abm({
	label: "Lava cooling",
	nodenames: ["main:lavaflow"],
	neighbors: ["main:water", "main:waterflow"],
	interval: 1.0,
	chance: 5.0,
	catch_up: false,
	action: (pos: Vec3) => {
		core.set_node(pos, { name: "main:cobble" });
	},
});
