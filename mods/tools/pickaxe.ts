namespace Tools {
  //! fixme: Please find a way to auto generate this.

  const generateToolDropGroups = Tools.generateToolDropGroups;
  const toolType = Tools.ToolType;

  minetest.register_tool(":wooden_pickaxe", {
    inventory_image: "default_tool_woodpick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 1,
      groupcaps: {
        stone: {
          times: {
            1: 2
          },
          maxlevel: 1,
          maxdrop: 1
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Pickaxe]: 1
    })
  })

  minetest.register_tool(":stone_pickaxe", {
    inventory_image: "default_tool_stonepick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 2,
      groupcaps: {
        stone: {
          times: {
            1: 2,
            2: 4
          },
          maxlevel: 2,
          maxdrop: 2
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Pickaxe]: 2
    })
  })

  minetest.register_tool(":iron_pickaxe", {
    inventory_image: "default_tool_steelpick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 3,
      groupcaps: {
        stone: {
          times: {
            1: 2,
            2: 4,
            3: 6
          },
          maxlevel: 3,
          maxdrop: 3
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Pickaxe]: 3
    })
  })

  minetest.register_tool(":diamond_pickaxe", {
    inventory_image: "default_tool_diamondpick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 4,
      groupcaps: {
        stone: {
          times: {
            1: 2,
            2: 4,
            3: 6,
            4: 8
          },
          maxlevel: 4,
          maxdrop: 4
        }
      }
    },
    groups: generateToolDropGroups({
      [toolType.Pickaxe]: 4
    })
  })
}