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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["78"] = 1,["80"] = 1,["81"] = 1,["82"] = 6,["83"] = 8,["84"] = 9,["85"] = 10,["86"] = 11,["87"] = 12,["88"] = 13,["89"] = 14,["90"] = 16,["91"] = 17,["92"] = 18,["93"] = 1,["94"] = 20,["95"] = 20,["96"] = 20,["97"] = 22,["98"] = 24,["99"] = 24,["100"] = 24,["101"] = 24,["102"] = 24,["103"] = 24,["104"] = 24,["105"] = 22,["106"] = 30,["107"] = 30,["108"] = 30,["109"] = 30,["110"] = 30,["111"] = 30,["112"] = 30,["113"] = 30,["114"] = 30,["115"] = 22,["116"] = 38,["117"] = 38,["118"] = 38,["119"] = 38,["120"] = 38,["121"] = 38,["122"] = 1,["123"] = 38,["124"] = 38,["125"] = 22,["126"] = 49,["127"] = 49,["128"] = 49,["129"] = 49,["130"] = 49,["131"] = 49,["132"] = 49,["133"] = 49,["134"] = 49,["135"] = 22,["136"] = 63,["137"] = 63,["138"] = 63,["139"] = 63,["140"] = 63,["141"] = 63,["142"] = 1,["143"] = 63,["144"] = 63,["145"] = 22,["146"] = 77,["147"] = 77,["148"] = 77,["149"] = 77,["150"] = 77,["151"] = 77,["152"] = 1,["153"] = 1,["154"] = 77,["155"] = 22,["156"] = 22,["157"] = 22,["158"] = 20,["159"] = 20,["160"] = 20,["161"] = 102,["162"] = 1,["163"] = 104,["164"] = 1,["165"] = 1,["166"] = 1,["167"] = 1,["168"] = 1,["169"] = 102});
player = player or ({})
do
    player.CRAFT_INVENTORY_SIZE = vector.create2d(2, 2)
    player.MAIN_INVENTORY_SIZE = vector.create2d(9, 4)
    local create = vector.create2d
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
    player.playerInventory = generate(__TS__New(
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
                        size = player.CRAFT_INVENTORY_SIZE,
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
                        size = create(player.MAIN_INVENTORY_SIZE.x, 1),
                        startingIndex = 0
                    }
                ),
                __TS__New(
                    List,
                    {
                        location = "current_player",
                        listName = "main",
                        position = create(0.5, 8),
                        size = create(player.MAIN_INVENTORY_SIZE.x, player.MAIN_INVENTORY_SIZE.y - 1),
                        startingIndex = player.MAIN_INVENTORY_SIZE.x
                    }
                ),
                __TS__New(ListRing, {location = "current_player", listName = "main"}),
                __TS__New(ListRing, {location = "current_player", listName = "craft"})
            }
        }
    ))
    minetest.register_on_joinplayer(function(newPlayer)
        newPlayer:hud_set_hotbar_itemcount(player.MAIN_INVENTORY_SIZE.x)
        local inventory = newPlayer:get_inventory()
        inventory:set_size("main", player.MAIN_INVENTORY_SIZE.x * player.MAIN_INVENTORY_SIZE.y)
        inventory:set_width("main", player.MAIN_INVENTORY_SIZE.x)
        inventory:set_size("craft", player.CRAFT_INVENTORY_SIZE.x * player.CRAFT_INVENTORY_SIZE.y)
        inventory:set_width("craft", player.CRAFT_INVENTORY_SIZE.x)
        newPlayer:set_inventory_formspec(player.playerInventory)
    end)
end
