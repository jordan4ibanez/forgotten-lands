Testing = Testing or ({})
do
    minetest.register_tool(":pickaxe", {inventory_image = "default_tool_stonepick.png", tool_capabilities = {full_punch_interval = 0.5, max_drop_level = 1, groupcaps = {stone = {times = {[1] = 1}, maxlevel = 1, maxdrop = 0}}}})
end
