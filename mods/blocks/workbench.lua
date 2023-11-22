-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
blocks = blocks or ({})
do
    local create = vector.create2d
    local blockType = types.BlockType
    local generate = formSpec.generate
    local FormSpec = formSpec.FormSpec
    local BackGround = formSpec.Background
    local BGColor = formSpec.BGColor
    local List = formSpec.List
    local ListColors = formSpec.ListColors
    local ListRing = formSpec.ListRing
    local color = utility.color
    local colorScalar = utility.colorScalar
    local colorRGB = utility.colorRGB
    local playerInventorySize = player.MAIN_INVENTORY_SIZE
    blocks.WORKBENCH_INVENTORY_SIZE = create(3, 3)
    local workBenchInventory = generate(__TS__New(
        FormSpec,
        {
            size = create(12, 12),
            elements = {
                __TS__New(
                    BGColor,
                    {
                        bgColor = colorScalar(85),
                        fullScreen = "both",
                        fullScreenbgColor = colorScalar(0, 40)
                    }
                ),
                __TS__New(
                    ListColors,
                    {
                        slotBGHover = colorScalar(70),
                        slotBGNormal = colorScalar(55),
                        slotBorder = colorScalar(0),
                        toolTipBGColor = colorRGB(123, 104, 238),
                        toolTipFontColor = colorScalar(100)
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "context",
                        listName = "craft",
                        position = create(5.5, 1.75),
                        size = blocks.WORKBENCH_INVENTORY_SIZE,
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "context",
                        listName = "output",
                        position = create(9, 2.375),
                        size = create(1, 1),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "main",
                        position = create(0.5, 6.5),
                        size = create(playerInventorySize.x, 1),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "main",
                        position = create(0.5, 8),
                        size = create(playerInventorySize.x, playerInventorySize.y - 1),
                        startingIndex = playerInventorySize.x
                    }
                ),
                __TS__New(ListRing, {location = "current_player", listName = "main"}),
                __TS__New(ListRing, {location = "current_player", listName = "craft"})
            }
        }
    ))
    minetest.register_node(
        ":workbench",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_wood.png"},
            sounds = sounds.wood(),
            groups = {[blockType.wood] = 1},
            on_construct = function(position)
                local meta = minetest.get_meta(position)
                local inventory = meta:get_inventory()
                meta:set_string("formspec", workBenchInventory)
                inventory:set_size("craft", blocks.WORKBENCH_INVENTORY_SIZE.x * blocks.WORKBENCH_INVENTORY_SIZE.y)
                inventory:set_width("craft", blocks.WORKBENCH_INVENTORY_SIZE.x)
                inventory:set_size("output", 1)
                inventory:set_width("output", 1)
            end
        }
    )
end
