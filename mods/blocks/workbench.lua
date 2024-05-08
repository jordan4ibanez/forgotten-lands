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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["78"] = 2,["80"] = 4,["81"] = 6,["82"] = 7,["83"] = 8,["84"] = 9,["85"] = 10,["86"] = 11,["87"] = 12,["88"] = 13,["89"] = 15,["90"] = 16,["91"] = 17,["92"] = 19,["93"] = 20,["94"] = 22,["95"] = 25,["96"] = 25,["97"] = 25,["98"] = 25,["99"] = 27,["100"] = 29,["101"] = 29,["102"] = 29,["103"] = 29,["104"] = 29,["105"] = 29,["106"] = 29,["107"] = 27,["108"] = 35,["109"] = 35,["110"] = 35,["111"] = 35,["112"] = 35,["113"] = 35,["114"] = 35,["115"] = 35,["116"] = 35,["117"] = 27,["118"] = 43,["119"] = 43,["120"] = 43,["121"] = 43,["122"] = 43,["123"] = 43,["124"] = 43,["125"] = 43,["126"] = 43,["127"] = 27,["128"] = 54,["129"] = 54,["130"] = 54,["131"] = 54,["132"] = 54,["133"] = 54,["134"] = 54,["135"] = 54,["136"] = 54,["137"] = 27,["138"] = 68,["139"] = 68,["140"] = 68,["141"] = 68,["142"] = 68,["143"] = 68,["144"] = 68,["145"] = 68,["146"] = 68,["147"] = 27,["148"] = 82,["149"] = 82,["150"] = 82,["151"] = 82,["152"] = 82,["153"] = 82,["154"] = 82,["155"] = 82,["156"] = 82,["157"] = 27,["158"] = 27,["159"] = 27,["160"] = 27,["161"] = 27,["162"] = 25,["163"] = 25,["164"] = 25,["165"] = 185,["166"] = 185,["167"] = 185,["168"] = 185,["169"] = 185,["170"] = 185,["171"] = 185,["172"] = 198,["173"] = 199,["174"] = 200,["175"] = 201,["176"] = 185,["177"] = 204,["178"] = 206,["179"] = 207,["180"] = 208,["181"] = 209,["182"] = 211,["183"] = 212,["185"] = 213,["186"] = 213,["188"] = 214,["189"] = 215,["191"] = 216,["192"] = 216,["194"] = 217,["195"] = 218,["196"] = 219,["198"] = 221,["199"] = 221,["200"] = 221,["201"] = 221,["202"] = 222,["203"] = 223,["206"] = 216,["212"] = 226,["213"] = 227,["214"] = 228,["215"] = 185,["216"] = 231,["217"] = 232,["218"] = 234,["219"] = 185,["220"] = 185,["221"] = 185});
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
    local playerRegularCraftSize = player.CRAFT_INVENTORY_SIZE
    local WORKBENCH_INVENTORY_SIZE = create(3, 3)
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
                        size = WORKBENCH_INVENTORY_SIZE,
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
    utility.registerNode(
        "workbench",
        {
            drawtype = Drawtype.normal,
            tiles = {"crafting_workbench_top.png", "default_wood.png", "crafting_workbench_side.png"},
            sounds = sounds.wood(),
            groups = {[blockType.wood] = 1},
            on_rightclick = function(position, node, clicker, itemStack, pointedThing)
                local inventory = clicker:get_inventory()
                inventory:set_size("craft", WORKBENCH_INVENTORY_SIZE.x * WORKBENCH_INVENTORY_SIZE.y)
                inventory:set_width("craft", WORKBENCH_INVENTORY_SIZE.x)
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
                            goto __continue5
                        end
                        local stackSize = item:get_count()
                        local itemName = item:get_name()
                        do
                            local i = 0
                            while i < stackSize do
                                do
                                    local item = minetest.add_item(playerPos, itemName)
                                    if not item then
                                        goto __continue7
                                    end
                                    local dir = vector.multiply(
                                        minetest.yaw_to_dir(yaw + (math.random() - 0.5) * 1.25),
                                        2 + math.random()
                                    )
                                    dir.y = 1 + math.random() * 3
                                    item:add_velocity(dir)
                                end
                                ::__continue7::
                                i = i + 1
                            end
                        end
                    end
                    ::__continue5::
                end
                inventory:set_list("craft", {})
                inventory:set_size("craft", playerRegularCraftSize.x * playerRegularCraftSize.y)
                inventory:set_width("craft", playerRegularCraftSize.x)
            end,
            on_construct = function(position)
                local meta = minetest.get_meta(position)
                meta:set_string("formspec", workBenchInventory)
            end
        }
    )
end
