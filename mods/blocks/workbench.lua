blocks = blocks or ({})
do
    local blockType = types.BlockType
    minetest.register_node(
        ":workbench",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_wood.png"},
            sounds = sounds.wood(),
            groups = {[blockType.wood] = 1}
        }
    )
end
