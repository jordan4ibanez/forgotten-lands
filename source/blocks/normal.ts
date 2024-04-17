
namespace blocks {
  const generateDropRequirements = tools.generateDropRequirements;
  const ToolType = types.ToolType;
  const blockType = types.BlockType;

  utility.registerNode(":stone", {
    drawtype: utility.Drawtype.normal,
    tiles: ["default_stone.png"],
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 1
    },

    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Pickaxe]: 1
          }),
          items: ["cobblestone"]
        }
      ]
    }
  })

  utility.registerNode(":cobblestone", {
    drawtype: utility.Drawtype.normal,
    tiles: ["default_cobble.png"],
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 1
    }
  })

  utility.registerNode(":dirt", {
    drawtype: utility.Drawtype.normal,
    tiles: ["default_dirt.png"],
    sounds: sounds.dirt(),
    groups: {
      [blockType.soil]: 1
    }
  })

  utility.registerNode(":grass", {
    drawtype: utility.Drawtype.normal,
    tiles: [
      "default_grass.png",
      "default_dirt.png",
      "default_dirt.png^default_grass_side.png"
    ],
    sounds: sounds.grass(),
    groups: {
      [blockType.soil]: 1
    },
    drop: "dirt"
  })

  utility.registerNode(":sand", {
    drawtype: utility.Drawtype.normal,
    tiles: ["default_sand.png"],
    sounds: sounds.sand(),
    groups: {
      [blockType.soil]: 1
    }
  })

  utility.registerNode(":gravel", {
    drawtype: utility.Drawtype.normal,
    tiles: ["default_gravel.png"],
    sounds: sounds.gravel(),
    groups: {
      [blockType.soil]: 1
    }
  })

  utility.registerNode(":oak_tree", {
    drawtype: utility.Drawtype.normal,
    tiles: [
      "default_tree_top.png",
      "default_tree_top.png",
      "default_tree.png"
    ],
    sounds: sounds.wood(),
    groups: {
      [blockType.wood]: 1,
      [blockType.tree]: 1
    }
  })

  utility.registerNode(":oak_leaves", {
    drawtype: utility.Drawtype.allfaces_optional,
    paramtype: utility.ParamType1.light,
    waving: 1,
    tiles: ["default_leaves.png"],
    sounds: sounds.plant(),
    groups: {
      [blockType.leaf]: 1
    },
    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Shears]: 1
          }),
          items: ["oak_leaves"]
        }
      ]
    }
  })

  utility.registerNode(":oak_wood", {
    drawtype: utility.Drawtype.normal,
    tiles: [
      "default_wood.png"
    ],
    sounds: sounds.wood(),
    groups: {
      [blockType.wood]: 1,
      [blockType.planks]: 1
    }
  })



  const dyes = [
    "black",
    "blue",
    "brown",
    "cyan",
    "dark_green",
    "dark_grey",
    "green",
    "grey",
    "magenta",
    "orange",
    "pink",
    // "purple",
    "red",
    "violet",
    "white",
    "yellow"
  ]
  for (const color of dyes) {
    utility.registerNode(":" + color + "_wool", {
      tiles: ["wool_" + color + ".png"],
      sounds: sounds.wool(),
      groups: {
        [blockType.wool]: 1
      }
    })
  }

  utility.registerNode(":glass", {
    drawtype: utility.Drawtype.glasslike_framed_optional,
    tiles: [
      "default_glass.png",
      "default_glass_detail.png"
    ],
    use_texture_alpha: utility.TextureAlpha.clip,
    paramtype: utility.ParamType1.light,
    sunlight_propagates: true,
    is_ground_content: false,
    sounds: sounds.glass(),
    groups: {
      [blockType.glass]: 1
    },
    drop: ""
  })

}