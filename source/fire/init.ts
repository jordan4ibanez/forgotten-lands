namespace fire {
  const loadFiles = utility.loadFiles;
  const blockType = types.BlockType;

  utility.registerNode("fire", {
    drawtype: Drawtype.firelike,
    tiles: [{
      name: "fire_basic_flame_animated.png",
      animation: {
        aspect_h: 16,
        aspect_w: 16,
        type: TileAnimationType.vertical_frames,
        length: 1
      }
    }],
    selection_box: {
      type: Nodeboxtype.fixed,
      fixed: utility.nodeBoxGenPixel(14, 12, 14),
    },
    walkable: false,
    light_source: 14,
    paramtype: ParamType1.light,
    groups: {
      [blockType.break_instant]: 1
    }
  });

  loadFiles(["smoke"]);
}