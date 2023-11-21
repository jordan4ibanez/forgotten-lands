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
    local function chopTexture(input, percent)
        return (("^[lowpart:" .. tostring(percent)) .. ":") .. input
    end
    local function generateFurnaceFormspec(fuelPercent, smeltPercent)
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
                    __TS__New(ListRing, {location = "context", listName = "input"})
                }
            }
        ))
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
    local function turnOn(position)
        minetest.swap_node(position, {name = "furnace_active"})
    end
    local function turnOff(position)
        minetest.swap_node(position, {name = "furnace"})
    end
    local function fuelCheck(fuelInventory)
        local result = minetest.get_craft_result({method = CraftCheckType.fuel, width = 1, items = fuelInventory})
        return result
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
        print(("thinking at " .. vec3ToString(position)) .. ".............")
        local currentlyActive = currentBlock.name == "furnace_active"
        do
            local i = 0
            while i <= elapsedTime do
                print("run " .. tostring(i))
                print("elapsed time: " .. tostring(elapsedTime))
                local inputInventory = inventory:get_list("input")
                local fuelInventory = inventory:get_list("fuel")
                local outputInventory = inventory:get_list("output")
                local fuelInFirefox = fuelCheck(fuelInventory)
                local hasFuel = fuelInFirefox.time > 0
                local fuelBuffer = bit.bor(
                    meta:get_int("fuelBuffer"),
                    0
                )
                print("Do I have fuel? " .. tostring(hasFuel))
                print("My fuel buffer: " .. tostring(fuelBuffer))
                local smeltPercent = 50
                local fuelPercent = 50
                meta:set_string(
                    "formspec",
                    generateFurnaceFormspec(fuelPercent, smeltPercent)
                )
                meta:set_int("fuelBuffer", fuelBuffer <= 0 and 0 or fuelBuffer - 1)
                i = i + 1
            end
        end
    end
    local function pixel(inputPixel)
        return inputPixel / textureSize - 0.5
    end
    local function startTimer(position)
        minetest.get_node_timer(position):start(1)
    end
    local function allowPut()
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
            on_timer = think,
            on_punch = function(pos)
                think(pos, 0, true)
            end,
            on_construct = function(position)
                think(position, 0, true)
            end,
            on_metadata_inventory_move = startTimer,
            on_metadata_inventory_put = startTimer,
            on_metadata_inventory_take = startTimer
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
            on_punch = function(pos)
                think(pos, 0, true)
            end,
            on_construct = function(position)
                think(position, 0, true)
            end,
            on_metadata_inventory_move = startTimer,
            on_metadata_inventory_put = startTimer,
            on_metadata_inventory_take = startTimer
        }
    )
end
