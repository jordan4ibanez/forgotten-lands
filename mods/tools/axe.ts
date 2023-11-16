namespace Tools {
  const generateToolDropGroups = Tools.generateToolDropGroups;
  const toolType = Types.ToolType;
  const blockType = Types.BlockType;

  const wieldScale = Tools.wieldScale;

  minetest.register_tool(":wooden_axe", {
    inventory_image: "default_tool_woodaxe.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 1,
      groupcaps: {
        [blockType.wood]: {
          times: {
            1: 1.25
          },
          uses: 10,
          maxlevel: 1,
          maxdrop: 1
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Axe]: 1
    })
  })

  minetest.register_tool(":stone_axe", {
    inventory_image: "default_tool_stoneaxe.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 2,
      groupcaps: {
        [blockType.wood]: {
          times: {
            1: 1.25,
            2: 2.5,
          },
          uses: 15,
          maxlevel: 2,
          maxdrop: 2
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Axe]: 2
    })
  })

  minetest.register_tool(":iron_axe", {
    inventory_image: "default_tool_steelaxe.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 3,
      groupcaps: {
        [blockType.wood]: {
          times: {
            1: 1.25,
            2: 2.5,
            3: 3.75,
          },
          uses: 20,
          maxlevel: 3,
          maxdrop: 3
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Axe]: 3
    })
  })

  minetest.register_tool(":diamond_axe", {
    inventory_image: "default_tool_diamondaxe.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 4,
      groupcaps: {
        [blockType.wood]: {
          times: {
            1: 1.25,
            2: 2.5,
            3: 3.75,
            4: 5,
          },
          uses: 25,
          maxlevel: 4,
          maxdrop: 4
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Axe]: 4
    })
  })

  minetest.register_tool(":mese_axe", {
    inventory_image: "default_tool_meseaxe.png",
    wield_scale: wieldScale,
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 5,
      groupcaps: {
        [blockType.wood]: {
          times: {
            1: 1.25,
            2: 2.5,
            3: 3.75,
            4: 5,
            5: 6.25
          },
          uses: 30,
          maxlevel: 5,
          maxdrop: 5
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Axe]: 5
    })
  })
}