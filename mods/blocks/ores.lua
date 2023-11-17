blocks = blocks or ({})
do
    local sounds = Sounds
    local generateDropRequirements = Tools.generateDropRequirements
    local ToolType = Types.ToolType
    local blockType = Types.BlockType
    local function oreIt(oreTexture)
        return {"default_stone.png^" .. oreTexture}
    end
    minetest.register_node(
        ":coal_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_coal.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 1}),
                items = {"coal"}
            }}}
        }
    )
    minetest.register_node(
        ":iron_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_iron.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 2},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 2}),
                items = {"iron_ore"}
            }}}
        }
    )
    minetest.register_node(
        ":gold_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_gold.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 2},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 2}),
                items = {"gold_ore"}
            }}}
        }
    )
    minetest.register_node(
        ":diamond_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_diamond.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 3},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 3}),
                items = {"diamond"}
            }}}
        }
    )
    minetest.register_node(
        ":mese_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_mese.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 4},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 4}),
                items = {"mese"}
            }}}
        }
    )
end
