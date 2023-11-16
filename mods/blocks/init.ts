namespace Blocks {
  const sounds = Sounds;
  const blockType = Types.BlockType;

  for (let i = 1; i <= 5; i++) {
    minetest.register_node(":tall_grass_" + i, {
      drawtype: Drawtype.plantlike,
      walkable: false,
      waving: 1,
      paramtype: ParamType1.light,
      paramtype2: ParamType2.degrotate,
      tiles: ["default_grass_" + i + ".png"],
      buildable_to: true,
      sounds: sounds.plant(),
      groups: {
        [blockType.break_instant]: 1
      },
      drop: ""
    })
  }

  utility.loadFiles(["normal"])
}