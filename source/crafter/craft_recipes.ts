// local minetest,pairs = minetest,pairs
// Crafting recipes.

namespace crafter {
	//? Cooking.

	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:diamond",
		recipe: "crafter:diamondore",
		cooktime: 12,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:coal 4",
		recipe: "crafter:coalore",
		cooktime: 3,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:charcoal",
		recipe: "crafter:tree",
		cooktime: 2,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:gold",
		recipe: "crafter:goldore",
		cooktime: 9,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:iron",
		recipe: "crafter:ironore",
		cooktime: 6,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:stone",
		recipe: "crafter:cobble",
		cooktime: 2,
	});

	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "crafter:glass",
		recipe: "crafter:sand",
		cooktime: 1,
	});

	//? Fuel.

	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:stick",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:sapling",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:paper",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:tree",
		burntime: 24,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:wood",
		burntime: 12,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:leaves",
		burntime: 3,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:coal",
		burntime: 20,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "crafter:charcoal",
		burntime: 7,
	});

	//? Crafting.

	core.register_craft({
		type: CraftRecipeType.shapeless,
		output: "crafter:wood 4",
		recipe: ["crafter:tree"],
	});
	core.register_craft({
		type: CraftRecipeType.shapeless,
		output: "crafter:sugar 3",
		recipe: ["farming:sugarcane"],
	});
	core.register_craft({
		output: "crafter:stick 4",
		recipe: [["crafter:wood"], ["crafter:wood"]],
	});
	core.register_craft({
		output: "crafter:paper",
		recipe: [
			["farming:sugarcane", "farming:sugarcane", "farming:sugarcane"],
		],
	});

	// Tool name.
	const __tools: string[] = [
		"coal",
		"wood",
		"stone",
		"lapis",
		"iron",
		"gold",
		"diamond",
		"emerald",
		"sapphire",
		"ruby",
	];
	// Material to craft.
	const material: string[] = [
		"coal",
		"wood",
		"cobble",
		"lapis",
		"iron",
		"gold",
		"diamond",
		"emerald",
		"sapphire",
		"ruby",
	];

	for (const [id, tool] of __tools.entries()) {
		core.register_craft({
			output: "crafter:" + tool + "pick",
			recipe: [
				[
					"crafter:" + material[id],
					"crafter:" + material[id],
					"crafter:" + material[id],
				],
				["", "crafter:stick", ""],
				["", "crafter:stick", ""],
			],
		});
		core.register_craft({
			output: "crafter:" + tool + "shovel",
			recipe: [
				["", "crafter:" + material[id], ""],
				["", "crafter:stick", ""],
				["", "crafter:stick", ""],
			],
		});
		core.register_craft({
			output: "crafter:" + tool + "axe",
			recipe: [
				["crafter:" + material[id], "crafter:" + material[id], ""],
				["crafter:" + material[id], "crafter:stick", ""],
				["", "crafter:stick", ""],
			],
		});
		core.register_craft({
			output: "crafter:" + tool + "axe",
			recipe: [
				["", "crafter:" + material[id], "crafter:" + material[id]],
				["", "crafter:stick", "crafter:" + material[id]],
				["", "crafter:stick", ""],
			],
		});
		core.register_craft({
			output: "crafter:" + tool + "sword",
			recipe: [
				["", "crafter:" + material[id], ""],
				["", "crafter:" + material[id], ""],
				["", "crafter:stick", ""],
			],
		});
	}

	core.register_craft({
		output: "crafter:ladder 16",
		recipe: [
			["crafter:stick", "", "crafter:stick"],
			["crafter:stick", "crafter:stick", "crafter:stick"],
			["crafter:stick", "", "crafter:stick"],
		],
	});

	core.register_craft({
		output: "crafter:shears",
		recipe: [
			["", "crafter:iron"],
			["crafter:iron", ""],
		],
	});

	core.register_craft({
		output: "crafter:bucket",
		recipe: [
			["crafter:iron", "", "crafter:iron"],
			["", "crafter:iron", ""],
		],
	});

	//? Tool repair.

	core.register_craft({
		type: CraftRecipeType.toolrepair,
		additional_wear: -0.02,
	});

	const raw_material: string[] = [
		"coal",
		"lapis",
		"iron",
		"gold",
		"diamond",
		"emerald",
		"sapphire",
		"ruby",
	];
	for (const name of raw_material) {
		core.register_craft({
			output: "crafter:" + name + "block",
			recipe: [
				["crafter:" + name, "crafter:" + name, "crafter:" + name],
				["crafter:" + name, "crafter:" + name, "crafter:" + name],
				["crafter:" + name, "crafter:" + name, "crafter:" + name],
			],
		});
		core.register_craft({
			type: CraftRecipeType.shapeless,
			output: "crafter:" + name + " 9",
			recipe: ["crafter:" + name + "block"],
		});
	}
}
