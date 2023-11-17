namespace Blocks {
  const sounds = Sounds;
  const generateDropRequirements = Tools.generateDropRequirements;
  const ToolType = Types.ToolType;
  const blockType = Types.BlockType;
  
  function oreIt(oreTexture: string): string[] {
    return ["default_stone.png^" + oreTexture]
  }

  minetest.register_node(":coal_ore", {
    drawtype: Drawtype.normal,
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

}