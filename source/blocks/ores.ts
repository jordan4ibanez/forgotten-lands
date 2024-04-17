
namespace blocks {
  const generateDropRequirements = tools.generateDropRequirements;
  const ToolType = types.ToolType;
  const blockType = types.BlockType;

  function oreIt(oreTexture: string): string[] {
    return ["default_stone.png^" + oreTexture]
  }

  utility.registerNode(":coal_ore", {
    drawtype: utility.Drawtype.normal,
    tiles: oreIt("default_mineral_coal.png"),
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
          items: ["coal"]
        }
      ]
    }
  })

  utility.registerNode(":iron_ore", {
    drawtype: utility.Drawtype.normal,
    tiles: oreIt("default_mineral_iron.png"),
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 2
    },
    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Pickaxe]: 2
          }),
          items: ["iron_ore"]
        }
      ]
    }
  })

  utility.registerNode(":gold_ore", {
    drawtype: utility.Drawtype.normal,
    tiles: oreIt("default_mineral_gold.png"),
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 2
    },
    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Pickaxe]: 2
          }),
          items: ["gold_ore"]
        }
      ]
    }
  })

  utility.registerNode(":diamond_ore", {
    drawtype: utility.Drawtype.normal,
    tiles: oreIt("default_mineral_diamond.png"),
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 3
    },
    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Pickaxe]: 3
          }),
          items: ["diamond"]
        }
      ]
    }
  })

  utility.registerNode(":mese_ore", {
    drawtype: utility.Drawtype.normal,
    tiles: oreIt("default_mineral_mese.png"),
    sounds: sounds.stone(),
    groups: {
      [blockType.stone]: 4
    },
    drop: {
      items: [
        {
          tool_groups: generateDropRequirements({
            [ToolType.Pickaxe]: 4
          }),
          items: ["mese"]
        }
      ]
    }
  })

}