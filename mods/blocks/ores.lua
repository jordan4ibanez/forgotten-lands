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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 2,["74"] = 3,["75"] = 4,["76"] = 5,["77"] = 7,["78"] = 8,["79"] = 7,["80"] = 11,["81"] = 11,["82"] = 11,["83"] = 11,["84"] = 11,["85"] = 11,["86"] = 11,["87"] = 18,["88"] = 20,["89"] = 20,["90"] = 11,["91"] = 11,["92"] = 11,["93"] = 30,["94"] = 30,["95"] = 30,["96"] = 30,["97"] = 30,["98"] = 30,["99"] = 30,["100"] = 37,["101"] = 39,["102"] = 39,["103"] = 30,["104"] = 30,["105"] = 30,["106"] = 49,["107"] = 49,["108"] = 49,["109"] = 49,["110"] = 49,["111"] = 49,["112"] = 49,["113"] = 56,["114"] = 58,["115"] = 58,["116"] = 49,["117"] = 49,["118"] = 49,["119"] = 68,["120"] = 68,["121"] = 68,["122"] = 68,["123"] = 68,["124"] = 68,["125"] = 68,["126"] = 75,["127"] = 77,["128"] = 77,["129"] = 68,["130"] = 68,["131"] = 68,["132"] = 87,["133"] = 87,["134"] = 87,["135"] = 87,["136"] = 87,["137"] = 87,["138"] = 87,["139"] = 94,["140"] = 96,["141"] = 96,["142"] = 87,["143"] = 87,["144"] = 87});
blocks = blocks or ({})
do
    local generateDropRequirements = tools.generateDropRequirements
    local ToolType = types.ToolType
    local blockType = types.BlockType
    local function oreIt(oreTexture)
        return {"default_stone.png^" .. oreTexture}
    end
    utility.registerNode(
        "coal_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_coal.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 1}),
                items = {"coal"}
            }}}
        }
    )
    utility.registerNode(
        "iron_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_iron.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 2},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 2}),
                items = {"iron_ore"}
            }}}
        }
    )
    utility.registerNode(
        "gold_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_gold.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 2},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 2}),
                items = {"gold_ore"}
            }}}
        }
    )
    utility.registerNode(
        "diamond_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_diamond.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 3},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 3}),
                items = {"diamond"}
            }}}
        }
    )
    utility.registerNode(
        "mese_ore",
        {
            drawtype = Drawtype.normal,
            tiles = oreIt("default_mineral_mese.png"),
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 4},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 4}),
                items = {"mese"}
            }}}
        }
    )
end
