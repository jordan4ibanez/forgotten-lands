Tools = Tools or ({})
do
    Tools.Pickaxe = Pickaxe or ({})
    Tools.Pickaxe.A = "pickaxe_1"
    Tools.Pickaxe.B = "pickaxe_2"
    Tools.Pickaxe.C = "pickaxe_3"
    Tools.Pickaxe.D = "pickaxe_4"
    Tools.Pickaxe.E = "pickaxe_5"
    minetest.register_tool(":pickaxe", {inventory_image = "default_tool_stonepick.png", tool_capabilities = {full_punch_interval = 0.5, max_drop_level = 1, groupcaps = {stone = {times = {[1] = 1}, maxlevel = 1, maxdrop = 0}}}, groups = {[Tools.Pickaxe.A] = 1}})
end
