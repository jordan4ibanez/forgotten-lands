Tools = Tools or ({})
do
    local generateToolDropGroups = Tools.generateToolDropGroups
    local toolType = Types.ToolType
    local blockType = Types.BlockType
    local wieldScale = Tools.wieldScale
    minetest.register_tool(
        ":wooden_shovel",
        {
            inventory_image = "default_tool_woodshovel.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {[blockType.soil] = {times = {[1] = 1}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Shovel] = 1})
        }
    )
    minetest.register_tool(
        ":stone_shovel",
        {
            inventory_image = "default_tool_stoneshovel.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {[blockType.soil] = {times = {[1] = 1, [2] = 2}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Shovel] = 2})
        }
    )
    minetest.register_tool(
        ":iron_shovel",
        {
            inventory_image = "default_tool_steelshovel.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.soil] = {times = {[1] = 1, [2] = 2, [3] = 3}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Shovel] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_shovel",
        {
            inventory_image = "default_tool_diamondshovel.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {[blockType.soil] = {times = {[1] = 1, [2] = 2, [3] = 3, [4] = 4}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Shovel] = 4})
        }
    )
    minetest.register_tool(
        ":mese_shovel",
        {
            inventory_image = "default_tool_meseshovel.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.soil] = {times = {
                [1] = 1,
                [2] = 2,
                [3] = 3,
                [4] = 4,
                [5] = 5
            }, uses = 30, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Shovel] = 5})
        }
    )
end
