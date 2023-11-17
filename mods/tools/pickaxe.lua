tools = tools or ({})
do
    local generateToolDropGroups = tools.generateToolDropGroups
    local toolType = types.ToolType
    local blockType = types.BlockType
    local wieldScale = tools.wieldScale
    minetest.register_tool(
        ":wood_pickaxe",
        {
            inventory_image = "default_tool_woodpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {[blockType.stone] = {times = {[1] = 1.25}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 1})
        }
    )
    minetest.register_tool(
        ":stone_pickaxe",
        {
            inventory_image = "default_tool_stonepick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 2})
        }
    )
    minetest.register_tool(
        ":iron_pickaxe",
        {
            inventory_image = "default_tool_steelpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 3})
        }
    )
    minetest.register_tool(
        ":gold_pickaxe",
        {
            inventory_image = "default_tool_goldpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {[blockType.stone] = {times = {[1] = 0.5, [2] = 1, [3] = 1.5}, uses = 4, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_pickaxe",
        {
            inventory_image = "default_tool_diamondpick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {[blockType.stone] = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75, [4] = 5}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 4})
        }
    )
    minetest.register_tool(
        ":mese_pickaxe",
        {
            inventory_image = "default_tool_mesepick.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.stone] = {times = {
                [1] = 1.25,
                [2] = 2.5,
                [3] = 3.75,
                [4] = 5,
                [5] = 6.25
            }, uses = 30, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 5})
        }
    )
end
