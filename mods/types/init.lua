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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 1,["75"] = 1,["76"] = 1,["77"] = 1,["78"] = 1,["79"] = 1,["80"] = 1,["81"] = 1,["82"] = 1,["83"] = 1,["84"] = 1,["85"] = 1,["86"] = 1,["87"] = 1,["88"] = 1,["89"] = 1,["90"] = 1,["91"] = 1,["92"] = 1,["93"] = 1,["94"] = 1,["95"] = 1,["96"] = 1,["97"] = 1,["98"] = 1,["99"] = 1,["100"] = 1,["101"] = 1,["102"] = 1,["103"] = 1});
types = types or ({})
do
    types.ToolType = ToolType or ({})
    types.ToolType.Pickaxe = "pickaxe"
    types.ToolType.Shovel = "shovel"
    types.ToolType.Axe = "axe"
    types.ToolType.Hoe = "hoe"
    types.ToolType.Sword = "sword"
    types.ToolType.Shears = "shears"
    types.BlockType = BlockType or ({})
    types.BlockType.break_instant = "break_instant"
    types.BlockType.soil = "soil"
    types.BlockType.wood = "wood"
    types.BlockType.leaf = "leaf"
    types.BlockType.stone = "stone"
    types.BlockType.metal = "metal"
    types.BlockType.glass = "glass"
    types.BlockType.wool = "wool"
    types.BlockType.planks = "planks"
    types.BlockType.tree = "tree"
    types.BlockType.sand = "sand"
    types.CraftingBlockType = CraftingBlockType or ({})
    types.CraftingBlockType.soil = "group:soil"
    types.CraftingBlockType.wood = "group:wood"
    types.CraftingBlockType.leaf = "group:leaf"
    types.CraftingBlockType.stone = "group:stone"
    types.CraftingBlockType.metal = "group:metal"
    types.CraftingBlockType.glass = "group:glass"
    types.CraftingBlockType.wool = "group:wool"
    types.CraftingBlockType.planks = "group:planks"
    types.CraftingBlockType.tree = "group:tree"
    types.CraftingBlockType.sand = "group:sand"
end
