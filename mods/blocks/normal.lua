Blocks = Blocks or ({})
do
    local sounds = Sounds
    local generateDropRequirements = Tools.generateDropRequirements
    local ToolType = Tools.ToolType
    minetest.register_node(
        ":stone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_stone.png"},
            sounds = sounds.stone(),
            groups = {stone = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 1}),
                items = {"stone"}
            }}}
        }
    )
    minetest.register_node(
        ":cobblestone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_cobble.png"},
            sounds = sounds.stone(),
            groups = {stone = 1}
        }
    )
    minetest.register_node(
        ":dirt",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_dirt.png"},
            sounds = sounds.dirt(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":grass",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
            sounds = sounds.grass(),
            groups = {soil = 1},
            drop = "dirt"
        }
    )
    minetest.register_node(
        ":sand",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_sand.png"},
            sounds = sounds.sand(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":gravel",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_gravel.png"},
            sounds = sounds.gravel(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":oak_tree",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
            sounds = sounds.wood(),
            groups = {wooden = 1}
        }
    )
    minetest.register_node(
        ":oak_leaves",
        {
            drawtype = Drawtype.allfaces_optional,
            paramtype = ParamType1.light,
            waving = 1,
            tiles = {"default_leaves.png"},
            sounds = sounds.plant(),
            groups = {leafy = 1},
            drop = ""
        }
    )
    local dyes = {
        "black",
        "blue",
        "brown",
        "cyan",
        "dark_green",
        "dark_grey",
        "green",
        "grey",
        "magenta",
        "orange",
        "pink",
        "purple",
        "red",
        "violet",
        "white",
        "yellow"
    }
    for ____, color in ipairs(dyes) do
        minetest.register_node(
            (":" .. color) .. "_wool",
            {
                tiles = {("wool_" .. color) .. ".png"},
                sounds = sounds.wool(),
                groups = {wool = 1}
            }
        )
    end
    minetest.register_node(
        ":glass",
        {
            drawtype = Drawtype.glasslike_framed_optional,
            tiles = {"default_glass.png", "default_glass_detail.png"},
            use_texture_alpha = TextureAlpha.clip,
            paramtype = ParamType1.light,
            sunlight_propagates = true,
            is_ground_content = false,
            sounds = sounds.glass(),
            groups = {glass = 1},
            drop = ""
        }
    )
end
