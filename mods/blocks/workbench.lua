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
                        position = create(4, 1.125),
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
    local function allowPut(position, listName, index, stack, player)
        repeat
            local ____switch4 = listName
            local ____cond4 = ____switch4 == "output"
            if ____cond4 then
                return 0
            end
            do
                return stack:get_count()
            end
        until true
    end
    local function workBenchLogic(position, listName)
        local meta = minetest.get_meta(position)
        local inventory = meta:get_inventory()
        local craftArea = inventory:get_list("craft")
        local result, leftOver = minetest.get_craft_result({method = CraftCheckType.normal, width = blocks.WORKBENCH_INVENTORY_SIZE.x, items = craftArea})
        inventory:set_list("output", {result.item})
        if listName == "output" then
            inventory:set_list("craft", leftOver.items)
            workBenchLogic(position, "")
        end
    end
    local function workBenchPut(position, listName, index, stack, player)
        workBenchLogic(position, listName)
    end
    local function workBenchMove(position, fromList, fromIndex, toList, toIndex, count, player)
        workBenchLogic(position, toList)
    end
    local function workBenchTake(position, listName, index, stack, player)
        workBenchLogic(position, listName)
    end
    minetest.register_node(
        ":workbench",
        {
            drawtype = Drawtype.normal,
            tiles = {"crafting_workbench_top.png", "default_wood.png", "crafting_workbench_side.png"},
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
            end,
            on_metadata_inventory_put = workBenchPut,
            on_metadata_inventory_move = workBenchMove,
            on_metadata_inventory_take = workBenchTake,
            allow_metadata_inventory_put = allowPut
        }
    )
end
