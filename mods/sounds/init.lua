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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 3,["75"] = 1,["76"] = 6,["77"] = 7,["79"] = 9,["80"] = 10,["81"] = 11,["82"] = 12,["83"] = 13,["84"] = 5,["85"] = 1,["86"] = 17,["87"] = 18,["89"] = 20,["90"] = 21,["91"] = 22,["92"] = 23,["93"] = 24,["94"] = 16,["95"] = 1,["96"] = 28,["97"] = 29,["99"] = 31,["100"] = 32,["101"] = 33,["102"] = 34,["103"] = 35,["104"] = 27,["105"] = 1,["106"] = 39,["107"] = 40,["109"] = 42,["110"] = 43,["111"] = 44,["112"] = 45,["113"] = 46,["114"] = 38,["115"] = 1,["116"] = 50,["117"] = 51,["119"] = 53,["120"] = 54,["121"] = 55,["122"] = 56,["123"] = 57,["124"] = 49,["125"] = 1,["126"] = 61,["127"] = 62,["129"] = 64,["130"] = 65,["131"] = 66,["132"] = 67,["133"] = 68,["134"] = 60,["135"] = 1,["136"] = 72,["137"] = 73,["139"] = 75,["140"] = 76,["141"] = 77,["142"] = 78,["143"] = 79,["144"] = 71,["145"] = 1,["146"] = 83,["147"] = 84,["149"] = 86,["150"] = 87,["151"] = 88,["152"] = 89,["153"] = 90,["154"] = 82,["155"] = 1,["156"] = 94,["157"] = 95,["159"] = 97,["160"] = 98,["161"] = 99,["162"] = 100,["163"] = 101,["164"] = 93,["165"] = 104});
sounds = sounds or ({})
do
    local loadFiles = utility.loadFiles
    function sounds.grass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "grass_step", gain = 1})
        spec.dig = spec.dig or ({name = "grass_dig", gain = 1.5})
        spec.dug = spec.dug or ({name = "grass_dug", gain = 0.8})
        spec.placed = spec.placed or ({name = "grass_dug", gain = 0.5})
        return spec
    end
    function sounds.dirt(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 0.9})
        spec.placed = spec.placed or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function sounds.wood(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wood_step", gain = 0.35})
        spec.dig = spec.dig or ({name = "wood_dig", gain = 0.7})
        spec.dug = spec.dug or ({name = "wood_dug", gain = 1})
        spec.placed = spec.placed or ({name = "wood_dug", gain = 0.6})
        return spec
    end
    function sounds.gravel(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "gravel_dug", gain = 0.9})
        spec.placed = spec.placed or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function sounds.stone(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "stone_step", gain = 0.25})
        spec.dig = spec.dig or ({name = "stone_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "stone_dug", gain = 1})
        spec.placed = spec.placed or ({name = "stone_dug", gain = 0.8})
        return spec
    end
    function sounds.sand(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "sand_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "sand_dug", gain = 1})
        spec.placed = spec.placed or ({name = "sand_dug", gain = 0.8})
        return spec
    end
    function sounds.plant(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 1})
        spec.placed = spec.placed or ({name = "dirt_dug", gain = 0.8})
        return spec
    end
    function sounds.glass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "glass_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "glass_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "glass_dug", gain = 1})
        spec.placed = spec.placed or ({name = "glass_step", gain = 0.8})
        return spec
    end
    function sounds.wool(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wool_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "wool_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "wool_dug", gain = 1})
        spec.placed = spec.placed or ({name = "wool_dug", gain = 0.8})
        return spec
    end
    loadFiles({"place_sounds"})
end
