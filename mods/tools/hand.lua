Tools = Tools or ({})
do
    minetest.override_item(
        "",
        {
            wield_scale = vector.create(1, 1, 2.5),
            tool_capabilities = {full_punch_interval = 0.9, max_drop_level = 1, groupcaps = {
                break_instant = {times = {[1] = 0.1}, uses = 0},
                soil = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0},
                wooden = {times = {[1] = 1.5, [2] = 4, [3] = 8, [4] = 14}, uses = 0},
                leafy = {times = {[1] = 0.3, [2] = 0.6, [3] = 0.9, [4] = 1.2}, uses = 0},
                stone = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                metal = {times = {
                    [0] = 5,
                    [1] = 10,
                    [2] = 20,
                    [3] = 30,
                    [4] = 40
                }, maxlevel = 0, maxdrop = 0, uses = 0},
                glass = {times = {[1] = 1, [2] = 3, [3] = 6, [4] = 9}, maxlevel = 0, uses = 0},
                wool = {times = {[1] = 0.4, [2] = 0.7, [3] = 1.5, [4] = 4.5}, uses = 0}
            }, damage_groups = {fleshy = 1}}
        }
    )
end
