Tools = Tools or ({})
do
    local blockType = Types.BlockType
    minetest.override_item(
        "",
        {
            wield_scale = vector.create(1, 1, 2.5),
            tool_capabilities = {full_punch_interval = 0.9, max_drop_level = 1, groupcaps = {
                [blockType.break_instant] = {times = {[1] = 0.1}, uses = 0},
                [blockType.soil] = {times = {[1] = 2}, uses = 0},
                [blockType.wood] = {times = {
                    [0] = 2,
                    [1] = 4,
                    [2] = 6,
                    [3] = 8,
                    [4] = 10
                }, uses = 0},
                [blockType.leaf] = {times = {[1] = 1}, uses = 0},
                [blockType.stone] = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                [blockType.metal] = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                [blockType.glass] = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, uses = 0},
                [blockType.wool] = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0}
            }, damage_groups = {fleshy = 1}}
        }
    )
end
