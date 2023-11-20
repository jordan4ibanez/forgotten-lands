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
    local color = utility.color
    local colorScalar = utility.colorScalar
    local colorRGB = utility.colorRGB
    local vec3ToString = utility.vec3ToString
    local function turnTexture(input)
        return input .. "^[transformR270"
    end
    local function turnOn(position)
        minetest.swap_node(position, {name = "furnace_active"})
    end
    local function turnOff(position)
        minetest.swap_node(position, {name = "furnace"})
    end
    local function think(position, elapsed, justConstructed)
        local currentBlock = minetest.get_node_or_nil(position)
        if not currentBlock or currentBlock.name == "ignore" then
            print("Furnace: Error, tried to do work on null object.")
            return
        end
        local meta = minetest.get_meta(position)
        local inventory = meta:get_inventory()
        if justConstructed then
            print("Hey I'm new at " .. vec3ToString(position))
            inventory:set_size("input", 1)
            inventory:set_size("fuel", 1)
            inventory:set_size("output", 1)
        end
        local isActive = currentBlock.name == "furnace_active"
        local fuelTime = meta:get_float("fuelTime") or 0
        local sourceTime = meta:get_float("sourceTime") or 0
        local fuelTotalTime = meta:get_float("fuelTotalTime") or 0
        local timerElapsed = meta:get_int("timerElapsed") or 0
        meta:set_int("timerElapsed", timerElapsed + 1)
        print(("thinking at " .. vec3ToString(position)) .. "...")
        local sourceList
        local fuelList
        local outputFull = false
        local cookable = false
        local cooked
        local fuel
        local update = true
        while timerElapsed > 0 and update do
            update = false
            sourceList = inventory:get_list("input")
            fuelList = inventory:get_list("fuel")
            local afterCooked
            cooked, afterCooked = unpack(minetest.get_craft_result({method = CraftCheckType.cooking, width = 1, items = sourceList}))
            cookable = cooked.time ~= 0
            local el = math.min(elapsed, fuelTotalTime - fuelTime)
            if cookable then
                el = math.min(el, cooked.time - sourceTime)
            end
            if fuelTime < fuelTotalTime then
                fuelTime = fuelTime + el
                if cookable then
                    sourceTime = sourceTime + el
                    if sourceTime >= cooked.time then
                        if inventory:room_for_item("output", cooked.item) then
                            inventory:add_item("output", cooked.item)
                            inventory:set_stack("input", 1, afterCooked.items[2])
                            sourceTime = sourceTime - cooked.time
                            update = true
                            print("Play cooked sound here...")
                        else
                            outputFull = false
                        end
                    else
                        update = true
                    end
                end
            else
                if cookable then
                    local afterFuel
                    fuel, afterFuel = unpack(minetest.get_craft_result({method = CraftCheckType.fuel, width = 1, items = fuelList}))
                    if fuel.time == 0 then
                        fuelTotalTime = 0
                    else
                        local isFuel, _ = unpack(minetest.get_craft_result({method = CraftCheckType.fuel, width = 1, items = {afterFuel.items[2]}}))
                        if isFuel.time == 0 then
                            table.insert(fuel.replacements, afterFuel.items[2])
                            inventory:set_stack("fuel", 1, "")
                        else
                            inventory:set_stack("fuel", 1, afterFuel.items[2])
                        end
                        local replacements = fuel.replacements
                        if replacements[2] then
                            local leftOver = inventory:add_item("output", replacements[2])
                            if not leftOver:is_empty() then
                                local above = vector.create(position.x, position.y + 1, position.z)
                                local dropPosition = minetest.find_node_near(above, 1, {"air"}) or above
                                minetest.item_drop(replacements[2], nil, dropPosition)
                            end
                        end
                        update = true
                        fuelTotalTime = fuel.time + (fuelTotalTime - fuelTime)
                    end
                else
                    fuelTotalTime = 0
                    sourceTime = 0
                end
                fuelTime = 0
            end
            elapsed = elapsed - el
        end
        local furnaceInventory = generate(__TS__New(
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
                        Image,
                        {
                            position = create(3, 2.5),
                            size = create(1, 1),
                            texture = "default_furnace_fire_bg.png"
                        }
                    ),
                    __TS__New(
                        Image,
                        {
                            position = create(3, 2.5),
                            size = create(1, 1),
                            texture = "default_furnace_fire_fg.png"
                        }
                    ),
                    __TS__New(
                        Image,
                        {
                            position = create(5.5, 2.5),
                            size = create(1, 1),
                            texture = turnTexture("gui_furnace_arrow_bg.png")
                        }
                    ),
                    __TS__New(
                        Image,
                        {
                            position = create(5.5, 2.5),
                            size = create(1, 1),
                            texture = turnTexture("gui_furnace_arrow_fg.png")
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
                    __TS__New(ListRing, {location = "context", listName = "input"})
                }
            }
        ))
        meta:set_string("formspec", furnaceInventory)
    end
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
            on_punch = function(position)
                think(position, 0)
            end,
            on_timer = think,
            on_construct = function(position)
                think(position, 0, true)
            end
        }
    )
    minetest.register_node(
        ":furnace_active",
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
                "default_furnace_front_active.png"
            },
            on_timer = think,
            on_construct = function(position)
                think(position, 0, true)
            end
        }
    )
end
