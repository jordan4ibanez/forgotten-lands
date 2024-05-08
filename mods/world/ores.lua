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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 6,["75"] = 6,["76"] = 6,["77"] = 6,["78"] = 6,["79"] = 6,["80"] = 6,["81"] = 6,["82"] = 6,["83"] = 6,["84"] = 17,["85"] = 17,["86"] = 17,["87"] = 17,["88"] = 17,["89"] = 17,["90"] = 17,["91"] = 17,["92"] = 17,["93"] = 17,["94"] = 30,["95"] = 30,["96"] = 30,["97"] = 30,["98"] = 30,["99"] = 30,["100"] = 30,["101"] = 30,["102"] = 30,["103"] = 30,["104"] = 41,["105"] = 41,["106"] = 41,["107"] = 41,["108"] = 41,["109"] = 41,["110"] = 41,["111"] = 41,["112"] = 41,["113"] = 41,["114"] = 52,["115"] = 52,["116"] = 52,["117"] = 52,["118"] = 52,["119"] = 52,["120"] = 52,["121"] = 52,["122"] = 52,["123"] = 52,["124"] = 65,["125"] = 65,["126"] = 65,["127"] = 65,["128"] = 65,["129"] = 65,["130"] = 65,["131"] = 65,["132"] = 65,["133"] = 65,["134"] = 76,["135"] = 76,["136"] = 76,["137"] = 76,["138"] = 76,["139"] = 76,["140"] = 76,["141"] = 76,["142"] = 76,["143"] = 76,["144"] = 87,["145"] = 87,["146"] = 87,["147"] = 87,["148"] = 87,["149"] = 87,["150"] = 87,["151"] = 87,["152"] = 87,["153"] = 87,["154"] = 100,["155"] = 100,["156"] = 100,["157"] = 100,["158"] = 100,["159"] = 100,["160"] = 100,["161"] = 100,["162"] = 100,["163"] = 100,["164"] = 111,["165"] = 111,["166"] = 111,["167"] = 111,["168"] = 111,["169"] = 111,["170"] = 111,["171"] = 111,["172"] = 111,["173"] = 111,["174"] = 122,["175"] = 122,["176"] = 122,["177"] = 122,["178"] = 122,["179"] = 122,["180"] = 122,["181"] = 122,["182"] = 122,["183"] = 122,["184"] = 135,["185"] = 135,["186"] = 135,["187"] = 135,["188"] = 135,["189"] = 135,["190"] = 135,["191"] = 135,["192"] = 135,["193"] = 135,["194"] = 146,["195"] = 146,["196"] = 146,["197"] = 146,["198"] = 146,["199"] = 146,["200"] = 146,["201"] = 146,["202"] = 146,["203"] = 146,["204"] = 157,["205"] = 157,["206"] = 157,["207"] = 157,["208"] = 157,["209"] = 157,["210"] = 157,["211"] = 157,["212"] = 157,["213"] = 157});
world = world or ({})
do
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "coal_ore",
        wherein = "stone",
        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 8,
        clust_size = 3,
        y_max = 64,
        y_min = -127
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "coal_ore",
        wherein = "stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 30,
        clust_size = 5,
        y_max = -128,
        y_min = -31000
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "iron_ore",
        wherein = "stone",
        clust_scarcity = 9 * 9 * 9,
        clust_num_ores = 12,
        clust_size = 3,
        y_max = 31000,
        y_min = 1025
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "iron_ore",
        wherein = "stone",
        clust_scarcity = 7 * 7 * 7,
        clust_num_ores = 5,
        clust_size = 3,
        y_max = -128,
        y_min = -255
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "iron_ore",
        wherein = "stone",
        clust_scarcity = 12 * 12 * 12,
        clust_num_ores = 29,
        clust_size = 5,
        y_max = -256,
        y_min = -31000
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "gold_ore",
        wherein = "stone",
        clust_scarcity = 13 * 13 * 13,
        clust_num_ores = 5,
        clust_size = 3,
        y_max = 31000,
        y_min = 1025
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "gold_ore",
        wherein = "stone",
        clust_scarcity = 15 * 15 * 15,
        clust_num_ores = 3,
        clust_size = 2,
        y_max = -256,
        y_min = -511
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "gold_ore",
        wherein = "stone",
        clust_scarcity = 13 * 13 * 13,
        clust_num_ores = 5,
        clust_size = 3,
        y_max = -512,
        y_min = -31000
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "diamond_ore",
        wherein = "stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 5,
        clust_size = 3,
        y_max = 31000,
        y_min = 1025
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "diamond_ore",
        wherein = "stone",
        clust_scarcity = 18 * 18 * 18,
        clust_num_ores = 3,
        clust_size = 2,
        y_max = -512,
        y_min = -1023
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "diamond_ore",
        wherein = "stone",
        clust_scarcity = 14 * 14 * 14,
        clust_num_ores = 5,
        clust_size = 3,
        y_max = -1024,
        y_min = -31000
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "mese_ore",
        wherein = "stone",
        clust_scarcity = 15 * 15 * 15,
        clust_num_ores = 4,
        clust_size = 3,
        y_max = 31000,
        y_min = 1025
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "mese_ore",
        wherein = "stone",
        clust_scarcity = 17 * 17 * 17,
        clust_num_ores = 4,
        clust_size = 3,
        y_max = -1024,
        y_min = -2047
    })
    minetest.register_ore({
        ore_type = OreType.scatter,
        ore = "mese_ore",
        wherein = "stone",
        clust_scarcity = 15 * 15 * 15,
        clust_num_ores = 4,
        clust_size = 3,
        y_max = -2048,
        y_min = -31000
    })
end
