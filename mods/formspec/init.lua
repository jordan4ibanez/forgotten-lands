-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["141"] = 1,["143"] = 18,["144"] = 1,["145"] = 21,["146"] = 20,["151"] = 1,["152"] = 30,["153"] = 31,["154"] = 32,["155"] = 33,["156"] = 34,["158"] = 36,["159"] = 37,["161"] = 39,["162"] = 29,["163"] = 1,["164"] = 1,["165"] = 55,["166"] = 64,["167"] = 65,["168"] = 66,["169"] = 67,["170"] = 68,["171"] = 69,["172"] = 70,["173"] = 71,["174"] = 64,["175"] = 74,["176"] = 75,["177"] = 75,["178"] = 76,["179"] = 74,["180"] = 1,["181"] = 1,["182"] = 93,["183"] = 96,["185"] = 97,["186"] = 98,["188"] = 96,["189"] = 100,["190"] = 101,["191"] = 101,["192"] = 102,["193"] = 100,["194"] = 108,["195"] = 108,["196"] = 108,["197"] = 1,["198"] = 1,["199"] = 120,["200"] = 1,["201"] = 125,["202"] = 120,["203"] = 130,["204"] = 131,["205"] = 132,["206"] = 133,["207"] = 125,["208"] = 1,["209"] = 1,["210"] = 147,["211"] = 153,["212"] = 154,["213"] = 155,["214"] = 156,["215"] = 157,["216"] = 158,["217"] = 153,["218"] = 1,["219"] = 1,["220"] = 169,["221"] = 172,["222"] = 173,["223"] = 174,["224"] = 172,["225"] = 1,["226"] = 1,["227"] = 188,["228"] = 194,["229"] = 195,["230"] = 196,["231"] = 197,["232"] = 198,["233"] = 199,["234"] = 194,["235"] = 1,["236"] = 1,["237"] = 213,["238"] = 219,["239"] = 220,["240"] = 221,["241"] = 222,["242"] = 223,["243"] = 219,["244"] = 1,["245"] = 1,["246"] = 237,["247"] = 243,["248"] = 244,["249"] = 245,["250"] = 246,["251"] = 247,["252"] = 248,["253"] = 243,["254"] = 1,["255"] = 1,["256"] = 261,["257"] = 266,["258"] = 267,["259"] = 268,["260"] = 269,["261"] = 270,["262"] = 266,["263"] = 1,["264"] = 1,["265"] = 283,["266"] = 1,["267"] = 288,["268"] = 283,["269"] = 290,["270"] = 291,["271"] = 292,["272"] = 293,["273"] = 288,["274"] = 1,["275"] = 1,["276"] = 312,["277"] = 323,["278"] = 324,["279"] = 325,["280"] = 326,["281"] = 327,["282"] = 328,["283"] = 329,["284"] = 330,["285"] = 331,["286"] = 332,["287"] = 333,["288"] = 323,["289"] = 1,["290"] = 1,["291"] = 346,["292"] = 351,["293"] = 352,["294"] = 353,["295"] = 354,["296"] = 351,["297"] = 1,["298"] = 1,["299"] = 368,["300"] = 374,["301"] = 375,["302"] = 376,["303"] = 377,["304"] = 378,["305"] = 379,["306"] = 374,["307"] = 1,["308"] = 1,["309"] = 392,["310"] = 397,["311"] = 398,["312"] = 399,["313"] = 400,["314"] = 401,["315"] = 397,["316"] = 1,["317"] = 1,["318"] = 415,["319"] = 421,["320"] = 422,["321"] = 423,["322"] = 424,["323"] = 425,["324"] = 426,["325"] = 421,["326"] = 1,["327"] = 1,["328"] = 432,["329"] = 434,["330"] = 435,["331"] = 434,["332"] = 1,["333"] = 1,["334"] = 441,["335"] = 443,["336"] = 444,["337"] = 443,["338"] = 1,["339"] = 1,["340"] = 458,["341"] = 464,["342"] = 465,["343"] = 466,["344"] = 467,["345"] = 468,["346"] = 469,["347"] = 464,["348"] = 1,["349"] = 1,["350"] = 480,["351"] = 483,["352"] = 484,["353"] = 485,["354"] = 483,["355"] = 1,["356"] = 1,["357"] = 498,["358"] = 503,["359"] = 504,["360"] = 505,["361"] = 506,["362"] = 507,["363"] = 503,["364"] = 1,["365"] = 1,["366"] = 518,["367"] = 521,["368"] = 522,["369"] = 523,["370"] = 521,["371"] = 1,["372"] = 1,["373"] = 536,["374"] = 541,["375"] = 542,["376"] = 543,["377"] = 544,["378"] = 545,["379"] = 541,["380"] = 1,["381"] = 1,["382"] = 555,["383"] = 1,["384"] = 557,["385"] = 555,["386"] = 559,["387"] = 557,["388"] = 1,["389"] = 1,["390"] = 571,["391"] = 1,["392"] = 575,["393"] = 571,["394"] = 577,["395"] = 578,["396"] = 579,["397"] = 575,["398"] = 1,["399"] = 1,["400"] = 593,["401"] = 599,["402"] = 600,["403"] = 601,["404"] = 602,["405"] = 603,["406"] = 604,["407"] = 599,["408"] = 1,["409"] = 1,["410"] = 610,["411"] = 1,["413"] = 610,["414"] = 612,["415"] = 610,["416"] = 1,["417"] = 1,["418"] = 617,["419"] = 1,["421"] = 617,["422"] = 619,["423"] = 617,["424"] = 1,["425"] = 1,["426"] = 634,["427"] = 642,["428"] = 643,["429"] = 644,["430"] = 645,["431"] = 646,["432"] = 647,["433"] = 648,["434"] = 642,["435"] = 1,["436"] = 1,["437"] = 665,["438"] = 674,["439"] = 675,["440"] = 676,["441"] = 677,["442"] = 678,["443"] = 679,["444"] = 680,["445"] = 681,["446"] = 674,["447"] = 1,["448"] = 1,["449"] = 693,["450"] = 697,["451"] = 698,["452"] = 699,["453"] = 700,["454"] = 697,["455"] = 1,["456"] = 1,["457"] = 716,["458"] = 724,["459"] = 725,["460"] = 726,["461"] = 727,["462"] = 728,["463"] = 729,["464"] = 730,["465"] = 724,["466"] = 1,["467"] = 1,["468"] = 743,["469"] = 748,["470"] = 749,["471"] = 750,["472"] = 751,["473"] = 752,["474"] = 748,["475"] = 1,["476"] = 1,["477"] = 766,["478"] = 773,["479"] = 774,["480"] = 775,["481"] = 776,["482"] = 777,["483"] = 778,["484"] = 773,["485"] = 1,["486"] = 1,["487"] = 784,["488"] = 787,["489"] = 788,["490"] = 787,["491"] = 1,["492"] = 1,["493"] = 803,["494"] = 810,["495"] = 811,["496"] = 812,["497"] = 813,["498"] = 814,["499"] = 815,["500"] = 810,["501"] = 1,["502"] = 1,["503"] = 821,["504"] = 824,["505"] = 825,["506"] = 824,["507"] = 1,["508"] = 1,["509"] = 831,["510"] = 834,["511"] = 835,["512"] = 834,["513"] = 1,["514"] = 1,["515"] = 841,["516"] = 844,["517"] = 845,["518"] = 844,["519"] = 1,["520"] = 1,["521"] = 851,["522"] = 854,["523"] = 855,["524"] = 854,["525"] = 1,["526"] = 1,["527"] = 866,["528"] = 869,["529"] = 870,["530"] = 871,["531"] = 869,["532"] = 1,["533"] = 881,["534"] = 1,["535"] = 885,["536"] = 1,["537"] = 891,["538"] = 1,["539"] = 895,["540"] = 896,["541"] = 1,["542"] = 903,["543"] = 1,["544"] = 907,["545"] = 908,["546"] = 909,["547"] = 910,["548"] = 911,["549"] = 1,["550"] = 1,["551"] = 918,["552"] = 919,["553"] = 921,["554"] = 1,["555"] = 926,["556"] = 927,["557"] = 928,["558"] = 931,["559"] = 932,["560"] = 933,["561"] = 936,["562"] = 937,["563"] = 939,["564"] = 940,["567"] = 945,["568"] = 1,["569"] = 949,["570"] = 950,["571"] = 951,["572"] = 952,["573"] = 954,["574"] = 1,["575"] = 958,["576"] = 959,["577"] = 960,["578"] = 961,["579"] = 962,["580"] = 1,["581"] = 1,["582"] = 968,["583"] = 969,["584"] = 970,["585"] = 971,["586"] = 1,["587"] = 975,["588"] = 976,["590"] = 979,["591"] = 1,["592"] = 983,["593"] = 984,["594"] = 985,["595"] = 986,["596"] = 987,["597"] = 988,["598"] = 989,["599"] = 990,["600"] = 1,["601"] = 995,["602"] = 996,["604"] = 999,["605"] = 1,["606"] = 1003,["607"] = 1004,["608"] = 1005,["609"] = 1006,["610"] = 1,["611"] = 1010,["612"] = 1011,["613"] = 1012,["614"] = 1013,["615"] = 1014,["616"] = 1,["617"] = 1,["618"] = 1023,["619"] = 1024,["620"] = 1025,["621"] = 1027,["622"] = 1,["623"] = 1031,["624"] = 1032,["625"] = 1033,["626"] = 1034,["627"] = 1034,["628"] = 1034,["630"] = 1034,["632"] = 1034,["633"] = 1035,["634"] = 1037,["635"] = 1038,["637"] = 1040,["639"] = 1,["640"] = 1045,["641"] = 1046,["643"] = 1049,["644"] = 1,["645"] = 1053,["646"] = 1054,["647"] = 1055,["648"] = 1056,["649"] = 1,["650"] = 1,["651"] = 1062,["652"] = 1063,["653"] = 1065,["654"] = 1067,["655"] = 1,["657"] = 1071,["658"] = 1072,["659"] = 1073,["660"] = 1075,["661"] = 1,["662"] = 1079,["663"] = 1080,["664"] = 1,["665"] = 1084,["666"] = 1085,["667"] = 1,["668"] = 1089,["669"] = 1090,["670"] = 1091,["671"] = 1092,["672"] = 1093,["673"] = 1,["674"] = 1,["675"] = 1100,["676"] = 1101,["677"] = 1,["678"] = 1,["679"] = 1107,["680"] = 1108,["681"] = 1109,["682"] = 1110,["683"] = 1,["684"] = 1,["685"] = 1117,["686"] = 1118,["687"] = 1,["688"] = 1,["689"] = 1124,["690"] = 1125,["691"] = 1126,["692"] = 1127,["693"] = 1,["694"] = 1,["695"] = 1133,["696"] = 1134,["697"] = 1135,["698"] = 1136,["699"] = 1137,["700"] = 1,["701"] = 1,["702"] = 1143,["703"] = 1144,["704"] = 1145,["705"] = 1146,["706"] = 1147,["707"] = 1148,["708"] = 1149,["709"] = 1150,["710"] = 1,["711"] = 1,["712"] = 1157,["713"] = 1158,["714"] = 1159,["715"] = 1160,["716"] = 1161,["717"] = 1,["718"] = 1,["719"] = 1168,["720"] = 1169,["721"] = 1170,["722"] = 1171,["723"] = 1,["724"] = 1,["725"] = 1177,["726"] = 1178,["727"] = 1179,["728"] = 1,["729"] = 1183,["730"] = 1184,["731"] = 1,["732"] = 1,["733"] = 1191,["734"] = 1192,["735"] = 1193,["736"] = 1,["737"] = 1197,["738"] = 1198,["739"] = 1199,["740"] = 1,["741"] = 1,["742"] = 1206,["743"] = 1207,["744"] = 1208,["745"] = 1,["746"] = 1,["747"] = 1214,["748"] = 1215,["749"] = 1216,["750"] = 1,["751"] = 1220,["752"] = 1221,["753"] = 1,["754"] = 1,["755"] = 1229,["756"] = 1230,["757"] = 1231,["758"] = 1232,["759"] = 1,["760"] = 1,["761"] = 1238,["762"] = 1239,["763"] = 1240,["764"] = 1241,["765"] = 1242,["766"] = 1,["767"] = 1,["768"] = 1,["769"] = 1251,["770"] = 1,["771"] = 1257,["772"] = 1258,["773"] = 1259,["774"] = 1,["775"] = 1263,["776"] = 1,["777"] = 1,["778"] = 1,["779"] = 1271,["780"] = 1,["781"] = 1,["782"] = 1277,["783"] = 1,["784"] = 1,["785"] = 1283,["786"] = 1,["787"] = 1,["788"] = 1289,["789"] = 1,["790"] = 1293,["791"] = 1294,["792"] = 1296,["795"] = 1309,["796"] = 879,["797"] = 1,["798"] = 1317,["799"] = 1318,["800"] = 1319,["801"] = 1319,["802"] = 1319,["804"] = 1319,["806"] = 1319,["807"] = 1320,["808"] = 1,["810"] = 1323,["811"] = 1324,["812"] = 1,["814"] = 1327,["815"] = 1328,["816"] = 1,["818"] = 1331,["819"] = 1332,["820"] = 1,["822"] = 1335,["823"] = 1336,["825"] = 1,["826"] = 1341,["827"] = 1312});
formSpec = formSpec or ({})
do
    local create = vector.create2d
    function formSpec.sVec(input)
        return (tostring(input.x) .. ",") .. tostring(input.y)
    end
    --- Convert an array into a single string representation.
    -- 
    -- @param input Array of strings.
    -- @returns Array as single string concatenated with ","
    function formSpec.arrayToString(input)
        local temp = ""
        local index = 0
        for ____, value in ipairs(input) do
            if index ~= 0 then
                temp = temp .. ","
            end
            temp = temp .. value
            index = index + 1
        end
        return temp
    end
    formSpec.FormSpec = __TS__Class()
    local FormSpec = formSpec.FormSpec
    FormSpec.name = "FormSpec"
    function FormSpec.prototype.____constructor(self, definition)
        self.size = definition.size
        self.fixedSize = definition.fixedSize
        self.position = definition.position
        self.anchor = definition.anchor
        self.padding = definition.padding
        self.disablePrepend = definition.disablePrepend
        self.elements = definition.elements
    end
    function FormSpec.prototype.attachElement(self, newElement)
        local ____self_elements_0 = self.elements
        ____self_elements_0[#____self_elements_0 + 1] = newElement
        return self
    end
    formSpec.Container = __TS__Class()
    local Container = formSpec.Container
    Container.name = "Container"
    function Container.prototype.____constructor(self, definition)
        do
            self.position = definition.position
            self.elements = definition.elements
        end
    end
    function Container.prototype.attachElement(self, newElement)
        local ____self_elements_1 = self.elements
        ____self_elements_1[#____self_elements_1 + 1] = newElement
        return self
    end
    local ScrollOrientation = ScrollOrientation or ({})
    ScrollOrientation.vertical = "vertical"
    ScrollOrientation.horizontal = "horizontal"
    formSpec.ScrollContainer = __TS__Class()
    local ScrollContainer = formSpec.ScrollContainer
    ScrollContainer.name = "ScrollContainer"
    __TS__ClassExtends(ScrollContainer, formSpec.Container)
    function ScrollContainer.prototype.____constructor(self, definition)
        ScrollContainer.____super.prototype.____constructor(self, {position = definition.position, elements = definition.elements})
        self.size = definition.size
        self.orientation = definition.orientation
        self.factor = definition.factor or 0.1
        self.name = definition.name
    end
    formSpec.List = __TS__Class()
    local List = formSpec.List
    List.name = "List"
    function List.prototype.____constructor(self, definition)
        self.location = definition.location
        self.listName = definition.listName
        self.position = definition.position
        self.size = definition.size
        self.startingIndex = definition.startingIndex
    end
    formSpec.ListRing = __TS__Class()
    local ListRing = formSpec.ListRing
    ListRing.name = "ListRing"
    function ListRing.prototype.____constructor(self, definition)
        self.location = definition.location
        self.listName = definition.listName
    end
    formSpec.ListColors = __TS__Class()
    local ListColors = formSpec.ListColors
    ListColors.name = "ListColors"
    function ListColors.prototype.____constructor(self, definition)
        self.slotBGNormal = definition.slotBGNormal
        self.slotBGHover = definition.slotBGHover
        self.slotBorder = definition.slotBorder
        self.toolTipBGColor = definition.toolTipBGColor
        self.toolTipFontColor = definition.toolTipFontColor
    end
    formSpec.ElementToolTip = __TS__Class()
    local ElementToolTip = formSpec.ElementToolTip
    ElementToolTip.name = "ElementToolTip"
    function ElementToolTip.prototype.____constructor(self, definition)
        self.guiElementName = definition.guiElementName
        self.text = definition.text
        self.bgColor = definition.bgColor
        self.fontColor = definition.fontColor
    end
    formSpec.AreaToolTip = __TS__Class()
    local AreaToolTip = formSpec.AreaToolTip
    AreaToolTip.name = "AreaToolTip"
    function AreaToolTip.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.text = definition.text
        self.bgColor = definition.bgColor
        self.fontColor = definition.fontColor
    end
    formSpec.Image = __TS__Class()
    local Image = formSpec.Image
    Image.name = "Image"
    function Image.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.texture = definition.texture
        self.middle = definition.middle
    end
    formSpec.AnimatedImage = __TS__Class()
    local AnimatedImage = formSpec.AnimatedImage
    AnimatedImage.name = "AnimatedImage"
    __TS__ClassExtends(AnimatedImage, formSpec.Image)
    function AnimatedImage.prototype.____constructor(self, definition)
        AnimatedImage.____super.prototype.____constructor(self, definition)
        self.name = definition.name
        self.frameCount = definition.frameCount
        self.frameDuration = definition.frameDuration
        self.frameStart = definition.frameStart
    end
    formSpec.Model = __TS__Class()
    local Model = formSpec.Model
    Model.name = "Model"
    function Model.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.mesh = definition.mesh
        self.textures = definition.textures
        self.rotation = definition.rotation
        self.continuous = definition.continuous
        self.mouseControl = definition.mouseControl
        self.frameLoopRange = definition.frameLoopRange
        self.animationSpeed = definition.animationSpeed
    end
    formSpec.BGColor = __TS__Class()
    local BGColor = formSpec.BGColor
    BGColor.name = "BGColor"
    function BGColor.prototype.____constructor(self, definition)
        self.bgColor = definition.bgColor
        self.fullScreen = definition.fullScreen
        self.fullScreenbgColor = definition.fullScreenbgColor
    end
    formSpec.Background = __TS__Class()
    local Background = formSpec.Background
    Background.name = "Background"
    function Background.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.texture = definition.texture
        self.autoclip = definition.autoClip
        self.middle = definition.middle
    end
    formSpec.PasswordField = __TS__Class()
    local PasswordField = formSpec.PasswordField
    PasswordField.name = "PasswordField"
    function PasswordField.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
    end
    formSpec.Field = __TS__Class()
    local Field = formSpec.Field
    Field.name = "Field"
    function Field.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
        self.default = definition.default
    end
    formSpec.FieldEnterAfterEdit = __TS__Class()
    local FieldEnterAfterEdit = formSpec.FieldEnterAfterEdit
    FieldEnterAfterEdit.name = "FieldEnterAfterEdit"
    function FieldEnterAfterEdit.prototype.____constructor(self, name)
        self.name = name
    end
    formSpec.FieldCloseOnEnter = __TS__Class()
    local FieldCloseOnEnter = formSpec.FieldCloseOnEnter
    FieldCloseOnEnter.name = "FieldCloseOnEnter"
    function FieldCloseOnEnter.prototype.____constructor(self, name)
        self.name = name
    end
    formSpec.TextArea = __TS__Class()
    local TextArea = formSpec.TextArea
    TextArea.name = "TextArea"
    function TextArea.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
        self.default = definition.default
    end
    formSpec.Label = __TS__Class()
    local Label = formSpec.Label
    Label.name = "Label"
    function Label.prototype.____constructor(self, definition)
        self.position = definition.position
        self.label = definition.label
    end
    formSpec.HyperText = __TS__Class()
    local HyperText = formSpec.HyperText
    HyperText.name = "HyperText"
    function HyperText.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.text = definition.text
    end
    formSpec.VertLabel = __TS__Class()
    local VertLabel = formSpec.VertLabel
    VertLabel.name = "VertLabel"
    function VertLabel.prototype.____constructor(self, definition)
        self.position = definition.position
        self.label = definition.label
    end
    formSpec.Button = __TS__Class()
    local Button = formSpec.Button
    Button.name = "Button"
    function Button.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
    end
    formSpec.ImageButton = __TS__Class()
    local ImageButton = formSpec.ImageButton
    ImageButton.name = "ImageButton"
    __TS__ClassExtends(ImageButton, formSpec.Button)
    function ImageButton.prototype.____constructor(self, definition)
        ImageButton.____super.prototype.____constructor(self, definition)
        self.texture = definition.texture
    end
    formSpec.ImageButtonAdvanced = __TS__Class()
    local ImageButtonAdvanced = formSpec.ImageButtonAdvanced
    ImageButtonAdvanced.name = "ImageButtonAdvanced"
    __TS__ClassExtends(ImageButtonAdvanced, formSpec.ImageButton)
    function ImageButtonAdvanced.prototype.____constructor(self, definition)
        ImageButtonAdvanced.____super.prototype.____constructor(self, definition)
        self.noClip = definition.noClip
        self.drawBorder = definition.drawBorder
        self.pressedTexture = definition.pressedTexture
    end
    formSpec.ItemImageButton = __TS__Class()
    local ItemImageButton = formSpec.ItemImageButton
    ItemImageButton.name = "ItemImageButton"
    function ItemImageButton.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.itemName = definition.itemName
        self.name = definition.name
        self.label = definition.label
    end
    formSpec.ButtonExit = __TS__Class()
    local ButtonExit = formSpec.ButtonExit
    ButtonExit.name = "ButtonExit"
    __TS__ClassExtends(ButtonExit, formSpec.Button)
    function ButtonExit.prototype.____constructor(self, ...)
        ButtonExit.____super.prototype.____constructor(self, ...)
        self.buttonExit = false
    end
    formSpec.ImageButtonExit = __TS__Class()
    local ImageButtonExit = formSpec.ImageButtonExit
    ImageButtonExit.name = "ImageButtonExit"
    __TS__ClassExtends(ImageButtonExit, formSpec.ImageButton)
    function ImageButtonExit.prototype.____constructor(self, ...)
        ImageButtonExit.____super.prototype.____constructor(self, ...)
        self.imageButtonExit = false
    end
    formSpec.TextList = __TS__Class()
    local TextList = formSpec.TextList
    TextList.name = "TextList"
    function TextList.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.items = definition.items
        self.selectedIndex = definition.selectedIndex
        self.transparent = definition.transparent
    end
    formSpec.TabHeader = __TS__Class()
    local TabHeader = formSpec.TabHeader
    TabHeader.name = "TabHeader"
    function TabHeader.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.captions = definition.captions
        self.currentTab = definition.currentTab
        self.transparent = definition.transparent
        self.drawBorder = definition.drawBorder
    end
    formSpec.Box = __TS__Class()
    local Box = formSpec.Box
    Box.name = "Box"
    function Box.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.color = definition.color
    end
    formSpec.DropDown = __TS__Class()
    local DropDown = formSpec.DropDown
    DropDown.name = "DropDown"
    function DropDown.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.items = definition.items
        self.selectedIndex = definition.selectedIndex
        self.indexEvent = definition.indexEvent
    end
    formSpec.CheckBox = __TS__Class()
    local CheckBox = formSpec.CheckBox
    CheckBox.name = "CheckBox"
    function CheckBox.prototype.____constructor(self, definition)
        self.position = definition.position
        self.name = definition.name
        self.label = definition.label
        self.selected = definition.selected
    end
    formSpec.ScrollBar = __TS__Class()
    local ScrollBar = formSpec.ScrollBar
    ScrollBar.name = "ScrollBar"
    function ScrollBar.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.orientation = definition.orientation
        self.name = definition.name
        self.value = definition.value
    end
    formSpec.ScrollBarOptions = __TS__Class()
    local ScrollBarOptions = formSpec.ScrollBarOptions
    ScrollBarOptions.name = "ScrollBarOptions"
    function ScrollBarOptions.prototype.____constructor(self, options)
        self.scrollBarOptions = options
    end
    formSpec.Table = __TS__Class()
    local Table = formSpec.Table
    Table.name = "Table"
    function Table.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.cells = definition.cells
        self.selectedIndex = definition.selectedIndex
    end
    formSpec.TableOptions = __TS__Class()
    local TableOptions = formSpec.TableOptions
    TableOptions.name = "TableOptions"
    function TableOptions.prototype.____constructor(self, options)
        self.tableOptions = options
    end
    formSpec.TableColumns = __TS__Class()
    local TableColumns = formSpec.TableColumns
    TableColumns.name = "TableColumns"
    function TableColumns.prototype.____constructor(self, columns)
        self.tableColumns = columns
    end
    formSpec.Style = __TS__Class()
    local Style = formSpec.Style
    Style.name = "Style"
    function Style.prototype.____constructor(self, styleThings)
        self.styleThings = styleThings
    end
    formSpec.StyleType = __TS__Class()
    local StyleType = formSpec.StyleType
    StyleType.name = "StyleType"
    function StyleType.prototype.____constructor(self, styleTypes)
        self.styleTypes = styleTypes
    end
    formSpec.SetFocus = __TS__Class()
    local SetFocus = formSpec.SetFocus
    SetFocus.name = "SetFocus"
    function SetFocus.prototype.____constructor(self, definition)
        self.name = definition.name
        self.force = definition.force
    end
    function formSpec.processElements(accumulator, elementArray)
        for ____, element in ipairs(elementArray) do
            if __TS__InstanceOf(element, formSpec.Container) then
                local pos = element.position
                accumulator = accumulator .. ("container[" .. formSpec.sVec(pos)) .. "]\n"
                accumulator = accumulator .. "container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.ScrollContainer) then
                local pos = element.position
                local size = element.size
                accumulator = accumulator .. ((((((((("scroll_container[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. element.name) .. ";") .. element.orientation) .. ";") .. tostring(element.factor)) .. "]\n"
                accumulator = accumulator .. "scroll_container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.List) then
                local location = element.location
                local listName = element.listName
                local pos = element.position
                local size = element.size
                local startingIndex = element.startingIndex
                accumulator = accumulator .. ((((((((("list[" .. location) .. ";") .. listName) .. ";") .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. tostring(startingIndex)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ListRing) then
                local location = element.location
                local listName = element.listName
                accumulator = accumulator .. ((("listring[" .. location) .. ";") .. listName) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ListColors) then
                local slotBGNormal = element.slotBGNormal
                local slotBGHover = element.slotBGHover
                accumulator = accumulator .. (("listcolors[" .. slotBGNormal) .. ";") .. slotBGHover
                local slotBorder = element.slotBorder
                if slotBorder then
                    accumulator = accumulator .. ";" .. slotBorder
                    local toolTipBGColor = element.toolTipBGColor
                    local toolTipFontColor = element.toolTipFontColor
                    if toolTipBGColor and toolTipFontColor then
                        accumulator = accumulator .. ((";" .. toolTipBGColor) .. ";") .. toolTipFontColor
                    end
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ElementToolTip) then
                local guiElementName = element.guiElementName
                local text = element.text
                local bgColor = element.bgColor
                local fontColor = element.fontColor
                accumulator = accumulator .. ((((((("tooltip[" .. guiElementName) .. ";") .. text) .. ";") .. bgColor) .. ";") .. fontColor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.AreaToolTip) then
                local pos = element.position
                local size = element.size
                local text = element.text
                local bgcolor = element.bgColor
                local fontcolor = element.fontColor
                accumulator = accumulator .. ((((((((("tooltip[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. text) .. ";") .. bgcolor) .. ";") .. fontcolor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Image) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local middle = element.middle
                accumulator = accumulator .. (((("image[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. texture
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.AnimatedImage) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local name = element.name
                local frameCount = element.frameCount
                local frameDuration = element.frameDuration
                local frameStart = element.frameStart
                local middle = element.middle
                accumulator = accumulator .. (((((((((((("animated_image[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. texture) .. ";") .. tostring(frameCount)) .. ";") .. tostring(frameDuration)) .. ";") .. tostring(frameStart)
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Model) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local mesh = element.mesh
                local textures = formSpec.arrayToString(element.textures)
                local rotation = element.rotation
                local continuous = element.continuous
                local mouseControl = element.mouseControl
                local frameLoopRange = element.frameLoopRange
                local animationSpeed = element.animationSpeed
                accumulator = accumulator .. ((((((((((((((((((("model[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. mesh) .. ";") .. textures) .. ";") .. formSpec.sVec(rotation)) .. ";") .. tostring(continuous)) .. ";") .. tostring(mouseControl)) .. ";") .. formSpec.sVec(frameLoopRange)) .. ";") .. tostring(animationSpeed)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.BGColor) then
                local bgcolor = element.bgColor
                local fullScreen = element.fullScreen
                local fullScreenbgColor = element.fullScreenbgColor
                accumulator = accumulator .. ((((("bgcolor[" .. bgcolor) .. ";") .. tostring(fullScreen)) .. ";") .. fullScreenbgColor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Background) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local ____temp_2
                if element.autoclip then
                    ____temp_2 = true
                else
                    ____temp_2 = false
                end
                local autoClip = ____temp_2
                local middle = element.middle
                if middle then
                    accumulator = accumulator .. "background9["
                else
                    accumulator = accumulator .. "background["
                end
                accumulator = accumulator .. (((((formSpec.sVec(pos) .. ";") .. formSpec.sVec(size)) .. ";") .. texture) .. ";") .. tostring(autoClip)
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.PasswordField) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((("pwdfield[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Field) then
                local pos = element.position
                local size = element.size
                accumulator = accumulator .. "field["
                if pos and size then
                    accumulator = accumulator .. ((formSpec.sVec(pos) .. ";") .. formSpec.sVec(size)) .. ";"
                end
                local name = element.name
                local label = element.label
                local def = element.default
                accumulator = accumulator .. ((((name .. ";") .. label) .. ";") .. def) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.FieldEnterAfterEdit) then
                local name = element.name
                accumulator = accumulator .. ((("field_enter_after_edit[" .. name) .. ";") .. tostring(true)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.FieldCloseOnEnter) then
                local name = element.name
                accumulator = accumulator .. ((("field_close_on_enter[" .. name) .. ";") .. tostring(true)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TextArea) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                local def = element.default
                accumulator = accumulator .. ((((((((("textarea[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. label) .. ";") .. def) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Label) then
                local pos = element.position
                local label = element.label
                accumulator = accumulator .. ((("label[" .. formSpec.sVec(pos)) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.HyperText) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local text = element.text
                accumulator = accumulator .. ((((((("hypertext[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. text) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.VertLabel) then
                local pos = element.position
                local label = element.label
                accumulator = accumulator .. ((("vertlabel[" .. formSpec.sVec(pos)) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Button) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((("button[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ImageButton) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((((("button[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. texture) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ImageButtonAdvanced) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local name = element.name
                local label = element.label
                local noClip = element.noClip
                local drawBorder = element.drawBorder
                local pressedTexture = element.pressedTexture
                accumulator = accumulator .. ((((((((((((((("button[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. texture) .. ";") .. name) .. ";") .. label) .. ";") .. tostring(noClip)) .. ";") .. tostring(drawBorder)) .. ";") .. pressedTexture) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ItemImageButton) then
                local pos = element.position
                local size = element.size
                local itemName = element.itemName
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((((("item_image_button[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. itemName) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ButtonExit) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((("button_exit[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TextList) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local listOfItems = formSpec.arrayToString(element.items)
                local selectedIndex = element.selectedIndex
                local transparent = element.transparent
                accumulator = accumulator .. ((((((((((("textlist[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. listOfItems) .. ";") .. tostring(selectedIndex)) .. ";") .. tostring(transparent)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TabHeader) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local listOfCaptions = formSpec.arrayToString(element.captions)
                local currentTab = element.currentTab
                local transparent = element.transparent
                local drawBorder = element.drawBorder
                accumulator = accumulator .. ((((((((((((("tabheader[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. listOfCaptions) .. ";") .. tostring(currentTab)) .. ";") .. tostring(transparent)) .. ";") .. tostring(drawBorder)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Box) then
                local pos = element.position
                local size = element.size
                local color = element.color
                accumulator = accumulator .. ((((("box[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. color) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.DropDown) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local itemList = formSpec.arrayToString(element.items)
                local selectedIndex = element.selectedIndex
                local indexEvent = element.indexEvent
                accumulator = accumulator .. ((((((((((("dropdown[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. itemList) .. ";") .. tostring(selectedIndex)) .. ";") .. tostring(indexEvent)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.CheckBox) then
                local pos = element.position
                local name = element.name
                local label = element.label
                local selected = element.selected
                accumulator = accumulator .. ((((((("checkbox[" .. formSpec.sVec(pos)) .. ";") .. name) .. ";") .. label) .. ";") .. tostring(selected)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ScrollBar) then
                local pos = element.position
                local size = element.size
                local orientation = element.orientation
                local name = element.name
                local value = element.value
                accumulator = accumulator .. ((((((((("scrollbar[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. orientation) .. ";") .. name) .. ";") .. value) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ScrollBarOptions) then
                local options = formSpec.arrayToString(element.scrollBarOptions)
                accumulator = accumulator .. ("scrollbaroptions[" .. options) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Table) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local cellList = formSpec.arrayToString(element.cells)
                local selectedIndex = element.selectedIndex
                accumulator = accumulator .. ((((((((("table[" .. formSpec.sVec(pos)) .. ";") .. formSpec.sVec(size)) .. ";") .. name) .. ";") .. cellList) .. ";") .. tostring(selectedIndex)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TableOptions) then
                local options = formSpec.arrayToString(element.tableOptions)
                accumulator = accumulator .. ("tableoptions[" .. options) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TableColumns) then
                local columns = formSpec.arrayToString(element.tableColumns)
                accumulator = accumulator .. ("tablecolumns[" .. columns) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Style) then
                local styleThings = formSpec.arrayToString(element.styleThings)
                accumulator = accumulator .. ("style[" .. styleThings) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.StyleType) then
                local styleTypes = formSpec.arrayToString(element.styleTypes)
                accumulator = accumulator .. ("style_type[" .. styleTypes) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.SetFocus) then
                local name = element.name
                local force = element.force
                accumulator = accumulator .. ((("set_focus[" .. name) .. ";") .. tostring(force)) .. "]\n"
            end
        end
        return accumulator
    end
    function formSpec.generate(d)
        local accumulator = "formspec_version[7]\n"
        if d.size then
            local ____temp_3
            if d.fixedSize then
                ____temp_3 = true
            else
                ____temp_3 = false
            end
            local fixed = ____temp_3
            local size = d.size
            accumulator = accumulator .. ((("size[" .. formSpec.sVec(size)) .. ",") .. tostring(fixed)) .. "]\n"
        end
        if d.position then
            local pos = d.position
            accumulator = accumulator .. ("position[" .. formSpec.sVec(pos)) .. "]\n"
        end
        if d.anchor then
            local anchor = d.anchor
            accumulator = accumulator .. ("anchor[" .. formSpec.sVec(anchor)) .. "]\n"
        end
        if d.padding then
            local p = d.padding
            accumulator = accumulator .. ("padding[" .. formSpec.sVec(p)) .. "]\n"
        end
        if d.disablePrepend then
            accumulator = accumulator .. "no_prepend[]\n"
        end
        accumulator = formSpec.processElements(accumulator, d.elements)
        return accumulator
    end
end
