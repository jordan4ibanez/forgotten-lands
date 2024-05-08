-- Lua Library inline imports
local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["78"] = 2,["80"] = 4,["81"] = 5,["82"] = 6,["83"] = 9,["84"] = 10,["85"] = 13,["86"] = 17,["87"] = 17,["88"] = 17,["89"] = 17,["90"] = 17,["91"] = 17,["92"] = 17,["93"] = 17,["95"] = 27,["97"] = 29,["98"] = 29,["99"] = 30,["100"] = 31,["101"] = 29,["104"] = 34,["105"] = 34,["106"] = 34,["107"] = 34,["108"] = 34,["109"] = 34,["110"] = 34,["111"] = 34,["112"] = 34,["113"] = 34,["114"] = 45,["115"] = 46,["116"] = 47,["117"] = 49,["118"] = 49,["119"] = 49,["120"] = 49,["121"] = 59,["122"] = 59,["123"] = 59,["124"] = 59,["125"] = 59,["126"] = 59,["127"] = 59,["128"] = 59,["129"] = 59,["130"] = 59,["131"] = 59,["132"] = 59,["133"] = 59,["134"] = 59,["135"] = 59,["136"] = 59,["137"] = 59,["138"] = 59,["139"] = 59,["140"] = 59,["141"] = 59,["142"] = 59,["143"] = 59,["144"] = 59,["145"] = 59,["146"] = 59,["147"] = 49,["148"] = 90,["149"] = 90,["150"] = 90,["151"] = 90,["152"] = 90,["153"] = 90,["154"] = 90,["155"] = 90,["156"] = 90,["157"] = 90,["158"] = 90,["159"] = 90,["160"] = 90,["161"] = 90,["162"] = 90,["163"] = 90,["164"] = 90,["165"] = 90,["166"] = 90,["167"] = 90,["168"] = 90,["169"] = 90,["170"] = 90,["171"] = 90,["172"] = 90,["173"] = 90,["174"] = 49,["175"] = 49,["176"] = 99,["177"] = 99,["178"] = 99,["179"] = 99,["180"] = 109,["181"] = 109,["182"] = 109,["183"] = 109,["184"] = 109,["185"] = 109,["186"] = 109,["187"] = 109,["188"] = 109,["189"] = 109,["190"] = 109,["191"] = 109,["192"] = 109,["193"] = 109,["194"] = 109,["195"] = 109,["196"] = 109,["197"] = 109,["198"] = 109,["199"] = 109,["200"] = 109,["201"] = 109,["202"] = 109,["203"] = 109,["204"] = 109,["205"] = 109,["206"] = 109,["207"] = 109,["208"] = 109,["209"] = 109,["210"] = 109,["211"] = 109,["212"] = 109,["213"] = 109,["214"] = 109,["215"] = 109,["216"] = 109,["217"] = 109,["218"] = 109,["219"] = 109,["220"] = 109,["221"] = 109,["222"] = 109,["223"] = 109,["224"] = 109,["225"] = 109,["226"] = 109,["227"] = 109,["228"] = 109,["229"] = 109,["230"] = 99,["231"] = 166,["232"] = 166,["233"] = 166,["234"] = 166,["235"] = 166,["236"] = 166,["237"] = 166,["238"] = 166,["239"] = 166,["240"] = 166,["241"] = 166,["242"] = 166,["243"] = 166,["244"] = 166,["245"] = 166,["246"] = 166,["247"] = 166,["248"] = 166,["249"] = 166,["250"] = 166,["251"] = 166,["252"] = 166,["253"] = 166,["254"] = 166,["255"] = 166,["256"] = 166,["257"] = 166,["258"] = 166,["259"] = 166,["260"] = 166,["261"] = 166,["262"] = 166,["263"] = 166,["264"] = 166,["265"] = 166,["266"] = 166,["267"] = 166,["268"] = 166,["269"] = 166,["270"] = 166,["271"] = 166,["272"] = 166,["273"] = 166,["274"] = 166,["275"] = 166,["276"] = 166,["277"] = 166,["278"] = 166,["279"] = 166,["280"] = 166,["281"] = 99,["282"] = 99,["283"] = 177,["284"] = 177,["285"] = 177,["286"] = 177,["287"] = 187,["288"] = 187,["289"] = 187,["290"] = 187,["291"] = 187,["292"] = 187,["293"] = 187,["294"] = 187,["295"] = 187,["296"] = 187,["297"] = 187,["298"] = 187,["299"] = 187,["300"] = 187,["301"] = 187,["302"] = 187,["303"] = 187,["304"] = 187,["305"] = 187,["306"] = 187,["307"] = 187,["308"] = 187,["309"] = 187,["310"] = 187,["311"] = 187,["312"] = 187,["313"] = 187,["314"] = 187,["315"] = 187,["316"] = 187,["317"] = 187,["318"] = 187,["319"] = 187,["320"] = 187,["321"] = 187,["322"] = 187,["323"] = 187,["324"] = 187,["325"] = 187,["326"] = 187,["327"] = 187,["328"] = 187,["329"] = 187,["330"] = 187,["331"] = 187,["332"] = 187,["333"] = 187,["334"] = 187,["335"] = 187,["336"] = 187,["337"] = 187,["338"] = 187,["339"] = 187,["340"] = 187,["341"] = 187,["342"] = 187,["343"] = 187,["344"] = 187,["345"] = 187,["346"] = 187,["347"] = 187,["348"] = 187,["349"] = 187,["350"] = 187,["351"] = 187,["352"] = 187,["353"] = 187,["354"] = 187,["355"] = 187,["356"] = 187,["357"] = 187,["358"] = 187,["359"] = 187,["360"] = 187,["361"] = 187,["362"] = 187,["363"] = 187,["364"] = 187,["365"] = 187,["366"] = 187,["367"] = 187,["368"] = 187,["369"] = 177,["370"] = 277,["371"] = 277,["372"] = 277,["373"] = 277,["374"] = 277,["375"] = 277,["376"] = 277,["377"] = 277,["378"] = 277,["379"] = 277,["380"] = 277,["381"] = 277,["382"] = 277,["383"] = 277,["384"] = 277,["385"] = 277,["386"] = 277,["387"] = 277,["388"] = 277,["389"] = 277,["390"] = 277,["391"] = 277,["392"] = 277,["393"] = 277,["394"] = 277,["395"] = 277,["396"] = 277,["397"] = 277,["398"] = 277,["399"] = 277,["400"] = 277,["401"] = 277,["402"] = 277,["403"] = 277,["404"] = 277,["405"] = 277,["406"] = 277,["407"] = 277,["408"] = 277,["409"] = 277,["410"] = 277,["411"] = 277,["412"] = 277,["413"] = 277,["414"] = 277,["415"] = 277,["416"] = 277,["417"] = 277,["418"] = 277,["419"] = 277,["420"] = 277,["421"] = 277,["422"] = 277,["423"] = 277,["424"] = 277,["425"] = 277,["426"] = 277,["427"] = 277,["428"] = 277,["429"] = 277,["430"] = 277,["431"] = 277,["432"] = 277,["433"] = 277,["434"] = 277,["435"] = 277,["436"] = 277,["437"] = 277,["438"] = 277,["439"] = 277,["440"] = 277,["441"] = 277,["442"] = 277,["443"] = 277,["444"] = 277,["445"] = 277,["446"] = 277,["447"] = 277,["448"] = 277,["449"] = 277,["450"] = 277,["451"] = 277,["452"] = 177,["453"] = 177,["455"] = 290,["456"] = 291,["457"] = 292,["458"] = 293,["459"] = 294,["460"] = 295,["461"] = 295,["462"] = 295,["463"] = 296,["464"] = 296,["465"] = 296,["466"] = 296,["467"] = 296,["468"] = 296,["469"] = 296,["470"] = 296,["471"] = 296,["472"] = 296,["473"] = 296,["474"] = 295,["475"] = 295,["478"] = 311});
world = world or ({})
do
    minetest.register_alias("mapgen_stone", "stone")
    minetest.register_alias("mapgen_dirt", "dirt")
    minetest.register_alias("mapgen_dirt_with_grass", "grass")
    minetest.register_alias("mapgen_sand", "sand")
    minetest.register_alias("mapgen_gravel", "gravel")
    minetest.register_alias("mapgen_water_source", "waterSource")
    minetest.register_biome({
        name = "Forgotten Fields",
        node_top = "grass",
        depth_top = 1,
        node_filler = "dirt",
        depth_filler = 6,
        node_stone = "stone"
    })
    do
        local grass = {}
        do
            local i = 1
            while i <= 5 do
                local height = tostring(i)
                table.insert(grass, "tall_grass_" .. height)
                i = i + 1
            end
        end
        minetest.register_decoration({
            name = "grassOnFields",
            deco_type = DecorationType.simple,
            place_on = "grass",
            biomes = {"Forgotten Fields"},
            decoration = grass,
            param2 = 0,
            param2_max = 239,
            fill_ratio = 0.98
        })
        local concat = utility.concat
        local generateSchematic = utility.generateSchematic
        local create = vector.create3d
        local smallOak = generateSchematic(
            create(5, 5, 5),
            {[" "] = "air", I = "oak_tree", H = "oak_leaves"},
            {I = true},
            concat(
                "     ",
                "     ",
                "  H  ",
                " HHH ",
                "     ",
                "     ",
                "  H  ",
                " HHH ",
                "HHHHH",
                "     ",
                "  H  ",
                " HHH ",
                "HHIHH",
                "HHIHH",
                "  I  ",
                "     ",
                "  H  ",
                " HHH ",
                "HHHHH",
                "     ",
                "     ",
                "     ",
                "  H  ",
                " HHH ",
                "     "
            ),
            {
                253,
                253,
                253,
                253,
                253,
                253,
                254,
                254,
                254,
                253,
                253,
                254,
                255,
                254,
                253,
                253,
                254,
                254,
                254,
                253,
                253,
                253,
                253,
                253,
                253
            }
        )
        local mediumOak = generateSchematic(
            create(7, 7, 7),
            {[" "] = "air", I = "oak_tree", H = "oak_leaves"},
            {I = true},
            concat(
                "       ",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                "       ",
                "       ",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                " HHHHH ",
                "       ",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                " HHHHH ",
                "HHHHHHH",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                " HHIHH ",
                "HHHIHHH",
                "HHHIHHH",
                "   I   ",
                "   I   ",
                "       ",
                "   H   ",
                "  HHH  ",
                " HHHHH ",
                "HHHHHHH",
                "       ",
                "       ",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                " HHHHH ",
                "       ",
                "       ",
                "       ",
                "       ",
                "       ",
                "   H   ",
                "  HHH  ",
                "       ",
                "       "
            ),
            {
                252,
                252,
                252,
                252,
                252,
                252,
                252,
                252,
                253,
                253,
                253,
                253,
                253,
                252,
                252,
                253,
                254,
                254,
                254,
                253,
                252,
                252,
                253,
                254,
                255,
                254,
                253,
                252,
                252,
                253,
                254,
                254,
                254,
                253,
                252,
                252,
                253,
                253,
                253,
                253,
                253,
                252,
                252,
                252,
                252,
                252,
                252,
                252,
                252
            }
        )
        local largeOak = generateSchematic(
            create(9, 9, 9),
            {[" "] = "air", I = "oak_tree", H = "oak_leaves"},
            {I = true},
            concat(
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "   HHH   ",
                "         ",
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                "  HHHHH  ",
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                " HHHHHHH ",
                " HHHHHHH ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                " HHHHHHH ",
                "HHHHHHHHH",
                "HHHHHHHHH",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHIHH  ",
                " HHHIHHH ",
                "HHHHIHHHH",
                "HHHHIHHHH",
                "HHHHIHHHH",
                "    I    ",
                "    I    ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                " HHHHHHH ",
                "HHHHHHHHH",
                "HHHHHHHHH",
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                " HHHHHHH ",
                " HHHHHHH ",
                "         ",
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "  HHHHH  ",
                "  HHHHH  ",
                "         ",
                "         ",
                "         ",
                "         ",
                "         ",
                "         ",
                "    H    ",
                "   HHH   ",
                "   HHH   ",
                "         ",
                "         "
            ),
            {
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                252,
                252,
                252,
                252,
                252,
                252,
                252,
                251,
                251,
                252,
                253,
                253,
                253,
                253,
                253,
                252,
                251,
                251,
                252,
                253,
                254,
                254,
                254,
                253,
                252,
                251,
                251,
                252,
                253,
                254,
                255,
                254,
                253,
                252,
                251,
                251,
                252,
                253,
                254,
                254,
                254,
                253,
                252,
                251,
                251,
                252,
                253,
                253,
                253,
                253,
                253,
                252,
                251,
                251,
                252,
                252,
                252,
                252,
                252,
                252,
                252,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251,
                251
            }
        )
        do
            local smallID = minetest.register_schematic(smallOak)
            local mediumID = minetest.register_schematic(mediumOak)
            local largeID = minetest.register_schematic(largeOak)
            local oakSize = {"small", "medium", "large"}
            local oakIDs = {smallID, mediumID, largeID}
            __TS__ArrayForEach(
                oakIDs,
                function(____, id, key)
                    minetest.register_decoration({
                        name = "oak_" .. oakSize[key + 1],
                        deco_type = DecorationType.schematic,
                        place_on = "grass",
                        biomes = {"Forgotten Fields"},
                        schematic = id,
                        fill_ratio = 0.01,
                        place_offset_y = 1,
                        y_min = 1,
                        flags = "place_center_x, place_center_z"
                    })
                end
            )
        end
    end
    utility.loadFiles({"ores"})
end
