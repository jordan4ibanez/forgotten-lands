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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 1,["75"] = 5,["76"] = 5,["77"] = 5,["78"] = 5,["79"] = 5,["80"] = 5,["81"] = 5,["82"] = 5,["83"] = 5,["84"] = 5,["85"] = 5,["86"] = 5,["87"] = 5,["88"] = 5,["89"] = 5,["90"] = 5,["91"] = 5,["92"] = 5,["93"] = 5,["94"] = 5,["95"] = 5,["96"] = 5,["97"] = 5,["98"] = 5,["99"] = 5,["100"] = 5,["101"] = 5,["102"] = 5,["103"] = 5,["104"] = 5,["105"] = 5,["106"] = 5,["107"] = 5,["108"] = 5,["109"] = 5,["110"] = 5,["111"] = 5,["112"] = 5,["113"] = 5,["114"] = 5,["115"] = 5,["116"] = 5,["117"] = 5,["118"] = 5,["119"] = 5,["120"] = 5,["121"] = 5,["122"] = 5,["123"] = 5,["124"] = 5,["125"] = 5,["126"] = 5,["127"] = 5,["128"] = 5,["129"] = 5,["130"] = 5,["131"] = 5,["132"] = 5,["133"] = 5,["134"] = 5,["135"] = 5,["136"] = 5,["137"] = 5,["138"] = 5,["139"] = 5,["140"] = 5,["141"] = 5,["142"] = 5,["143"] = 5,["144"] = 5,["145"] = 5,["146"] = 5,["147"] = 5,["148"] = 5,["149"] = 5,["150"] = 5,["151"] = 5,["152"] = 5,["153"] = 5,["154"] = 5,["155"] = 5,["156"] = 5,["157"] = 5,["158"] = 5,["159"] = 5,["160"] = 5,["161"] = 5,["162"] = 5,["163"] = 5,["164"] = 5,["165"] = 5,["166"] = 5,["167"] = 5,["168"] = 5,["169"] = 5,["170"] = 5,["171"] = 5,["172"] = 5,["173"] = 5,["174"] = 5,["175"] = 5,["176"] = 5,["177"] = 1,["178"] = 110,["179"] = 109,["184"] = 1,["185"] = 1,["186"] = 1,["187"] = 118,["188"] = 1,["189"] = 124,["190"] = 125,["191"] = 126,["192"] = 1,["195"] = 130,["196"] = 123,["204"] = 1,["205"] = 143,["206"] = 1,["207"] = 141,["208"] = 1,["209"] = 148,["210"] = 1,["212"] = 150,["213"] = 150,["214"] = 151,["215"] = 150,["218"] = 153,["219"] = 1,["221"] = 156,["222"] = 147});
utility = utility or ({})
do
    utility.hexValues = {
        [100] = "FF",
        [99] = "FC",
        [98] = "FA",
        [97] = "F7",
        [96] = "F5",
        [95] = "F2",
        [94] = "F0",
        [93] = "ED",
        [92] = "EB",
        [91] = "E8",
        [90] = "E6",
        [89] = "E3",
        [88] = "E0",
        [87] = "DE",
        [86] = "DB",
        [85] = "D9",
        [84] = "D6",
        [83] = "D4",
        [82] = "D1",
        [81] = "CF",
        [80] = "CC",
        [79] = "C9",
        [78] = "C7",
        [77] = "C4",
        [76] = "C2",
        [75] = "BF",
        [74] = "BD",
        [73] = "BA",
        [72] = "B8",
        [71] = "B5",
        [70] = "B3",
        [69] = "B0",
        [68] = "AD",
        [67] = "AB",
        [66] = "A8",
        [65] = "A6",
        [64] = "A3",
        [63] = "A1",
        [62] = "9E",
        [61] = "9C",
        [60] = "99",
        [59] = "96",
        [58] = "94",
        [57] = "91",
        [56] = "8F",
        [55] = "8C",
        [54] = "8A",
        [53] = "87",
        [52] = "85",
        [51] = "82",
        [50] = "80",
        [49] = "7D",
        [48] = "7A",
        [47] = "78",
        [46] = "75",
        [45] = "73",
        [44] = "70",
        [43] = "6E",
        [42] = "6B",
        [41] = "69",
        [40] = "66",
        [39] = "63",
        [38] = "61",
        [37] = "5E",
        [36] = "5C",
        [35] = "59",
        [34] = "57",
        [33] = "54",
        [32] = "52",
        [31] = "4F",
        [30] = "4D",
        [29] = "4A",
        [28] = "47",
        [27] = "45",
        [26] = "42",
        [25] = "40",
        [24] = "3D",
        [23] = "3B",
        [22] = "38",
        [21] = "36",
        [20] = "33",
        [19] = "30",
        [18] = "2E",
        [17] = "2B",
        [16] = "29",
        [15] = "26",
        [14] = "24",
        [13] = "21",
        [12] = "1F",
        [11] = "1C",
        [10] = "1A",
        [9] = "17",
        [8] = "14",
        [7] = "12",
        [6] = "0F",
        [5] = "0D",
        [4] = "0A",
        [3] = "08",
        [2] = "05",
        [1] = "03",
        [0] = "00"
    }
    function utility.lockChannel(input)
        return math.floor(math.clamp(0, 100, input))
    end
    --- Get the alpha level of a number. (Integers only)
    -- 
    -- @param input Integral percent. (0-100)
    -- @returns Alpha AA string to bolt onto a color hex.
    function utility.percentToAlphaHex(input)
        local clamped = utility.lockChannel(input)
        return utility.hexValues[clamped]
    end
    function utility.color(r, g, b, a)
        local newColor = "#"
        for ____, channel in ipairs({r, g, b, a}) do
            if channel then
                newColor = newColor .. utility.hexValues[utility.lockChannel(channel)]
            end
        end
        return newColor
    end
    --- Like the color() function, but can take in raw (0-255) rgba elements.
    -- 
    -- @param r Red channel. (0-255)
    -- @param g Green channel. (0-255)
    -- @param b Blue channel. (0-255)
    -- @param a Alpha channel. (0-255)
    -- @returns Color string in hex.
    function utility.colorRGB(r, g, b, a)
        a = a and a / 2.55 or a
        return utility.color(r / 2.55, g / 2.55, b / 2.55, a)
    end
    function utility.colorScalar(s, a)
        local newColor = "#"
        local hex = utility.hexValues[utility.lockChannel(s)]
        do
            local i = 0
            while i < 3 do
                newColor = newColor .. hex
                i = i + 1
            end
        end
        if a then
            newColor = newColor .. utility.hexValues[utility.lockChannel(a)]
        end
        return newColor
    end
end
