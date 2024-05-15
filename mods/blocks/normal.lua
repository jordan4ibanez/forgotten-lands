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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 2,["74"] = 3,["75"] = 4,["76"] = 5,["77"] = 7,["78"] = 7,["79"] = 7,["80"] = 7,["81"] = 7,["82"] = 7,["83"] = 7,["84"] = 15,["85"] = 17,["86"] = 17,["87"] = 7,["88"] = 7,["89"] = 7,["90"] = 27,["91"] = 27,["92"] = 27,["93"] = 27,["94"] = 27,["95"] = 27,["96"] = 27,["97"] = 27,["98"] = 27,["99"] = 36,["100"] = 36,["101"] = 36,["102"] = 36,["103"] = 36,["104"] = 36,["105"] = 36,["106"] = 36,["107"] = 36,["108"] = 45,["109"] = 45,["110"] = 45,["111"] = 45,["112"] = 45,["113"] = 45,["114"] = 45,["115"] = 45,["116"] = 45,["117"] = 45,["118"] = 59,["119"] = 59,["120"] = 59,["121"] = 59,["122"] = 59,["123"] = 59,["124"] = 59,["125"] = 59,["126"] = 59,["127"] = 68,["128"] = 68,["129"] = 68,["130"] = 68,["131"] = 68,["132"] = 68,["133"] = 68,["134"] = 68,["135"] = 68,["136"] = 77,["137"] = 77,["138"] = 77,["139"] = 77,["140"] = 77,["141"] = 77,["142"] = 77,["143"] = 77,["144"] = 77,["145"] = 91,["146"] = 91,["147"] = 91,["148"] = 91,["149"] = 91,["150"] = 91,["151"] = 91,["152"] = 91,["153"] = 91,["154"] = 100,["155"] = 102,["156"] = 102,["157"] = 91,["158"] = 91,["159"] = 91,["160"] = 112,["161"] = 112,["162"] = 112,["163"] = 112,["164"] = 112,["165"] = 112,["166"] = 112,["167"] = 112,["168"] = 112,["169"] = 126,["170"] = 126,["171"] = 126,["172"] = 126,["173"] = 126,["174"] = 126,["175"] = 126,["176"] = 126,["177"] = 126,["178"] = 126,["179"] = 126,["180"] = 126,["181"] = 126,["182"] = 126,["183"] = 126,["184"] = 126,["185"] = 126,["186"] = 144,["187"] = 145,["188"] = 145,["189"] = 145,["190"] = 145,["191"] = 145,["192"] = 145,["193"] = 145,["194"] = 145,["196"] = 154,["197"] = 154,["198"] = 154,["199"] = 154,["200"] = 154,["201"] = 154,["202"] = 154,["203"] = 154,["204"] = 154,["205"] = 154,["206"] = 154,["207"] = 154,["208"] = 154,["209"] = 154});
blocks = blocks or ({})
do
    local generateDropRequirements = tools.generateDropRequirements
    local ToolType = types.ToolType
    local blockType = types.BlockType
    utility.registerNode(
        "stone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_stone.png"},
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 1}),
                items = {"cobblestone"}
            }}}
        }
    )
    utility.registerNode(
        "cobblestone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_cobble.png"},
            sounds = sounds.stone(),
            groups = {[blockType.stone] = 1}
        }
    )
    utility.registerNode(
        "dirt",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_dirt.png"},
            sounds = sounds.dirt(),
            groups = {[blockType.soil] = 1}
        }
    )
    utility.registerNode(
        "grass",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
            sounds = sounds.grass(),
            groups = {[blockType.soil] = 1},
            drop = "dirt"
        }
    )
    utility.registerNode(
        "sand",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_sand.png"},
            sounds = sounds.sand(),
            groups = {[blockType.soil] = 1}
        }
    )
    utility.registerNode(
        "gravel",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_gravel.png"},
            sounds = sounds.gravel(),
            groups = {[blockType.soil] = 1}
        }
    )
    utility.registerNode(
        "oak_tree",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
            sounds = sounds.wood(),
            groups = {[blockType.wood] = 1, [blockType.tree] = 1}
        }
    )
    utility.registerNode(
        "oak_leaves",
        {
            drawtype = Drawtype.allfaces_optional,
            paramtype = ParamType1.light,
            waving = 1,
            tiles = {"default_leaves.png"},
            sounds = sounds.plant(),
            groups = {[blockType.leaf] = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Shears] = 1}),
                items = {"oak_leaves"}
            }}}
        }
    )
    utility.registerNode(
        "oak_wood",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_wood.png"},
            sounds = sounds.wood(),
            groups = {[blockType.wood] = 1, [blockType.planks] = 1}
        }
    )
    local dyes = {
        "black",
        "blue",
        "brown",
        "cyan",
        "dark_green",
        "dark_grey",
        "green",
        "grey",
        "magenta",
        "orange",
        "pink",
        "red",
        "violet",
        "white",
        "yellow"
    }
    for ____, color in ipairs(dyes) do
        utility.registerNode(
            ("" .. color) .. "_wool",
            {
                tiles = {("wool_" .. color) .. ".png"},
                sounds = sounds.wool(),
                groups = {[blockType.wool] = 1}
            }
        )
    end
    utility.registerNode(
        "glass",
        {
            drawtype = Drawtype.glasslike_framed_optional,
            tiles = {"default_glass.png", "default_glass_detail.png"},
            use_texture_alpha = TextureAlpha.clip,
            paramtype = ParamType1.light,
            sunlight_propagates = true,
            is_ground_content = false,
            sounds = sounds.glass(),
            groups = {[blockType.glass] = 1},
            drop = ""
        }
    )
end
