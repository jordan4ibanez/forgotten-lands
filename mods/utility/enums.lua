-- Lua Library inline imports
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["73"] = 9,["74"] = 11,["75"] = 11,["76"] = 11,["77"] = 11,["78"] = 11,["79"] = 11,["80"] = 11,["81"] = 11,["82"] = 20,["83"] = 20,["84"] = 20,["85"] = 20,["86"] = 20,["87"] = 20,["88"] = 20,["89"] = 28,["90"] = 34,["91"] = 39,["92"] = 44,["93"] = 50,["94"] = 58,["95"] = 58,["96"] = 58,["97"] = 58,["98"] = 58,["99"] = 58,["100"] = 58,["101"] = 58,["102"] = 67,["103"] = 72,["104"] = 78,["105"] = 83,["106"] = 83,["107"] = 83,["108"] = 83,["109"] = 83,["110"] = 83,["111"] = 83,["112"] = 83,["113"] = 83,["114"] = 94,["115"] = 99,["116"] = 99,["117"] = 99,["118"] = 99,["119"] = 99,["120"] = 99,["121"] = 99,["122"] = 99,["123"] = 99,["124"] = 99,["125"] = 99,["126"] = 99,["127"] = 99,["128"] = 99,["129"] = 99,["130"] = 115,["131"] = 115,["132"] = 115,["133"] = 115,["134"] = 115,["135"] = 115,["136"] = 115,["137"] = 115,["138"] = 115,["139"] = 115,["140"] = 115,["141"] = 115,["142"] = 115,["143"] = 115,["144"] = 115,["145"] = 115,["146"] = 115,["147"] = 115,["148"] = 115,["149"] = 115,["150"] = 137,["151"] = 145,["152"] = 145,["153"] = 145,["154"] = 145,["155"] = 145,["156"] = 145,["157"] = 145,["158"] = 145,["159"] = 154,["160"] = 160,["161"] = 166,["162"] = 166,["163"] = 166,["164"] = 166,["165"] = 166,["166"] = 166,["167"] = 166,["168"] = 166,["169"] = 175,["170"] = 182,["171"] = 188,["172"] = 188,["173"] = 188,["174"] = 188,["175"] = 188,["176"] = 188,["177"] = 188,["178"] = 188,["179"] = 197,["180"] = 197,["181"] = 197,["182"] = 197,["183"] = 197,["184"] = 197,["185"] = 197,["186"] = 197,["187"] = 197,["188"] = 207,["189"] = 212,["190"] = 212,["191"] = 212,["192"] = 212,["193"] = 212,["194"] = 212,["195"] = 212,["196"] = 212,["197"] = 212,["198"] = 222,["199"] = 229,["200"] = 235,["201"] = 240,["202"] = 247,["203"] = 247,["204"] = 247,["205"] = 247,["206"] = 247,["207"] = 247,["208"] = 247,["209"] = 247,["210"] = 247,["211"] = 247,["212"] = 258,["213"] = 264,["214"] = 270,["215"] = 275,["216"] = 275,["217"] = 275,["218"] = 275,["219"] = 275,["220"] = 275,["221"] = 275,["222"] = 283,["223"] = 290,["224"] = 295,["225"] = 302,["226"] = 309,["227"] = 316,["228"] = 320,["229"] = 328,["230"] = 328,["231"] = 328,["232"] = 328,["233"] = 328,["234"] = 328,["235"] = 328,["236"] = 328,["237"] = 328,["238"] = 328,["239"] = 328,["240"] = 328,["241"] = 328,["242"] = 328});
local ____exports = {}
local globalEnvironment = _G
globalEnvironment.EntityVisual = {
    cube = "cube",
    sprite = "sprite",
    upright_sprite = "upright_sprite",
    mesh = "mesh",
    wielditem = "wielditem",
    item = "item"
}
globalEnvironment.SchematicRotation = {
    zero = "0",
    ninety = "90",
    oneEighty = "180",
    twoSeventy = "270",
    random = "random"
}
globalEnvironment.SchematicPlacementFlag = {place_center_x = "place_center_x", place_center_y = "place_center_y", place_center_z = "place_center_z"}
globalEnvironment.SchematicFormat = {mts = "mts", lua = "lua"}
globalEnvironment.SchematicSerializationOption = {lua_use_comments = "lua_use_comments", lua_num_indent_spaces = "lua_num_indent_spaces"}
globalEnvironment.SchematicReadOptionYSliceOption = {none = "none", low = "low", all = "all"}
globalEnvironment.HTTPRequestMethod = {GET = "GET", POST = "POST", PUT = "PUT", DELETE = "DELETE"}
globalEnvironment.OreType = {
    scatter = "scatter",
    sheet = "sheet",
    puff = "puff",
    blob = "blob",
    vein = "vein",
    stratum = "stratum"
}
globalEnvironment.OreFlags = {puff_cliffs = "puff_cliffs", puff_additive_composition = "puff_additive_composition"}
globalEnvironment.NoiseFlags = {defaults = "defaults", eased = "eased", absvalue = "absvalue"}
globalEnvironment.DecorationType = {simple = "simple", schematic = "schematic"}
globalEnvironment.DecorationFlags = {
    liquid_surface = "liquid_surface",
    force_placement = "force_placement",
    all_floors = "all_floors",
    all_ceilings = "all_ceilings",
    place_center_x = "place_center_x",
    place_center_y = "place_center_y",
    place_center_z = "place_center_z"
}
globalEnvironment.ParamType1 = {light = "light", none = "none"}
globalEnvironment.ParamType2 = {
    flowingliquid = "flowingliquid",
    wallmounted = "wallmounted",
    facedir = "facedir",
    fourdir = "4dir",
    leveled = "leveled",
    degrotate = "degrotate",
    meshoptions = "meshoptions",
    color = "color",
    colorfacedir = "colorfacedir",
    color4dir = "color4dir",
    colorwallmounted = "colorwallmounted",
    glasslikeliquidlevel = "glasslikeliquidlevel",
    colordegrotate = "colordegrotate"
}
globalEnvironment.Drawtype = {
    normal = "normal",
    airlike = "airlike",
    liquid = "liquid",
    flowingliquid = "flowingliquid",
    glasslike = "glasslike",
    glasslike_framed = "glasslike_framed",
    glasslike_framed_optional = "glasslike_framed_optional",
    allfaces = "allfaces",
    allfaces_optional = "allfaces_optional",
    torchlike = "torchlike",
    signlike = "signlike",
    plantlike = "plantlike",
    firelike = "firelike",
    fencelike = "fencelike",
    raillike = "raillike",
    nodebox = "nodebox",
    mesh = "mesh",
    plantlike_rooted = "plantlike_rooted"
}
globalEnvironment.Nodeboxtype = {regular = "regular", fixed = "fixed", wallmounted = "wallmounted", connected = "connected"}
globalEnvironment.LogLevel = {
    none = "none",
    error = "error",
    warning = "warning",
    action = "action",
    info = "info",
    verbose = "verbose"
}
globalEnvironment.TextureAlpha = {opaque = "opaque", clip = "clip", blend = "blend"}
globalEnvironment.LiquidType = {none = "none", source = "source", flowing = "flowing"}
globalEnvironment.NodeBoxConnections = {
    top = "top",
    bottom = "bottom",
    front = "front",
    left = "left",
    back = "back",
    right = "right"
}
globalEnvironment.CraftRecipeType = {shapeless = "shapeless", toolrepair = "toolrepair", cooking = "cooking", fuel = "fuel"}
globalEnvironment.CraftCheckType = {normal = "normal", cooking = "cooking", fuel = "fuel"}
globalEnvironment.HPChangeReasonType = {
    set_hp = "set_hp",
    punch = "punch",
    fall = "fall",
    node_damage = "node_damage",
    drown = "drown",
    respawn = "respawn"
}
globalEnvironment.CheatType = {
    moved_too_fast = "moved_too_fast",
    interacted_too_far = "interacted_too_far",
    interacted_with_self = "interacted_with_self",
    interacted_while_dead = "interacted_while_dead",
    finished_unknown_dig = "finished_unknown_dig",
    dug_unbreakable = "dug_unbreakable",
    dug_too_fast = "dug_too_fast"
}
globalEnvironment.ClearObjectsOptions = {full = "full", quick = "quick"}
globalEnvironment.GenNotifyFlags = {
    dungeon = "dungeon",
    temple = "temple",
    cave_begin = "cave_begin",
    cave_end = "cave_end",
    large_cave_begin = "large_cave_begin",
    large_cave_end = "large_cave_end",
    decoration = "decoration"
}
globalEnvironment.SearchAlgorithm = {aStarNoprefetch = "A*_noprefetch", aStar = "A*", dijkstra = "Dijkstra"}
globalEnvironment.SkyParametersType = {regular = "regular", skybox = "skybox", plain = "plain"}
globalEnvironment.SkyParametersFogTintType = {custom = "custom", default = "default"}
globalEnvironment.MinimapType = {off = "off", surface = "surface", radar = "radar", texture = "texture"}
globalEnvironment.HudElementType = {
    image = "image",
    text = "text",
    statbar = "statbar",
    inventory = "inventory",
    waypoint = "waypoint",
    image_waypoint = "image_waypoint",
    compass = "compass",
    minimap = "minimap"
}
globalEnvironment.HudReplaceBuiltinOption = {breath = "breath", health = "health"}
globalEnvironment.ParseRelativeNumberArgument = {number = "<number>", relativeToPlus = "~<number>", relativeTo = "~"}
globalEnvironment.CompressionMethod = {deflate = "deflate", zstd = "zstd"}
globalEnvironment.RotateAndPlaceOrientationFlag = {
    invert_wall = "invert_wall",
    force_wall = "force_wall",
    force_ceiling = "force_ceiling",
    force_floor = "force_floor",
    force_facedir = "force_facedir"
}
globalEnvironment.BlockStatusCondition = {unknown = "unknown", emerging = "emerging", loaded = "loaded", active = "active"}
globalEnvironment.TileAnimationType = {vertical_frames = "vertical_frames", sheet_2d = "sheet_2d"}
globalEnvironment.ParticleSpawnerTweenStyle = {fwd = "fwd", rev = "rev", pulse = "pulse", flicker = "flicker"}
globalEnvironment.ParticleSpawnerTextureBlend = {alpha = "alpha", add = "add", screen = "screen", sub = "sub"}
globalEnvironment.ParticleSpawnerAttractionType = {none = "none", point = "point", line = "line", plane = "plane"}
globalEnvironment.AreaStoreType = {libSpatial = "LibSpatial"}
globalEnvironment.TexturePoolComponentFade = {["in"] = "in", out = "out"}
globalEnvironment._Keys = {
    up = "up",
    down = "down",
    left = "left",
    right = "right",
    jump = "jump",
    aux1 = "aux1",
    sneak = "sneak",
    dig = "dig",
    place = "place",
    LMB = "LMB",
    RMB = "RMB",
    zoom = "zoom"
}
return ____exports
