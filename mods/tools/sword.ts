namespace Tools {

  const generateToolDropGroups = Tools.generateToolDropGroups;
  const toolType = Types.ToolType;
  const blockType = Types.BlockType;
  const wieldScale = Tools.wieldScale;

  minetest.register_tool(":wood_sword", {
    inventory_image: "default_tool_woodsword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 1,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.75,
          },
          uses: 10,
          maxlevel: 1,
          maxdrop: 1
        },
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 1
    })
  })

  minetest.register_tool(":stone_sword", {
    inventory_image: "default_tool_stonesword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 2,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.75,
            2: 1.5
          },
          uses: 15,
          maxlevel: 2,
          maxdrop: 2
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 2
    })
  })

  minetest.register_tool(":iron_sword", {
    inventory_image: "default_tool_steelsword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 3,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.75,
            2: 1.5,
            3: 2.25
          },
          uses: 20,
          maxlevel: 3,
          maxdrop: 3
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 3
    })
  })

  minetest.register_tool(":gold_sword", {
    inventory_image: "default_tool_goldsword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 3,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.25,
            2: 0.5,
            3: 1.0
          },
          uses: 4,
          maxlevel: 3,
          maxdrop: 3
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 3
    })
  })

  minetest.register_tool(":diamond_sword", {
    inventory_image: "default_tool_diamondsword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 4,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.75,
            2: 1.5,
            3: 2.25,
            4: 3
          },
          uses: 25,
          maxlevel: 4,
          maxdrop: 4
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 4
    })
  })

  minetest.register_tool(":mese_sword", {
    inventory_image: "default_tool_mesesword.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 5,
      groupcaps: {
        [blockType.leaf]: {
          times: {
            1: 0.75,
            2: 1.5,
            3: 2.25,
            4: 3,
            5: 3.75
          },
          uses: 30,
          maxlevel: 5,
          maxdrop: 5
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Sword]: 5
    })
  })
}