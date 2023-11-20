-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
player = player or ({})
do
    player.INVENTORY_SIZE = vector.create2d(9, 4)
    local create = vector.create2d
    local generate = formSpec.generate
    local FormSpec = formSpec.FormSpec
    local BackGround = formSpec.Background
    local BGColor = formSpec.BGColor
    local List = formSpec.List
    local ListColors = formSpec.ListColors
    local color = utility.color
    local colorScalar = utility.colorScalar
    local colorRGB = utility.colorRGB
    local playerInventory = generate(__TS__New(
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
                        location = "current_player",
                        listName = "craft",
                        position = create(5.5, 1.75),
                        size = create(2, 2),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "craftpreview",
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
                        size = create(player.INVENTORY_SIZE.x, 1),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "main",
                        position = create(0.5, 8),
                        size = create(player.INVENTORY_SIZE.x, player.INVENTORY_SIZE.y - 1),
                        startingIndex = player.INVENTORY_SIZE.x
                    }
                )
            }
        }
    ))
    minetest.register_on_joinplayer(function(newPlayer)
        newPlayer:hud_set_hotbar_itemcount(player.INVENTORY_SIZE.x)
        newPlayer:get_inventory():set_size("main", player.INVENTORY_SIZE.x * player.INVENTORY_SIZE.y)
        newPlayer:set_inventory_formspec(playerInventory)
    end)
end
