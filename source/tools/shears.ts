namespace tools {
    const generateToolDropGroups = tools.generateToolDropGroups;
    const toolType = types.ToolType;
    const blockType = types.BlockType;
    const wieldScale = tools.wieldScale;

    minetest.register_tool(":shears", {
        inventory_image: "default_tool_shears.png",
        wield_scale: wieldScale,
        tool_capabilities: {
            full_punch_interval: 0.3,
            max_drop_level: 5,
            groupcaps: {
                [blockType.leaf]: {
                    times: {
                        1: 0.25,
                        2: 0.5,
                        3: 0.75,
                        4: 1.0,
                        5: 1.25
                    },
                    uses: 20,
                    maxlevel: 5,
                    maxdrop: 5
                }
            }
        },
        groups: generateToolDropGroups({
            [toolType.Shears]: 5
        })
    });
}