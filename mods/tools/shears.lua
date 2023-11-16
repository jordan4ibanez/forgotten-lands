Tools = Tools or ({})
do
    local generateToolDropGroups = Tools.generateToolDropGroups
    local toolType = Types.ToolType
    local blockType = Types.BlockType
    local wieldScale = Tools.wieldScale
    minetest.register_tool(
        ":shears",
        {
            inventory_image = "default_tool_shears.png",
            wield_scale = wieldScale,
            tool_capabilities = {full_punch_interval = 0.3, max_drop_level = 5, groupcaps = {[blockType.leaf] = {times = {
                [1] = 0.25,
                [2] = 0.5,
                [3] = 0.75,
                [4] = 1,
                [5] = 1.25
            }, uses = 20, maxlevel = 5, maxdrop = 5}}},
            groups = generateToolDropGroups({[toolType.Shears] = 5})
        }
    )
end
