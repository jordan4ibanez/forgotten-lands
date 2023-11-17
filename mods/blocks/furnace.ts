namespace Blocks {
  minetest.register_node(":furnace", {
    drawtype: Drawtype.normal,
    paramtype2: ParamType2.facedir,
    is_ground_content: false,
    tiles: [
      "default_furnace_top.png",
      "default_furnace_bottom.png",
		  "default_furnace_side.png",
      "default_furnace_side.png",
		  "default_furnace_side.png",
      "default_furnace_front.png"
    ]
  })
}