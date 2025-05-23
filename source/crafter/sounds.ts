namespace main {
	export function stoneSound(table?: NodeSoundSpec): NodeSoundSpec {
		table = table || {};
		table.dig = table.dig || { name: "stone", gain: 0.2 };
		table.footstep = table.footstep || { name: "stone", gain: 0.1 };
		table.dug = table.dug || { name: "stone", gain: 1.0 };
		table.placing = table.placing || { name: "stone", gain: 1.0 };
		// default.node_sound_defaults(table)
		return table;
	}

	export function woodSound(table?: NodeSoundSpec): NodeSoundSpec {
		table = table || {};
		table.dig = table.dig || { name: "wood", gain: 0.3 };
		table.footstep = table.footstep || { name: "wood", gain: 0.2 };
		table.dug = table.dug || { name: "wood", gain: 1.0 };
		table.placing = table.placing || { name: "wood", gain: 1.0 };
		// default.node_sound_defaults(table)
		return table;
	}

	export function sandSound(table?: NodeSoundSpec): NodeSoundSpec {
		table = table || {};
		table.dig = table.dig || { name: "sand", gain: 0.09 };
		table.footstep = table.footstep || { name: "sand", gain: 0.07 };
		table.dug = table.dug || { name: "sand", gain: 0.09 };
		table.placing = table.placing || { name: "sand", gain: 0.09 };
		table.fall = table.fall || { name: "sand", gain: 0.01 };
		// default.node_sound_defaults(table)
		return table;
	}

	export function grassSound(table?: NodeSoundSpec): NodeSoundSpec {
		table = table || {};
		table.dig = table.dig || { name: "leaves", gain: 0.2 };
		table.footstep = table.footstep || { name: "leaves", gain: 0.2 };
		table.dug = table.dug || { name: "leaves", gain: 0.5 };
		table.placing = table.placing || { name: "leaves", gain: 0.2 };
		// default.node_sound_defaults(table)
		return table;
	}

	// function main.dirtSound(table)
	// 	table = table or {}
	// 	table.dig = table.dig or
	// 			{name = "dirt",gain=0.5}
	// 	table.footstep = table.footstep or
	// 			{name = "dirt", gain = 0.3}
	// 	table.dug = table.dug or
	// 			{name = "dirt", gain = 1.0}
	// 	table.placing = table.placing or
	// 			{name = "dirt", gain = 0.5}
	// 	--default.node_sound_defaults(table)
	// 	return table
	// end
	// function main.woolSound(table)
	// 	table = table or {}
	// 	table.dig = table.dig or
	// 			{name = "wool",gain=0.5}
	// 	table.footstep = table.footstep or
	// 			{name = "wool", gain = 0.3}
	// 	table.dug = table.dug or
	// 			{name = "wool", gain = 1.0}
	// 	table.placing = table.placing or
	// 			{name = "wool", gain = 0.5}
	// 	--default.node_sound_defaults(table)
	// 	return table
	// end
}
