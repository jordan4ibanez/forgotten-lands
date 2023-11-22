-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end
-- End of Lua Library inline imports
blocks = blocks or ({})
do
    local textureSize = 16
    local MAIN_INVENTORY_SIZE = player.MAIN_INVENTORY_SIZE
    local create = vector.create2d
    local generate = formSpec.generate
    local FormSpec = formSpec.FormSpec
    local BackGround = formSpec.Background
    local Image = formSpec.Image
    local BGColor = formSpec.BGColor
    local List = formSpec.List
    local ListColors = formSpec.ListColors
    local ListRing = formSpec.ListRing
    local Label = formSpec.Label
    local Style = formSpec.Style
    local color = utility.color
    local colorScalar = utility.colorScalar
    local colorRGB = utility.colorRGB
    local vec3ToString = utility.vec3ToString
    local function turnTexture(input)
        return input .. "^[transformR270"
    end
    local function chopTexture(input, percent)
        return (("^[lowpart:" .. tostring(percent)) .. ":") .. input
    end
    local function generateFurnaceFormspec(fuelPercent, smeltPercent)
        local fuelForegroundMultiplier = minetest.is_nan(fuelPercent / 100) and 0 or fuelPercent / 100
        print(fuelForegroundMultiplier)
        return generate(__TS__New(
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
                        Label,
                        {
                            position = create(5.5, 0.5),
                            label = minetest.colorize(
                                color(164 * fuelForegroundMultiplier, 0, 0),
                                "Furnace"
                            )
                        }
                    ),
                    __TS__New(
                        Image,
                        {
                            position = create(3, 2.5),
                            size = create(1, 1),
                            texture = ("default_furnace_fire_bg.png" .. chopTexture("default_furnace_fire_fg.png", fuelPercent)) .. "]"
                        }
                    ),
                    __TS__New(
                        Image,
                        {
                            position = create(5.5, 2.5),
                            size = create(1, 1),
                            texture = turnTexture("gui_furnace_arrow_bg.png" .. chopTexture("gui_furnace_arrow_fg.png", smeltPercent)) .. "]"
                        }
                    ),
                    __TS__New(
                        List,
                        {
                            location = "context",
                            listName = "fuel",
                            position = create(3, 4),
                            size = create(1, 1),
                            startingIndex = 0
                        }
                    ),
                    __TS__New(
                        List,
                        {
                            location = "context",
                            listName = "input",
                            position = create(3, 1),
                            size = create(1, 1),
                            startingIndex = 0
                        }
                    ),
                    __TS__New(
                        List,
                        {
                            location = "context",
                            listName = "output",
                            position = create(8, 2.5),
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
                            size = create(MAIN_INVENTORY_SIZE.x, 1),
                            startingIndex = 0
                        }
                    ),
                    __TS__New(
                        List,
                        {
                            location = "current_player",
                            listName = "main",
                            position = create(0.5, 8),
                            size = create(MAIN_INVENTORY_SIZE.x, MAIN_INVENTORY_SIZE.y - 1),
                            startingIndex = MAIN_INVENTORY_SIZE.x
                        }
                    ),
                    __TS__New(ListRing, {location = "current_player", listName = "main"}),
                    __TS__New(ListRing, {location = "context", listName = "fuel"}),
                    __TS__New(ListRing, {location = "current_player", listName = "main"}),
                    __TS__New(ListRing, {location = "context", listName = "input"}),
                    __TS__New(ListRing, {location = "current_player", listName = "main"}),
                    __TS__New(ListRing, {location = "context", listName = "output"})
                }
            }
        ))
    end
    local function startCookTimer(position)
        local timer = minetest.get_node_timer(position)
        if timer:is_started() then
            print("timer is already started")
            return
        end
        minetest.get_node_timer(position):start(0)
    end
    local function continueCookTimer(position)
        local timer = minetest.get_node_timer(position)
        if timer:is_started() then
            print("timer is already started")
            return
        end
        minetest.get_node_timer(position):start(1)
    end
    local function initialPayload(inventory, justConstructed)
        if not justConstructed then
            return
        end
        print("setting up new furnace")
        inventory:set_size("input", 1)
        inventory:set_size("fuel", 1)
        inventory:set_size("output", 1)
    end
    local function turnOn(position, rotation)
        minetest.swap_node(position, {name = "furnace_active", param2 = rotation})
    end
    local function turnOff(position, rotation)
        minetest.swap_node(position, {name = "furnace", param2 = rotation})
    end
    local function fuelCheck(fuelInventory)
        local result = minetest.get_craft_result({method = CraftCheckType.fuel, width = 1, items = fuelInventory})
        return result
    end
    local function itemCheck(inputInventory)
        local result = minetest.get_craft_result({method = CraftCheckType.cooking, width = 1, items = inputInventory})
        return result
    end
    local function outputCheck(inventory, itemInHearth)
        return inventory:room_for_item("output", itemInHearth)
    end
    local function takeFromFuel(inventory, fuelInventory)
        fuelInventory[1]:take_item(1)
        inventory:set_list("fuel", fuelInventory)
    end
    local function processFuelLogic(hasItem, hasFuel, fuelBuffer, fuelTime, meta, inventory, fuelInventory)
        if hasItem and hasFuel and fuelBuffer == -1 then
            takeFromFuel(inventory, fuelInventory)
            meta:set_int("fuelBuffer", fuelTime)
            meta:set_int("fuelMax", fuelTime)
            return fuelTime
        else
            meta:set_int("fuelBuffer", fuelBuffer)
            return math.clamp(0, 100000, fuelBuffer)
        end
    end
    local function smeltItemLogic(hasItem, hasRoom, fuelMax, itemBuffer, itemTime, meta, inputInventory, inventory, outputInventory, itemInHearth)
        if hasItem and fuelMax > 0 then
            if itemBuffer == -1 then
                meta:set_int("itemMax", itemTime)
                meta:set_int("itemBuffer", itemTime)
                return itemTime
            else
                if itemBuffer == 0 and hasRoom then
                    inputInventory[1]:take_item(1)
                    inventory:set_list("input", inputInventory)
                    outputInventory[1]:add_item(itemInHearth.item)
                    inventory:set_list("output", outputInventory)
                end
                meta:set_int("itemBuffer", itemBuffer)
                return itemBuffer
            end
        else
            print("ran out of fuel")
            if not hasItem then
                meta:set_int("itemMax", -1)
            end
            meta:set_int("itemBuffer", -1)
            return -1
        end
    end
    local function think(position, elapsedTime, justConstructed)
        local currentBlock = minetest.get_node_or_nil(position)
        if not currentBlock or currentBlock.name == "ignore" then
            print("Furnace: Error, tried to do work on null object.")
            return false
        end
        local meta = minetest.get_meta(position)
        local inventory = meta:get_inventory()
        initialPayload(inventory, justConstructed)
        local furnaceIsActive = currentBlock.name == "furnace_active"
        local rotation = currentBlock.param2 or 0
        do
            local i = 0
            while i < elapsedTime do
                local inputInventory = inventory:get_list("input")
                local fuelInventory = inventory:get_list("fuel")
                local outputInventory = inventory:get_list("output")
                local fuelInFirebox = fuelCheck(fuelInventory)
                local fuelTime = fuelInFirebox.time
                local hasFuel = fuelTime > 0
                local itemInHearth = itemCheck(inputInventory)
                local itemTime = itemInHearth.time
                local hasItem = itemInHearth.item:get_name() ~= ""
                local hasRoom = outputCheck(inventory, itemInHearth.item)
                local fuelBuffer = math.clamp(
                    -1,
                    10000,
                    (meta:get_int("fuelBuffer") or 0) - 1
                )
                local itemBuffer = math.clamp(
                    -1,
                    10000,
                    (meta:get_int("itemBuffer") or 0) - 1
                )
                local fuelProgress = processFuelLogic(
                    hasItem,
                    hasFuel,
                    fuelBuffer,
                    fuelTime,
                    meta,
                    inventory,
                    fuelInventory
                )
                if hasFuel and hasItem and hasRoom or fuelBuffer > 0 then
                    continueCookTimer(position)
                    if not furnaceIsActive then
                        turnOn(position, rotation)
                    end
                else
                    if furnaceIsActive then
                        turnOff(position, rotation)
                        meta:set_int("fuelMax", 0)
                    end
                end
                local fuelMax = meta:get_int("fuelMax") or 0
                local itemProgress = smeltItemLogic(
                    hasItem,
                    hasRoom,
                    fuelMax,
                    itemBuffer,
                    itemTime,
                    meta,
                    inputInventory,
                    inventory,
                    outputInventory,
                    itemInHearth
                )
                local itemMax = meta:get_int("itemMax") or 0
                local smeltPercent = itemMax == -1 and 0 or 100 - math.floor(itemProgress / itemMax * 100)
                local fuelPercent = math.floor(fuelProgress / fuelMax * 100)
                meta:set_string(
                    "formspec",
                    generateFurnaceFormspec(fuelPercent, smeltPercent)
                )
                if not hasFuel then
                    break
                end
                i = i + 1
            end
        end
    end
    local function pixel(inputPixel)
        return inputPixel / textureSize - 0.5
    end
    local function allowPut(position, listName, index, stack, player)
        repeat
            local ____switch38 = listName
            local ____cond38 = ____switch38 == "output"
            if ____cond38 then
                return 0
            end
            ____cond38 = ____cond38 or ____switch38 == "input"
            if ____cond38 then
                return itemCheck({stack}).item:get_name() ~= "" and stack:get_count() or 0
            end
            ____cond38 = ____cond38 or ____switch38 == "fuel"
            if ____cond38 then
                return fuelCheck({stack}).time > 0 and stack:get_count() or 0
            end
            do
                return 0
            end
        until true
    end
    local function allowMove(position, fromList, fromIndex, toList, toIndex, count, player)
        local meta = minetest.get_meta(position)
        local inventory = meta:get_inventory()
        local stack = inventory:get_stack(fromList, fromIndex)
        return allowPut(
            position,
            toList,
            toIndex,
            stack,
            player
        )
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
    minetest.register_node(
        ":furnace",
        {
            drawtype = Drawtype.nodebox,
            paramtype2 = ParamType2.facedir,
            is_ground_content = false,
            node_box = furnaceNodeBox,
            selection_box = furnaceSelectionBox,
            groups = {stone = 1},
            sounds = sounds.stone(),
            tiles = {
                "default_furnace_top.png",
                "default_furnace_bottom.png",
                "default_furnace_side.png",
                "default_furnace_side.png",
                "default_furnace_side.png",
                "default_furnace_front.png"
            },
            on_construct = function(pos)
                think(pos, 1, true)
            end,
            on_timer = think,
            on_punch = startCookTimer,
            on_metadata_inventory_move = startCookTimer,
            on_metadata_inventory_put = startCookTimer,
            on_metadata_inventory_take = startCookTimer,
            allow_metadata_inventory_put = allowPut,
            allow_metadata_inventory_move = allowMove
        }
    )
    minetest.register_node(
        ":furnace_active",
        {
            drawtype = Drawtype.nodebox,
            paramtype2 = ParamType2.facedir,
            is_ground_content = false,
            light_source = 8,
            node_box = furnaceNodeBox,
            selection_box = furnaceSelectionBox,
            groups = {stone = 1},
            sounds = sounds.stone(),
            tiles = {
                "default_furnace_top.png",
                "default_furnace_bottom.png",
                "default_furnace_side.png",
                "default_furnace_side.png",
                "default_furnace_side.png",
                "default_furnace_front_active.png"
            },
            on_construct = function(pos)
                think(pos, 1, true)
            end,
            on_timer = think,
            on_punch = startCookTimer,
            on_metadata_inventory_move = startCookTimer,
            on_metadata_inventory_put = startCookTimer,
            on_metadata_inventory_take = startCookTimer,
            allow_metadata_inventory_put = allowPut,
            allow_metadata_inventory_move = allowMove
        }
    )
end
