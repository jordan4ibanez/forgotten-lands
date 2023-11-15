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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 1,["75"] = 4,["76"] = 5,["78"] = 7,["79"] = 8,["80"] = 9,["81"] = 10,["82"] = 11,["83"] = 3,["84"] = 1,["85"] = 15,["86"] = 16,["88"] = 18,["89"] = 19,["90"] = 20,["91"] = 21,["92"] = 22,["93"] = 14,["94"] = 1,["95"] = 26,["96"] = 27,["98"] = 29,["99"] = 30,["100"] = 31,["101"] = 32,["102"] = 33,["103"] = 25,["104"] = 1,["105"] = 37,["106"] = 38,["108"] = 40,["109"] = 41,["110"] = 42,["111"] = 43,["112"] = 44,["113"] = 36,["114"] = 1,["115"] = 48,["116"] = 49,["118"] = 51,["119"] = 52,["120"] = 53,["121"] = 54,["122"] = 55,["123"] = 47,["124"] = 1,["125"] = 59,["126"] = 60,["128"] = 62,["129"] = 63,["130"] = 64,["131"] = 65,["132"] = 66,["133"] = 58,["134"] = 1,["135"] = 70,["136"] = 71,["138"] = 73,["139"] = 74,["140"] = 75,["141"] = 76,["142"] = 77,["143"] = 69,["144"] = 1,["145"] = 81,["146"] = 82,["148"] = 84,["149"] = 85,["150"] = 86,["151"] = 87,["152"] = 88,["153"] = 80,["154"] = 1,["155"] = 92,["156"] = 93,["158"] = 95,["159"] = 96,["160"] = 97,["161"] = 98,["162"] = 99,["163"] = 91,["164"] = 103,["165"] = 103,["166"] = 103,["167"] = 103,["168"] = 103,["169"] = 103,["170"] = 103,["171"] = 103,["172"] = 103,["173"] = 103,["174"] = 103,["175"] = 103,["176"] = 103,["177"] = 103,["178"] = 103,["179"] = 103,["180"] = 103,["181"] = 103,["182"] = 103,["183"] = 103,["184"] = 103,["185"] = 103,["186"] = 103,["187"] = 103,["188"] = 103,["189"] = 103,["190"] = 103,["191"] = 103,["192"] = 103,["193"] = 103,["194"] = 103,["195"] = 103,["196"] = 103,["197"] = 103,["198"] = 103,["199"] = 103,["200"] = 103,["201"] = 103,["202"] = 103,["203"] = 103,["204"] = 103,["205"] = 103,["206"] = 103,["207"] = 103,["208"] = 103,["209"] = 103,["210"] = 103,["211"] = 103,["212"] = 103,["213"] = 103,["214"] = 103,["215"] = 103,["216"] = 103,["217"] = 103,["218"] = 103,["219"] = 103});
Sounds = Sounds or ({})
do
    function Sounds.grass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "grass_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "grass_dig", gain = 1.5})
        spec.dug = spec.dug or ({name = "grass_dug", gain = 0.8})
        spec.place = spec.place or ({name = "grass_dug", gain = 0.5})
        return spec
    end
    function Sounds.dirt(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 0.9})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function Sounds.wood(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wood_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "wood_dig", gain = 0.7})
        spec.dug = spec.dug or ({name = "wood_dug", gain = 1})
        spec.place = spec.place or ({name = "wood_dug", gain = 0.6})
        return spec
    end
    function Sounds.gravel(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "gravel_dug", gain = 0.9})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function Sounds.stone(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "stone_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "stone_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "stone_dug", gain = 1})
        spec.place = spec.place or ({name = "stone_dug", gain = 0.8})
        return spec
    end
    function Sounds.sand(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "sand_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "sand_dug", gain = 1})
        spec.place = spec.place or ({name = "sand_dug", gain = 0.8})
        return spec
    end
    function Sounds.plant(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 1})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.8})
        return spec
    end
    function Sounds.glass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "glass_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "glass_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "glass_dug", gain = 1})
        spec.place = spec.place or ({name = "glass_step", gain = 0.8})
        return spec
    end
    function Sounds.wool(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wool_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "wool_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "wool_dug", gain = 1})
        spec.place = spec.place or ({name = "wool_dug", gain = 0.8})
        return spec
    end
    print(
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| Sounds loaded.                                                          |\n",
        "| Credits:                                                                |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| grass                                                                   |\n",
        "| - step                                                                  |\n",
        "| (1-6) - https://freesound.org/people/RavenWolfProds/sounds/503659/ CC0  |\n",
        "| - dig                                                                   |\n",
        "| (1-4) - https://freesound.org/people/drowsyprincess/sounds/463854/ CC0  |\n",
        "| - dug/place                                                             |\n",
        "| (1-5) - https://freesound.org/people/Adielees9/sounds/331167/ CC0       |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| dirt                                                                    |\n",
        "| - step                                                                  |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/543806/ CC0       |\n",
        "| - dig                                                                   |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0       |\n",
        "| - dug                                                                   |\n",
        "| (1-5) - https://freesound.org/people/Joao_Janz/sounds/571954/ CC0       |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| stone                                                                   |\n",
        "| - step                                                                  |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
        "| - dig                                                                   |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
        "| - dug                                                                   |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| gravel                                                                  |\n",
        "| - dug                                                                   |\n",
        "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0       |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| sand                                                                    |\n",
        "| - dug                                                                   |\n",
        "| (1-6) - https://freesound.org/people/Rach_Capache/sounds/366431/        |\n",
        "| CC BY 3.0 NONCOMMERCIAL                                                 |\n",
        "| - dig                                                                   |\n",
        "| (1-6) - https://freesound.org/people/savataivanov/sounds/384082/ CC0    |\n",
        "| - step                                                                  |\n",
        "| (1-6) - https://freesound.org/people/pan14/sounds/388289/ CC0           |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| wood                                                                    |\n",
        "| - step                                                                  |\n",
        "| (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0 |\n",
        "| - dig                                                                   |\n",
        "| (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0 |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
        "| glass                                                                   |\n",
        "| - dug                                                                   |\n",
        "| 1 - https://freesound.org/people/awholenewlife1/sounds/422240/ CC0      |\n",
        "| 2 - https://freesound.org/people/RoganMcDougald/sounds/260434/          |\n",
        "| CC BY 3.0                                                               |\n",
        "| 3 - https://freesound.org/people/Tomlija/sounds/97669/ CC BY 3.0        |\n",
        "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
    )
end
