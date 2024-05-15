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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 1,["74"] = 3,["75"] = 5,["76"] = 8,["77"] = 8,["78"] = 8,["79"] = 8,["80"] = 8,["81"] = 8,["82"] = 8,["83"] = 8,["84"] = 8,["85"] = 8,["86"] = 8,["87"] = 17,["88"] = 19,["90"] = 20,["91"] = 21,["94"] = 22,["95"] = 23,["96"] = 24,["100"] = 27,["103"] = 28,["108"] = 17});
hand = hand or ({})
do
    local optionWrap = utility.optionWrap
    local warning = utility.warning
    utility.registerNode(
        "hand",
        {
            tiles = {"character.png"},
            visual_scale = 1,
            wield_scale = vector.create3d(1, 1, 1),
            paramtype = ParamType1.light,
            drawtype = Drawtype.mesh,
            mesh = "hand.b3d"
        }
    )
    minetest.register_on_joinplayer(function(player, _)
        local result = optionWrap(player:get_inventory())
        repeat
            local ____switch4 = result:is_some()
            local ____cond4 = ____switch4 == true
            if ____cond4 then
                do
                    local inv = result:unwrap()
                    inv:set_size("hand", 1)
                    inv:set_stack("hand", 1, "hand")
                    break
                end
            end
            ____cond4 = ____cond4 or ____switch4 == false
            if ____cond4 then
                do
                    warning("Player inventory disappeared when creating the 3D hand!")
                end
                break
            end
        until true
    end)
end
