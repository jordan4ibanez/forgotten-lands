-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
player = player or ({})
do
    local create = vector.create2d
    local generate = formSpec.generate
    local FormSpec = formSpec.FormSpec
    local BackGround = formSpec.Background
    local BGColor = formSpec.BGColor
    local List = formSpec.List
    local color = utility.color
    print(color(1, 2, 3))
    local playerInventory = generate(__TS__New(
        FormSpec,
        {
            size = create(12, 12),
            elements = {
                __TS__New(
                    BGColor,
                    {
                        bgColor = color(100, 100, 100),
                        fullScreen = "both",
                        fullScreenbgColor = color(0, 0, 0, 20)
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "craft",
                        position = create(1.5, 1.5),
                        size = create(2, 2),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "craftpreview",
                        position = create(8, 2.25),
                        size = create(1, 1),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "main",
                        position = create(1, 6),
                        size = create(8, 4),
                        startingIndex = 0
                    }
                )
            }
        }
    ))
    minetest.register_on_joinplayer(function(player)
        player:set_inventory_formspec(playerInventory)
    end)
end
