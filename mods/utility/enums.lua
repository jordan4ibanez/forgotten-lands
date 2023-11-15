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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["73"] = 1,["74"] = 1,["75"] = 1,["76"] = 1,["77"] = 1,["78"] = 1,["79"] = 10,["80"] = 10,["81"] = 10,["82"] = 10,["83"] = 10,["84"] = 10,["85"] = 18,["86"] = 18,["87"] = 18,["88"] = 18,["89"] = 24,["90"] = 24,["91"] = 24,["92"] = 29,["93"] = 29,["94"] = 29,["95"] = 34,["96"] = 34,["97"] = 34,["98"] = 34,["99"] = 40,["100"] = 40,["101"] = 40,["102"] = 40,["103"] = 40,["104"] = 48,["105"] = 48,["106"] = 48,["107"] = 48,["108"] = 48,["109"] = 48,["110"] = 48,["111"] = 57,["112"] = 57,["113"] = 57,["114"] = 62,["115"] = 62,["116"] = 62,["117"] = 62,["118"] = 68,["119"] = 68,["120"] = 68,["121"] = 73,["122"] = 73,["123"] = 73,["124"] = 73,["125"] = 73,["126"] = 73,["127"] = 73,["128"] = 73,["129"] = 84,["130"] = 84,["131"] = 84,["132"] = 89,["133"] = 89,["134"] = 89,["135"] = 89,["136"] = 89,["137"] = 89,["138"] = 89,["139"] = 89,["140"] = 89,["141"] = 89,["142"] = 89,["143"] = 89,["144"] = 89,["145"] = 89,["146"] = 105,["147"] = 105,["148"] = 105,["149"] = 105,["150"] = 105,["151"] = 105,["152"] = 105,["153"] = 105,["154"] = 105,["155"] = 105,["156"] = 105,["157"] = 105,["158"] = 105,["159"] = 105,["160"] = 105,["161"] = 105,["162"] = 105,["163"] = 105,["164"] = 105,["165"] = 127,["166"] = 127,["167"] = 127,["168"] = 127,["169"] = 127,["170"] = 135,["171"] = 135,["172"] = 135,["173"] = 135,["174"] = 135,["175"] = 135,["176"] = 135,["177"] = 144,["178"] = 144,["179"] = 144,["180"] = 144,["181"] = 150,["182"] = 150,["183"] = 150,["184"] = 150,["185"] = 156,["186"] = 156,["187"] = 156,["188"] = 156,["189"] = 156,["190"] = 156,["191"] = 156,["192"] = 165,["193"] = 165,["194"] = 165,["195"] = 165,["196"] = 165,["197"] = 172,["198"] = 172,["199"] = 172,["200"] = 172,["201"] = 172,["202"] = 172,["203"] = 172,["204"] = 181,["205"] = 181,["206"] = 181,["207"] = 181,["208"] = 181,["209"] = 181,["210"] = 181,["211"] = 181,["212"] = 191,["213"] = 191,["214"] = 191,["215"] = 196,["216"] = 196,["217"] = 196,["218"] = 196,["219"] = 196,["220"] = 196,["221"] = 196,["222"] = 196,["223"] = 206,["224"] = 206,["225"] = 206,["226"] = 206,["227"] = 213,["228"] = 213,["229"] = 213,["230"] = 213,["231"] = 219,["232"] = 219,["233"] = 219,["234"] = 224,["235"] = 224,["236"] = 224,["237"] = 224,["238"] = 224,["239"] = 231,["240"] = 231,["241"] = 231,["242"] = 231,["243"] = 231,["244"] = 231,["245"] = 231,["246"] = 231,["247"] = 231,["248"] = 242,["249"] = 242,["250"] = 242,["251"] = 248,["252"] = 248,["253"] = 248,["254"] = 248,["255"] = 254,["256"] = 254,["257"] = 254,["258"] = 259,["259"] = 259,["260"] = 259,["261"] = 259,["262"] = 259,["263"] = 259,["264"] = 267,["265"] = 267,["266"] = 267,["267"] = 267,["268"] = 267,["269"] = 274,["270"] = 274,["271"] = 274,["272"] = 279,["273"] = 279,["274"] = 279,["275"] = 279,["276"] = 279,["277"] = 286,["278"] = 286,["279"] = 286,["280"] = 286,["281"] = 286,["282"] = 293,["283"] = 293,["284"] = 293,["285"] = 293,["286"] = 293,["287"] = 300,["288"] = 300,["289"] = 304,["290"] = 304,["291"] = 304});
EntityVisual = EntityVisual or ({})
EntityVisual.cube = "cube"
EntityVisual.sprite = "sprite"
EntityVisual.upright_sprite = "upright_sprite"
EntityVisual.mesh = "mesh"
EntityVisual.wielditem = "wielditem"
EntityVisual.item = "item"
SchematicRotation = SchematicRotation or ({})
SchematicRotation.zero = "0"
SchematicRotation.ninety = "90"
SchematicRotation.oneEighty = "180"
SchematicRotation.twoSeventy = "270"
SchematicRotation.random = "random"
SchematicPlacementFlag = SchematicPlacementFlag or ({})
SchematicPlacementFlag.place_center_x = "place_center_x"
SchematicPlacementFlag.place_center_y = "place_center_y"
SchematicPlacementFlag.place_center_z = "place_center_z"
SchematicFormat = SchematicFormat or ({})
SchematicFormat.mts = "mts"
SchematicFormat.lua = "lua"
SchematicSerializationOption = SchematicSerializationOption or ({})
SchematicSerializationOption.lua_use_comments = "lua_use_comments"
SchematicSerializationOption.lua_num_indent_spaces = "lua_num_indent_spaces"
SchematicReadOptionYSliceOption = SchematicReadOptionYSliceOption or ({})
SchematicReadOptionYSliceOption.none = "none"
SchematicReadOptionYSliceOption.low = "low"
SchematicReadOptionYSliceOption.all = "all"
HTTPRequestMethod = HTTPRequestMethod or ({})
HTTPRequestMethod.GET = "GET"
HTTPRequestMethod.POST = "POST"
HTTPRequestMethod.PUT = "PUT"
HTTPRequestMethod.DELETE = "DELETE"
OreType = OreType or ({})
OreType.scatter = "scatter"
OreType.sheet = "sheet"
OreType.puff = "puff"
OreType.blob = "blob"
OreType.vein = "vein"
OreType.stratum = "stratum"
OreFlags = OreFlags or ({})
OreFlags.puff_cliffs = "puff_cliffs"
OreFlags.puff_additive_composition = "puff_additive_composition"
NoiseFlags = NoiseFlags or ({})
NoiseFlags.defaults = "defaults"
NoiseFlags.eased = "eased"
NoiseFlags.absvalue = "absvalue"
DecorationType = DecorationType or ({})
DecorationType.simple = "simple"
DecorationType.schematic = "schematic"
DecorationFlags = DecorationFlags or ({})
DecorationFlags.liquid_surface = "liquid_surface"
DecorationFlags.force_placement = "force_placement"
DecorationFlags.all_floors = "all_floors"
DecorationFlags.all_ceilings = "all_ceilings"
DecorationFlags.place_center_x = "place_center_x"
DecorationFlags.place_center_y = "place_center_y"
DecorationFlags.place_center_z = "place_center_z"
ParamType1 = ParamType1 or ({})
ParamType1.light = "light"
ParamType1.none = "none"
ParamType2 = ParamType2 or ({})
ParamType2.flowingliquid = "flowingliquid"
ParamType2.wallmounted = "wallmounted"
ParamType2.facedir = "facedir"
ParamType2.fourdir = "4dir"
ParamType2.leveled = "leveled"
ParamType2.degrotate = "degrotate"
ParamType2.meshoptions = "meshoptions"
ParamType2.color = "color"
ParamType2.colorfacedir = "colorfacedir"
ParamType2.color4dir = "color4dir"
ParamType2.colorwallmounted = "colorwallmounted"
ParamType2.glasslikeliquidlevel = "glasslikeliquidlevel"
ParamType2.colordegrotate = "colordegrotate"
Drawtype = Drawtype or ({})
Drawtype.normal = "normal"
Drawtype.airlike = "airlike"
Drawtype.liquid = "liquid"
Drawtype.flowingliquid = "flowingliquid"
Drawtype.glasslike = "glasslike"
Drawtype.glasslike_framed = "glasslike_framed"
Drawtype.glasslike_framed_optional = "glasslike_framed_optional"
Drawtype.allfaces = "allfaces"
Drawtype.allfaces_optional = "allfaces_optional"
Drawtype.torchlike = "torchlike"
Drawtype.signlike = "signlike"
Drawtype.plantlike = "plantlike"
Drawtype.firelike = "firelike"
Drawtype.fencelike = "fencelike"
Drawtype.raillike = "raillike"
Drawtype.nodebox = "nodebox"
Drawtype.mesh = "mesh"
Drawtype.plantlike_rooted = "plantlike_rooted"
nodeboxtype = nodeboxtype or ({})
nodeboxtype.regular = "regular"
nodeboxtype.fixed = "fixed"
nodeboxtype.wallmounted = "wallmounted"
nodeboxtype.connected = "connected"
LogLevel = LogLevel or ({})
LogLevel.none = "none"
LogLevel.error = "error"
LogLevel.warning = "warning"
LogLevel.action = "action"
LogLevel.info = "info"
LogLevel.verbose = "verbose"
TextureAlpha = TextureAlpha or ({})
TextureAlpha.opaque = "opaque"
TextureAlpha.clip = "clip"
TextureAlpha.blend = "blend"
LiquidType = LiquidType or ({})
LiquidType.none = "none"
LiquidType.source = "source"
LiquidType.flowing = "flowing"
NodeBoxConnections = NodeBoxConnections or ({})
NodeBoxConnections.top = "top"
NodeBoxConnections.bottom = "bottom"
NodeBoxConnections.front = "front"
NodeBoxConnections.left = "left"
NodeBoxConnections.back = "back"
NodeBoxConnections.right = "right"
CraftRecipeType = CraftRecipeType or ({})
CraftRecipeType.shapeless = "shapeless"
CraftRecipeType.toolrepair = "toolrepair"
CraftRecipeType.cooking = "cooking"
CraftRecipeType.fuel = "fuel"
HPChangeReasonType = HPChangeReasonType or ({})
HPChangeReasonType.set_hp = "set_hp"
HPChangeReasonType.punch = "punch"
HPChangeReasonType.fall = "fall"
HPChangeReasonType.node_damage = "node_damage"
HPChangeReasonType.drown = "drown"
HPChangeReasonType.respawn = "respawn"
CheatType = CheatType or ({})
CheatType.moved_too_fast = "moved_too_fast"
CheatType.interacted_too_far = "interacted_too_far"
CheatType.interacted_with_self = "interacted_with_self"
CheatType.interacted_while_dead = "interacted_while_dead"
CheatType.finished_unknown_dig = "finished_unknown_dig"
CheatType.dug_unbreakable = "dug_unbreakable"
CheatType.dug_too_fast = "dug_too_fast"
ClearObjectsOptions = ClearObjectsOptions or ({})
ClearObjectsOptions.full = "full"
ClearObjectsOptions.quick = "quick"
GenNotifyFlags = GenNotifyFlags or ({})
GenNotifyFlags.dungeon = "dungeon"
GenNotifyFlags.temple = "temple"
GenNotifyFlags.cave_begin = "cave_begin"
GenNotifyFlags.cave_end = "cave_end"
GenNotifyFlags.large_cave_begin = "large_cave_begin"
GenNotifyFlags.large_cave_end = "large_cave_end"
GenNotifyFlags.decoration = "decoration"
SearchAlgorithm = SearchAlgorithm or ({})
SearchAlgorithm.aStarNoprefetch = "A*_noprefetch"
SearchAlgorithm.aStar = "A*"
SearchAlgorithm.dijkstra = "Dijkstra"
SkyParametersType = SkyParametersType or ({})
SkyParametersType.regular = "regular"
SkyParametersType.skybox = "skybox"
SkyParametersType.plain = "plain"
SkyParametersFogTintType = SkyParametersFogTintType or ({})
SkyParametersFogTintType.custom = "custom"
SkyParametersFogTintType.default = "default"
MinimapType = MinimapType or ({})
MinimapType.off = "off"
MinimapType.surface = "surface"
MinimapType.radar = "radar"
MinimapType.texture = "texture"
HudElementType = HudElementType or ({})
HudElementType.image = "image"
HudElementType.text = "text"
HudElementType.statbar = "statbar"
HudElementType.inventory = "inventory"
HudElementType.waypoint = "waypoint"
HudElementType.image_waypoint = "image_waypoint"
HudElementType.compass = "compass"
HudElementType.minimap = "minimap"
HudReplaceBuiltinOption = HudReplaceBuiltinOption or ({})
HudReplaceBuiltinOption.breath = "breath"
HudReplaceBuiltinOption.health = "health"
ParseRelativeNumberArgument = ParseRelativeNumberArgument or ({})
ParseRelativeNumberArgument.number = "<number>"
ParseRelativeNumberArgument.relativeToPlus = "~<number>"
ParseRelativeNumberArgument.relativeTo = "~"
CompressionMethod = CompressionMethod or ({})
CompressionMethod.deflate = "deflate"
CompressionMethod.zstd = "zstd"
RotateAndPlaceOrientationFlag = RotateAndPlaceOrientationFlag or ({})
RotateAndPlaceOrientationFlag.invert_wall = "invert_wall"
RotateAndPlaceOrientationFlag.force_wall = "force_wall"
RotateAndPlaceOrientationFlag.force_ceiling = "force_ceiling"
RotateAndPlaceOrientationFlag.force_floor = "force_floor"
RotateAndPlaceOrientationFlag.force_facedir = "force_facedir"
BlockStatusCondition = BlockStatusCondition or ({})
BlockStatusCondition.unknown = "unknown"
BlockStatusCondition.emerging = "emerging"
BlockStatusCondition.loaded = "loaded"
BlockStatusCondition.active = "active"
TileAnimationType = TileAnimationType or ({})
TileAnimationType.vertical_frames = "vertical_frames"
TileAnimationType.sheed_2d = "sheed_2d"
ParticleSpawnerTweenStyle = ParticleSpawnerTweenStyle or ({})
ParticleSpawnerTweenStyle.fwd = "fwd"
ParticleSpawnerTweenStyle.rev = "rev"
ParticleSpawnerTweenStyle.pulse = "pulse"
ParticleSpawnerTweenStyle.flicker = "flicker"
ParticleSpawnerTextureBlend = ParticleSpawnerTextureBlend or ({})
ParticleSpawnerTextureBlend.alpha = "alpha"
ParticleSpawnerTextureBlend.add = "add"
ParticleSpawnerTextureBlend.screen = "screen"
ParticleSpawnerTextureBlend.sub = "sub"
ParticleSpawnerAttractionType = ParticleSpawnerAttractionType or ({})
ParticleSpawnerAttractionType.none = "none"
ParticleSpawnerAttractionType.point = "point"
ParticleSpawnerAttractionType.line = "line"
ParticleSpawnerAttractionType.plane = "plane"
AreaStoreType = AreaStoreType or ({})
AreaStoreType.libSpatial = "LibSpatial"
TexturePoolComponentFade = TexturePoolComponentFade or ({})
TexturePoolComponentFade["in"] = "in"
TexturePoolComponentFade.out = "out"
