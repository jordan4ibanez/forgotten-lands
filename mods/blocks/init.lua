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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 2,["74"] = 3,["75"] = 4,["76"] = 5,["77"] = 7,["78"] = 7,["79"] = 7,["80"] = 7,["81"] = 7,["82"] = 7,["83"] = 7,["85"] = 16,["86"] = 16,["87"] = 18,["88"] = 20,["89"] = 21,["90"] = 21,["91"] = 21,["92"] = 21,["93"] = 21,["94"] = 21,["95"] = 21,["96"] = 26,["97"] = 26,["98"] = 26,["99"] = 26,["100"] = 26,["101"] = 26,["102"] = 26,["103"] = 26,["104"] = 26,["105"] = 26,["106"] = 26,["107"] = 26,["108"] = 26,["109"] = 26,["110"] = 26,["111"] = 26,["112"] = 26,["113"] = 16,["116"] = 51,["117"] = 51,["118"] = 51,["119"] = 51,["120"] = 51,["121"] = 51,["122"] = 51});
blocks = blocks or ({})
do
    local blockType = types.BlockType
    local pixel = utility.pixel
    local create = vector.create3d
    local grassSize = {
        [1] = create(3, 3, 13),
        [2] = create(3, 5, 13),
        [3] = create(3, 6, 13),
        [4] = create(2, 7, 14),
        [5] = create(2, 8, 14)
    }
    do
        local i = 1
        while i <= 5 do
            local size = grassSize[i]
            local collisionBox = {{
                pixel(size.x),
                pixel(0),
                pixel(size.x),
                pixel(size.z),
                pixel(size.y),
                pixel(size.z)
            }}
            utility.registerNode(
                "tall_grass_" .. tostring(i),
                {
                    drawtype = Drawtype.plantlike,
                    walkable = false,
                    waving = 1,
                    paramtype = ParamType1.light,
                    paramtype2 = ParamType2.degrotate,
                    tiles = {("default_grass_" .. tostring(i)) .. ".png"},
                    buildable_to = true,
                    sounds = sounds.plant(),
                    collision_box = {type = Nodeboxtype.fixed, fixed = collisionBox},
                    selection_box = {type = Nodeboxtype.fixed, fixed = collisionBox},
                    groups = {[blockType.break_instant] = 1, attached_node = 1},
                    drop = ""
                }
            )
            i = i + 1
        end
    end
    utility.loadFiles({
        "normal",
        "ores",
        "furnace",
        "workbench",
        "liquids"
    })
end
