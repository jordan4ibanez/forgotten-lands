namespace Tools {
  //! fixme: Please find a way to auto generate this.

  const generateToolDropGroups = Tools.generateToolDropGroups;
  const toolType = Types.ToolType;

  minetest.register_tool(":wooden_shovel", {
    inventory_image: "default_tool_woodshovel.png",
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 1,
      groupcaps: {
        stone: {
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
      [toolType.Shovel]: 1
    })
  })

  minetest.register_tool(":stone_shovel", {
    inventory_image: "default_tool_stoneshovel.png",
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 2,
      groupcaps: {
        stone: {
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
      [toolType.Shovel]: 2
    })
  })

  minetest.register_tool(":iron_shovel", {
    inventory_image: "default_tool_steelshovel.png",
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 3,
      groupcaps: {
        stone: {
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
      [toolType.Shovel]: 3
    })
  })

  minetest.register_tool(":diamond_shovel", {
    inventory_image: "default_tool_diamondshovel.png",
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 4,
      groupcaps: {
        stone: {
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
      [toolType.Shovel]: 4
    })
  })

  minetest.register_tool(":mese_shovel", {
    inventory_image: "default_tool_meseshovel.png",
    tool_capabilities: {
      full_punch_interval: 0.3,
      max_drop_level: 5,
      groupcaps: {
        stone: {
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
      [toolType.Shovel]: 5
    })
  })
}