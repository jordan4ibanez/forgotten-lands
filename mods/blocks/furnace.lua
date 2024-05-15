-- Lua Library inline imports
local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local __TS__Match = string.match

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end
-- End of Lua Library inline imports
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["78"] = 1,["80"] = 3,["81"] = 4,["82"] = 5,["83"] = 6,["84"] = 7,["85"] = 8,["86"] = 9,["87"] = 10,["88"] = 11,["89"] = 12,["90"] = 13,["91"] = 14,["92"] = 16,["93"] = 17,["94"] = 18,["95"] = 19,["96"] = 20,["97"] = 24,["98"] = 25,["99"] = 24,["100"] = 28,["101"] = 29,["102"] = 28,["103"] = 32,["104"] = 34,["105"] = 36,["106"] = 36,["107"] = 36,["108"] = 36,["109"] = 38,["110"] = 40,["111"] = 40,["112"] = 40,["113"] = 40,["114"] = 40,["115"] = 40,["116"] = 40,["117"] = 38,["118"] = 46,["119"] = 46,["120"] = 46,["121"] = 46,["122"] = 46,["123"] = 46,["124"] = 46,["125"] = 46,["126"] = 46,["127"] = 38,["128"] = 54,["129"] = 54,["130"] = 54,["131"] = 54,["132"] = 58,["133"] = 58,["134"] = 58,["135"] = 54,["136"] = 54,["137"] = 38,["138"] = 61,["139"] = 61,["140"] = 61,["141"] = 61,["142"] = 61,["143"] = 61,["144"] = 61,["145"] = 38,["146"] = 73,["147"] = 73,["148"] = 73,["149"] = 73,["150"] = 73,["151"] = 73,["152"] = 73,["153"] = 38,["154"] = 85,["155"] = 85,["156"] = 85,["157"] = 85,["158"] = 85,["159"] = 85,["160"] = 85,["161"] = 85,["162"] = 85,["163"] = 38,["164"] = 99,["165"] = 99,["166"] = 99,["167"] = 99,["168"] = 99,["169"] = 99,["170"] = 99,["171"] = 99,["172"] = 99,["173"] = 38,["174"] = 113,["175"] = 113,["176"] = 113,["177"] = 113,["178"] = 113,["179"] = 113,["180"] = 113,["181"] = 113,["182"] = 113,["183"] = 38,["184"] = 127,["185"] = 127,["186"] = 127,["187"] = 127,["188"] = 127,["189"] = 127,["190"] = 127,["191"] = 127,["192"] = 127,["193"] = 38,["194"] = 141,["195"] = 141,["196"] = 141,["197"] = 141,["198"] = 141,["199"] = 141,["200"] = 141,["201"] = 141,["202"] = 141,["203"] = 38,["204"] = 38,["205"] = 38,["206"] = 38,["207"] = 38,["208"] = 38,["209"] = 38,["210"] = 36,["211"] = 36,["212"] = 36,["213"] = 32,["214"] = 184,["215"] = 186,["216"] = 187,["219"] = 191,["220"] = 184,["221"] = 194,["222"] = 196,["223"] = 197,["226"] = 201,["227"] = 194,["228"] = 204,["229"] = 205,["232"] = 206,["233"] = 207,["234"] = 208,["235"] = 209,["236"] = 204,["237"] = 212,["238"] = 213,["239"] = 212,["240"] = 216,["241"] = 217,["242"] = 216,["243"] = 220,["244"] = 221,["245"] = 227,["246"] = 220,["247"] = 230,["248"] = 231,["249"] = 236,["250"] = 230,["251"] = 239,["252"] = 240,["253"] = 239,["254"] = 243,["255"] = 244,["256"] = 245,["257"] = 243,["258"] = 248,["259"] = 257,["260"] = 258,["261"] = 259,["262"] = 260,["263"] = 261,["265"] = 263,["266"] = 264,["268"] = 248,["269"] = 268,["270"] = 280,["271"] = 281,["272"] = 282,["273"] = 283,["274"] = 284,["276"] = 286,["277"] = 287,["278"] = 288,["279"] = 289,["280"] = 290,["282"] = 292,["283"] = 293,["286"] = 297,["287"] = 298,["289"] = 300,["290"] = 301,["292"] = 268,["293"] = 305,["294"] = 307,["295"] = 308,["296"] = 309,["297"] = 310,["299"] = 313,["300"] = 314,["301"] = 316,["302"] = 321,["303"] = 322,["305"] = 326,["306"] = 326,["307"] = 331,["308"] = 332,["309"] = 333,["310"] = 335,["311"] = 336,["312"] = 337,["313"] = 340,["314"] = 341,["315"] = 342,["316"] = 344,["317"] = 346,["318"] = 346,["319"] = 346,["320"] = 346,["321"] = 346,["322"] = 347,["323"] = 347,["324"] = 347,["325"] = 347,["326"] = 347,["327"] = 355,["328"] = 355,["329"] = 355,["330"] = 355,["331"] = 355,["332"] = 355,["333"] = 355,["334"] = 355,["335"] = 355,["336"] = 359,["337"] = 361,["338"] = 362,["339"] = 363,["342"] = 366,["343"] = 367,["344"] = 368,["347"] = 372,["348"] = 374,["349"] = 374,["350"] = 374,["351"] = 374,["352"] = 374,["353"] = 374,["354"] = 374,["355"] = 374,["356"] = 374,["357"] = 374,["358"] = 374,["359"] = 374,["360"] = 376,["361"] = 378,["362"] = 379,["363"] = 383,["364"] = 383,["365"] = 383,["366"] = 383,["367"] = 387,["370"] = 326,["373"] = 305,["374"] = 393,["376"] = 403,["377"] = 404,["379"] = 405,["381"] = 406,["383"] = 407,["385"] = 408,["387"] = 409,["390"] = 411,["393"] = 393,["394"] = 415,["395"] = 424,["396"] = 425,["397"] = 426,["398"] = 427,["399"] = 427,["400"] = 427,["401"] = 427,["402"] = 427,["403"] = 427,["404"] = 427,["405"] = 415,["406"] = 433,["407"] = 433,["408"] = 435,["409"] = 436,["410"] = 436,["411"] = 436,["412"] = 436,["413"] = 436,["414"] = 436,["415"] = 436,["416"] = 435,["417"] = 440,["418"] = 440,["419"] = 440,["420"] = 440,["421"] = 440,["422"] = 440,["423"] = 440,["424"] = 435,["425"] = 444,["426"] = 444,["427"] = 444,["428"] = 444,["429"] = 444,["430"] = 444,["431"] = 444,["432"] = 435,["433"] = 448,["434"] = 448,["435"] = 448,["436"] = 448,["437"] = 448,["438"] = 448,["439"] = 448,["440"] = 435,["441"] = 452,["442"] = 452,["443"] = 452,["444"] = 452,["445"] = 452,["446"] = 452,["447"] = 452,["448"] = 435,["449"] = 456,["450"] = 456,["451"] = 456,["452"] = 456,["453"] = 456,["454"] = 456,["455"] = 456,["456"] = 435,["457"] = 433,["458"] = 433,["459"] = 463,["460"] = 463,["461"] = 465,["462"] = 466,["463"] = 466,["464"] = 466,["465"] = 466,["466"] = 466,["467"] = 466,["468"] = 463,["469"] = 463,["470"] = 472,["471"] = 472,["472"] = 472,["473"] = 472,["474"] = 472,["475"] = 472,["476"] = 472,["477"] = 472,["478"] = 472,["479"] = 472,["480"] = 482,["481"] = 482,["482"] = 482,["483"] = 482,["484"] = 482,["485"] = 482,["486"] = 482,["487"] = 472,["488"] = 490,["489"] = 491,["490"] = 472,["491"] = 472,["492"] = 472,["493"] = 472,["494"] = 472,["495"] = 472,["496"] = 472,["497"] = 472,["498"] = 472,["499"] = 472,["500"] = 502,["501"] = 502,["502"] = 502,["503"] = 502,["504"] = 502,["505"] = 502,["506"] = 502,["507"] = 502,["508"] = 502,["509"] = 502,["510"] = 502,["511"] = 513,["512"] = 513,["513"] = 513,["514"] = 513,["515"] = 513,["516"] = 513,["517"] = 513,["518"] = 502,["519"] = 521,["520"] = 522,["521"] = 502,["522"] = 502,["523"] = 502,["524"] = 502,["525"] = 502,["526"] = 502,["527"] = 502,["528"] = 502,["529"] = 502,["530"] = 502});
blocks = blocks or ({})
do
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
    local pixel = utility.pixel
    local function turnTexture(input)
        return input .. "^[transformR270"
    end
    local function chopTexture(input, percent)
        return (("^[lowpart:" .. tostring(percent)) .. ":") .. input
    end
    local function generateFurnaceFormspec(fuelPercent, smeltPercent)
        local fuelForegroundMultiplier = minetest.is_nan(fuelPercent / 100) and 0 or fuelPercent / 100
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
            return
        end
        minetest.get_node_timer(position):start(0)
    end
    local function continueCookTimer(position)
        local timer = minetest.get_node_timer(position)
        if timer:is_started() then
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
    local function allowPut(position, listName, index, stack, player)
        repeat
            local ____switch37 = listName
            local ____cond37 = ____switch37 == "output"
            if ____cond37 then
                return 0
            end
            ____cond37 = ____cond37 or ____switch37 == "input"
            if ____cond37 then
                return itemCheck({stack}).item:get_name() ~= "" and stack:get_count() or 0
            end
            ____cond37 = ____cond37 or ____switch37 == "fuel"
            if ____cond37 then
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
    utility.registerNode(
        "furnace",
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
    utility.registerNode(
        "furnace_active",
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
