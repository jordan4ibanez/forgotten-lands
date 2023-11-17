Blocks = Blocks or ({})
do
    local textureSize = 16
    local function pixel(inputPixel)
        return inputPixel / textureSize - 0.5
    end
    local furnaceNodeBox = {
        type = Nodeboxtype.fixed,
        fixed = {
            {
                pixel(0),
                pixel(0),
                pixel(0),
                pixel(2),
                pixel(16),
                pixel(16)
            },
            {
                pixel(14),
                pixel(0),
                pixel(0),
                pixel(16),
                pixel(16),
                pixel(16)
            },
            {
                pixel(0),
                pixel(13),
                pixel(0),
                pixel(16),
                pixel(16),
                pixel(16)
            },
            {
                pixel(0),
                pixel(6),
                pixel(0),
                pixel(16),
                pixel(9),
                pixel(16)
            },
            {
                pixel(0),
                pixel(0),
                pixel(0),
                pixel(16),
                pixel(1),
                pixel(16)
            },
            {
                pixel(0),
                pixel(0),
                pixel(2),
                pixel(16),
                pixel(16),
                pixel(16)
            }
        }
    }
    local furnaceSelectionBox = {
        type = Nodeboxtype.fixed,
        fixed = {{
            pixel(0),
            pixel(0),
            pixel(0),
            pixel(16),
            pixel(16),
            pixel(16)
        }}
    }
    minetest.register_node(":furnace", {
        drawtype = Drawtype.nodebox,
        paramtype2 = ParamType2.facedir,
        is_ground_content = false,
        node_box = furnaceNodeBox,
        selection_box = furnaceSelectionBox,
        tiles = {
            "default_furnace_top.png",
            "default_furnace_bottom.png",
            "default_furnace_side.png",
            "default_furnace_side.png",
            "default_furnace_side.png",
            "default_furnace_front.png"
        }
    })
    minetest.register_node(":furnace_active", {
        drawtype = Drawtype.nodebox,
        paramtype2 = ParamType2.facedir,
        is_ground_content = false,
        node_box = furnaceNodeBox,
        selection_box = furnaceSelectionBox,
        tiles = {
            "default_furnace_top.png",
            "default_furnace_bottom.png",
            "default_furnace_side.png",
            "default_furnace_side.png",
            "default_furnace_side.png",
            "default_furnace_front_active.png"
        }
    })
end
