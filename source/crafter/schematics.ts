// left - > right
// bottom - > top
// front -> back

namespace crafter {
	export const tree_big: SchematicDefinition = {
		size: vector.create3d({ x: 5, y: 6, z: 5 }),
		data: [
			// The side of the bush, with the ignore on top
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // middle layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // top layer

			// The side of the bush, with the ignore on top
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "ignore" }, // middle layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // top layer

			// The side of the bush, with the ignore on top
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:tree" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:tree" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:tree" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:tree" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "ignore" }, // middle layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "ignore" },
			{ name: "ignore" }, // top layer

			// The other side of the bush, same as first side
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "ignore" }, // middle layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // top layer

			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // middle layer
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" },
			{ name: "ignore" }, // top layer
		],
	};

	export const tree_small: SchematicDefinition = {
		size: vector.create3d({ x: 3, y: 5, z: 3 }),
		data: [
			// The side of the bush, with the air on top
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // middle layer
			{ name: "air" },
			{ name: "air" },
			{ name: "air" }, // top layer
			// The center of the bush, with stem at the base and a pointy leave 2 nodes above
			{ name: "air" },
			{ name: "crafter:tree" },
			{ name: "air" },
			{ name: "air" },
			{ name: "crafter:tree" },
			{ name: "air" },
			{ name: "crafter:leaves" },
			{ name: "crafter:tree" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // middle layer
			{ name: "air" },
			{ name: "crafter:leaves" },
			{ name: "air" }, // top layer
			// The other side of the bush, same as first side
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "air" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // lower layer
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" },
			{ name: "crafter:leaves" }, // middle layer
			{ name: "air" },
			{ name: "air" },
			{ name: "air" }, // top layer
		],
	};
}
