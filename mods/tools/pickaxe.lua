Tools = Tools or ({})
do
    local generateToolDropGroups = Tools.generateToolDropGroups
    local toolType = Tools.ToolType
    minetest.register_tool(
        ":wooden_pickaxe",
        {
            inventory_image = "default_tool_woodpick.png",
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 1, groupcaps = {stone = {times = {[1] = 1.25}, uses = 10, maxlevel = 1, maxdrop = 1}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 1})
        }
    )
    minetest.register_tool(
        ":stone_pickaxe",
        {
            inventory_image = "default_tool_stonepick.png",
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 2, groupcaps = {stone = {times = {[1] = 1.25, [2] = 2.5}, uses = 15, maxlevel = 2, maxdrop = 2}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 2})
        }
    )
    minetest.register_tool(
        ":iron_pickaxe",
        {
            inventory_image = "default_tool_steelpick.png",
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 3, groupcaps = {stone = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75}, uses = 20, maxlevel = 3, maxdrop = 3}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 3})
        }
    )
    minetest.register_tool(
        ":diamond_pickaxe",
        {
            inventory_image = "default_tool_diamondpick.png",
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 4, groupcaps = {stone = {times = {[1] = 1.25, [2] = 2.5, [3] = 3.75, [4] = 5}, uses = 25, maxlevel = 4, maxdrop = 4}}},
            groups = generateToolDropGroups({[toolType.Pickaxe] = 4})
        }
    )
    minetest.register_tool(
        ":mese_pickaxe",
        {
            inventory_image = "default_tool_mesepick.png",
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {stone = {times = {
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
