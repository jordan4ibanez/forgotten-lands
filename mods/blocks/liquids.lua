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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 2,["75"] = 4,["76"] = 4,["77"] = 4,["78"] = 4,["79"] = 4,["80"] = 4,["81"] = 4,["82"] = 4,["83"] = 4,["84"] = 4,["85"] = 4,["86"] = 4,["87"] = 4,["88"] = 4,["89"] = 4,["90"] = 4,["91"] = 4,["92"] = 4,["93"] = 4,["94"] = 4,["95"] = 4,["96"] = 4,["97"] = 46,["98"] = 46,["99"] = 46,["100"] = 46,["101"] = 46,["102"] = 46,["103"] = 46,["104"] = 46,["105"] = 46,["106"] = 46,["107"] = 46,["108"] = 46,["109"] = 46,["110"] = 46,["111"] = 46,["112"] = 46,["113"] = 46,["114"] = 46,["115"] = 46,["116"] = 46,["117"] = 46,["118"] = 46,["119"] = 46});
blocks = blocks or ({})
do
    local registerNode = utility.registerNode
    registerNode("waterSource", {
        description = "Water",
        drawtype = Drawtype.liquid,
        waving = 3,
        tiles = {{name = "default_water_source_animated.png", backface_culling = false, animation = {type = TileAnimationType.vertical_frames, aspect_w = 16, aspect_h = 16, length = 2}}, {name = "default_water_source_animated.png", backface_culling = true, animation = {type = TileAnimationType.vertical_frames, aspect_w = 16, aspect_h = 16, length = 2}}},
        use_texture_alpha = TextureAlpha.blend,
        paramtype = ParamType1.light,
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        drop = "",
        drowning = 1,
        liquidtype = LiquidType.source,
        liquid_alternative_flowing = "waterFlowing",
        liquid_alternative_source = "waterSource",
        liquid_viscosity = 1,
        post_effect_color = {a = 103, r = 30, g = 60, b = 90},
        groups = {water = 3, liquid = 3, coolsLava = 3},
        sounds = {}
    })
    registerNode("waterFlowing", {
        description = "Flowing water",
        drawtype = Drawtype.flowingliquid,
        waving = 3,
        tiles = {"default_water.png"},
        special_tiles = {{name = "default_water_flowing_animated.png", backface_culling = false, animation = {type = TileAnimationType.vertical_frames, aspect_w = 16, aspect_h = 16, length = 2}}, {name = "default_water_flowing_animated.png", backface_culling = true, animation = {type = TileAnimationType.vertical_frames, aspect_w = 16, aspect_h = 16, length = 2}}},
        use_texture_alpha = TextureAlpha.blend,
        paramtype = ParamType1.light,
        paramtype2 = ParamType2.flowingliquid,
        walkable = false,
        pointable = false,
        diggable = false,
        buildable_to = true,
        is_ground_content = false,
        drop = "",
        liquidtype = LiquidType.flowing,
        liquid_alternative_flowing = "waterFlowing",
        liquid_alternative_source = "waterSource",
        liquid_viscosity = 1,
        post_effect_color = {a = 103, r = 30, g = 60, b = 90},
        groups = {water = 3, liquid = 3},
        sounds = {}
    })
end
