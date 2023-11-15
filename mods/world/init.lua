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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["78"] = 2,["79"] = 3,["80"] = 4,["81"] = 7,["82"] = 8,["83"] = 14,["84"] = 14,["85"] = 14,["86"] = 14,["87"] = 14,["88"] = 14,["89"] = 14,["90"] = 14,["92"] = 24,["94"] = 26,["95"] = 26,["96"] = 27,["97"] = 28,["98"] = 26,["101"] = 31,["102"] = 31,["103"] = 31,["104"] = 31,["105"] = 31,["106"] = 31,["107"] = 31,["108"] = 31,["109"] = 31,["110"] = 31,["111"] = 42,["112"] = 43,["113"] = 44,["114"] = 46,["115"] = 46,["116"] = 46,["117"] = 46,["118"] = 56,["119"] = 56,["120"] = 56,["121"] = 56,["122"] = 56,["123"] = 56,["124"] = 56,["125"] = 56,["126"] = 56,["127"] = 56,["128"] = 56,["129"] = 56,["130"] = 56,["131"] = 56,["132"] = 56,["133"] = 56,["134"] = 56,["135"] = 56,["136"] = 56,["137"] = 56,["138"] = 56,["139"] = 56,["140"] = 56,["141"] = 56,["142"] = 56,["143"] = 56,["144"] = 46,["145"] = 87,["146"] = 87,["147"] = 87,["148"] = 87,["149"] = 87,["150"] = 87,["151"] = 87,["152"] = 87,["153"] = 87,["154"] = 87,["155"] = 87,["156"] = 87,["157"] = 87,["158"] = 87,["159"] = 87,["160"] = 87,["161"] = 87,["162"] = 87,["163"] = 87,["164"] = 87,["165"] = 87,["166"] = 87,["167"] = 87,["168"] = 87,["169"] = 87,["170"] = 87,["171"] = 46,["172"] = 46,["173"] = 96,["174"] = 96,["175"] = 96,["176"] = 96,["177"] = 106,["178"] = 106,["179"] = 106,["180"] = 106,["181"] = 106,["182"] = 106,["183"] = 106,["184"] = 106,["185"] = 106,["186"] = 106,["187"] = 106,["188"] = 106,["189"] = 106,["190"] = 106,["191"] = 106,["192"] = 106,["193"] = 106,["194"] = 106,["195"] = 106,["196"] = 106,["197"] = 106,["198"] = 106,["199"] = 106,["200"] = 106,["201"] = 106,["202"] = 106,["203"] = 106,["204"] = 106,["205"] = 106,["206"] = 106,["207"] = 106,["208"] = 106,["209"] = 106,["210"] = 106,["211"] = 106,["212"] = 106,["213"] = 106,["214"] = 106,["215"] = 106,["216"] = 106,["217"] = 106,["218"] = 106,["219"] = 106,["220"] = 106,["221"] = 106,["222"] = 106,["223"] = 106,["224"] = 106,["225"] = 106,["226"] = 106,["227"] = 96,["228"] = 163,["229"] = 163,["230"] = 163,["231"] = 163,["232"] = 163,["233"] = 163,["234"] = 163,["235"] = 163,["236"] = 163,["237"] = 163,["238"] = 163,["239"] = 163,["240"] = 163,["241"] = 163,["242"] = 163,["243"] = 163,["244"] = 163,["245"] = 163,["246"] = 163,["247"] = 163,["248"] = 163,["249"] = 163,["250"] = 163,["251"] = 163,["252"] = 163,["253"] = 163,["254"] = 163,["255"] = 163,["256"] = 163,["257"] = 163,["258"] = 163,["259"] = 163,["260"] = 163,["261"] = 163,["262"] = 163,["263"] = 163,["264"] = 163,["265"] = 163,["266"] = 163,["267"] = 163,["268"] = 163,["269"] = 163,["270"] = 163,["271"] = 163,["272"] = 163,["273"] = 163,["274"] = 163,["275"] = 163,["276"] = 163,["277"] = 163,["278"] = 96,["279"] = 96,["280"] = 174,["281"] = 174,["282"] = 174,["283"] = 174,["284"] = 184,["285"] = 184,["286"] = 184,["287"] = 184,["288"] = 184,["289"] = 184,["290"] = 184,["291"] = 184,["292"] = 184,["293"] = 184,["294"] = 184,["295"] = 184,["296"] = 184,["297"] = 184,["298"] = 184,["299"] = 184,["300"] = 184,["301"] = 184,["302"] = 184,["303"] = 184,["304"] = 184,["305"] = 184,["306"] = 184,["307"] = 184,["308"] = 184,["309"] = 184,["310"] = 184,["311"] = 184,["312"] = 184,["313"] = 184,["314"] = 184,["315"] = 184,["316"] = 184,["317"] = 184,["318"] = 184,["319"] = 184,["320"] = 184,["321"] = 184,["322"] = 184,["323"] = 184,["324"] = 184,["325"] = 184,["326"] = 184,["327"] = 184,["328"] = 184,["329"] = 184,["330"] = 184,["331"] = 184,["332"] = 184,["333"] = 184,["334"] = 184,["335"] = 184,["336"] = 184,["337"] = 184,["338"] = 184,["339"] = 184,["340"] = 184,["341"] = 184,["342"] = 184,["343"] = 184,["344"] = 184,["345"] = 184,["346"] = 184,["347"] = 184,["348"] = 184,["349"] = 184,["350"] = 184,["351"] = 184,["352"] = 184,["353"] = 184,["354"] = 184,["355"] = 184,["356"] = 184,["357"] = 184,["358"] = 184,["359"] = 184,["360"] = 184,["361"] = 184,["362"] = 184,["363"] = 184,["364"] = 184,["365"] = 184,["366"] = 174,["367"] = 274,["368"] = 274,["369"] = 274,["370"] = 274,["371"] = 274,["372"] = 274,["373"] = 274,["374"] = 274,["375"] = 274,["376"] = 274,["377"] = 274,["378"] = 274,["379"] = 274,["380"] = 274,["381"] = 274,["382"] = 274,["383"] = 274,["384"] = 274,["385"] = 274,["386"] = 274,["387"] = 274,["388"] = 274,["389"] = 274,["390"] = 274,["391"] = 274,["392"] = 274,["393"] = 274,["394"] = 274,["395"] = 274,["396"] = 274,["397"] = 274,["398"] = 274,["399"] = 274,["400"] = 274,["401"] = 274,["402"] = 274,["403"] = 274,["404"] = 274,["405"] = 274,["406"] = 274,["407"] = 274,["408"] = 274,["409"] = 274,["410"] = 274,["411"] = 274,["412"] = 274,["413"] = 274,["414"] = 274,["415"] = 274,["416"] = 274,["417"] = 274,["418"] = 274,["419"] = 274,["420"] = 274,["421"] = 274,["422"] = 274,["423"] = 274,["424"] = 274,["425"] = 274,["426"] = 274,["427"] = 274,["428"] = 274,["429"] = 274,["430"] = 274,["431"] = 274,["432"] = 274,["433"] = 274,["434"] = 274,["435"] = 274,["436"] = 274,["437"] = 274,["438"] = 274,["439"] = 274,["440"] = 274,["441"] = 274,["442"] = 274,["443"] = 274,["444"] = 274,["445"] = 274,["446"] = 274,["447"] = 274,["448"] = 274,["449"] = 174,["450"] = 174,["452"] = 287,["453"] = 288,["454"] = 289,["455"] = 290,["456"] = 291,["457"] = 292,["458"] = 292,["459"] = 292,["460"] = 293,["461"] = 293,["462"] = 293,["463"] = 293,["464"] = 293,["465"] = 293,["466"] = 293,["467"] = 293,["468"] = 293,["469"] = 293,["470"] = 292,["471"] = 292});
minetest.register_alias("mapgen_stone", "stone")
minetest.register_alias("mapgen_dirt", "dirt")
minetest.register_alias("mapgen_dirt_with_grass", "grass")
minetest.register_alias("mapgen_sand", "sand")
minetest.register_alias("mapgen_gravel", "gravel")
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
    local create = vector.create
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
                    flags = "place_center_x, place_center_z"
                })
            end
        )
    end
end
