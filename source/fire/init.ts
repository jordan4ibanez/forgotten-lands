namespace fire {
  const loadFiles = utility.loadFiles;

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
      fixed: [
        utility.nodeBoxGenPixel(8, 4, 1)
      ]
    }
  });

  loadFiles(["smoke"]);
}