-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
narploop = narploop or ({})
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
    local playerInventorySize = player.CRAFT_INVENTORY_SIZE
    narploop.WORKBENCH_INVENTORY_SIZE = create(3, 3)
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
                        location = "current_player",
                        listName = "craft",
                        position = create(4, 1.125),
                        size = narploop.WORKBENCH_INVENTORY_SIZE,
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
                __TS__New(ListRing, {location = "current_player", listName = "craft"}),
                __TS__New(ListRing, {location = "current_player", listName = "main"}),
                __TS__New(ListRing, {location = "current_player", listName = "craftpreview"})
            }
        }
    ))
    local function allowPut(position, listName, index, stack, player)
        repeat
            local ____switch4 = listName
            local ____cond4 = ____switch4 == "craftpreview"
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
        local result, leftOver = minetest.get_craft_result({method = CraftCheckType.normal, width = narploop.WORKBENCH_INVENTORY_SIZE.x, items = craftArea})
        inventory:set_list("craftpreview", {result.item})
        if listName == "craftpreview" then
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
            on_rightclick = function(position, node, clicker, itemStack, pointedThing)
                local inventory = clicker:get_inventory()
                inventory:set_size("craft", narploop.WORKBENCH_INVENTORY_SIZE.x * narploop.WORKBENCH_INVENTORY_SIZE.y)
                inventory:set_width("craft", narploop.WORKBENCH_INVENTORY_SIZE.x)
            end,
            on_receive_fields = function(position, formName, fields, sender)
                local inventory = sender:get_inventory()
                local playerPos = sender:get_pos()
                playerPos.y = playerPos.y + 1.5
                local yaw = sender:get_look_horizontal()
                local items = inventory:get_list("craft")
                for ____, item in ipairs(items) do
                    do
                        if item:is_empty() then
                            goto __continue12
                        end
                        local stackSize = item:get_count()
                        local itemName = item:get_name()
                        do
                            local i = 0
                            while i < stackSize do
                                do
                                    local item = minetest.add_item(playerPos, itemName)
                                    if not item then
                                        goto __continue14
                                    end
                                    local dir = vector.multiply(
                                        minetest.yaw_to_dir(yaw + (math.random() - 0.5) * 1.25),
                                        2 + math.random()
                                    )
                                    dir.y = 1 + math.random() * 3
                                    item:add_velocity(dir)
                                end
                                ::__continue14::
                                i = i + 1
                            end
                        end
                    end
                    ::__continue12::
                end
                inventory:set_list("craft", {})
                inventory:set_size("craft", playerInventorySize.x * playerInventorySize.y)
                inventory:set_width("craft", playerInventorySize.x)
                print("set everything correctlyl: " .. tostring(playerInventorySize.x))
            end,
            on_construct = function(position)
                local meta = minetest.get_meta(position)
                meta:set_string("formspec", workBenchInventory)
            end
        }
    )
end
