// local minetest,pairs = minetest,pairs
// Crafting recipes.

namespace main {
	const CraftRecipeType = types.CraftRecipeType;

	//? Cooking.

	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:diamond",
		recipe: "main:diamondore",
		cooktime: 12,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:coal 4",
		recipe: "main:coalore",
		cooktime: 3,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:charcoal",
		recipe: "main:tree",
		cooktime: 2,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:gold",
		recipe: "main:goldore",
		cooktime: 9,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:iron",
		recipe: "main:ironore",
		cooktime: 6,
	});
	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:stone",
		recipe: "main:cobble",
		cooktime: 2,
	});

	core.register_craft({
		type: CraftRecipeType.cooking,
		output: "main:glass",
		recipe: "main:sand",
		cooktime: 1,
	});

	//? Fuel.

	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:stick",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:sapling",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:paper",
		burntime: 1,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:tree",
		burntime: 24,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:wood",
		burntime: 12,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:leaves",
		burntime: 3,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:coal",
		burntime: 20,
	});
	core.register_craft({
		type: CraftRecipeType.fuel,
		recipe: "main:charcoal",
		burntime: 7,
	});

	//? Crafting.

	core.register_craft({
		type: "shapeless",
		output: "main:wood 4",
		recipe: ["main:tree"],
	});
	core.register_craft({
		type: "shapeless",
		output: "main:sugar 3",
		recipe: ["farming:sugarcane"],
	});
	core.register_craft({
		output: "main:stick 4",
		recipe: [["main:wood"], ["main:wood"]],
	});
	core.register_craft({
		output: "main:paper",
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
			output: "main:" + tool + "pick",
			recipe: [
				[
					"main:" + material[id],
					"main:" + material[id],
					"main:" + material[id],
				],
				["", "main:stick", ""],
				["", "main:stick", ""],
			],
		});
		core.register_craft({
			output: "main:" + tool + "shovel",
			recipe: [
				["", "main:" + material[id], ""],
				["", "main:stick", ""],
				["", "main:stick", ""],
			],
		});
		core.register_craft({
			output: "main:" + tool + "axe",
			recipe: [
				["main:" + material[id], "main:" + material[id], ""],
				["main:" + material[id], "main:stick", ""],
				["", "main:stick", ""],
			],
		});
		core.register_craft({
			output: "main:" + tool + "axe",
			recipe: [
				["", "main:" + material[id], "main:" + material[id]],
				["", "main:stick", "main:" + material[id]],
				["", "main:stick", ""],
			],
		});
		core.register_craft({
			output: "main:" + tool + "sword",
			recipe: [
				["", "main:" + material[id], ""],
				["", "main:" + material[id], ""],
				["", "main:stick", ""],
			],
		});
	}

	// core.register_craft({
	// 	output = "main:ladder 16",
	// 	recipe = {
	// 		{"main:stick","", "main:stick"},
	// 		{"main:stick","main:stick", "main:stick"},
	// 		{"main:stick", "", "main:stick"}
	// 	}
	// })

	// core.register_craft({
	// 	output = "main:shears",
	// 	recipe = {
	// 		{"","main:iron"},
	// 		{"main:iron",""},
	// 	}
	// })

	// core.register_craft({
	// 	output = "main:bucket",
	// 	recipe = {
	// 		{"main:iron","","main:iron"},
	// 		{"","main:iron",""},
	// 	}
	// })

	// --tool repair
	// core.register_craft({
	// 	type = "toolrepair",
	// 	additional_wear = -0.02,
	// })

	// local raw_material = {"coal","lapis","iron","gold","diamond","emerald","sapphire","ruby"}
	// for _,name in pairs(raw_material) do
	// 	core.register_craft({
	// 		output = "main:"..name.."block",
	// 		recipe = {
	// 			{"main:"..name, "main:"..name, "main:"..name},
	// 			{"main:"..name, "main:"..name, "main:"..name},
	// 			{"main:"..name, "main:"..name, "main:"..name},
	// 		}
	// 	})
	// 	core.register_craft({
	// 		type = "shapeless",
	// 		output = "main:"..name.." 9",
	// 		recipe = {"main:"..name.."block"},
	// 	})
	// end
}
