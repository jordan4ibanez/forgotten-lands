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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["72"] = 2,["74"] = 6,["75"] = 7,["77"] = 8,["78"] = 9,["79"] = 10,["80"] = 11,["82"] = 13,["83"] = 13,["84"] = 13,["85"] = 13,["86"] = 13,["87"] = 13,["88"] = 13,["89"] = 13,["90"] = 18,["91"] = 19,["95"] = 6,["96"] = 23,["97"] = 25,["98"] = 26,["99"] = 28,["100"] = 29,["101"] = 30,["103"] = 32,["104"] = 23});
itemDrop = itemDrop or ({})
do
    minetest.handle_node_drops = function(position, drops, digger)
        for ____, drop in ipairs(drops) do
            do
                local item = minetest.add_item(position, drop)
                if not item then
                    print("ERROR! Failed to add item via handle_node_drops!")
                    goto __continue4
                end
                item:add_velocity(vector.random(
                    -1,
                    1,
                    1,
                    2,
                    -1,
                    1
                ))
                local itemEntity = item:get_luaentity()
                itemEntity.age = 1
            end
            ::__continue4::
        end
    end
    minetest.spawn_item = function(pos, item)
        local stack = ItemStack(item)
        local object = minetest.add_entity(pos, "__builtin:item")
        if object then
            local luaEntity = object:get_luaentity()
            luaEntity:setItem(stack:to_string())
        end
        return object
    end
end
