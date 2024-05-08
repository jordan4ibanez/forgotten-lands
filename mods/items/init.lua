-- Lua Library inline imports
local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["82"] = 1,["84"] = 2,["85"] = 3,["89"] = 10,["90"] = 11,["91"] = 11,["92"] = 11,["93"] = 12,["95"] = 10,["96"] = 17,["97"] = 18,["98"] = 17,["99"] = 20,["100"] = 21,["101"] = 20,["102"] = 23,["103"] = 24,["104"] = 23,["105"] = 26,["106"] = 27,["107"] = 26,["108"] = 29,["109"] = 29,["110"] = 33,["111"] = 33,["112"] = 33,["113"] = 42,["114"] = 42,["115"] = 42,["116"] = 33,["117"] = 46,["118"] = 46,["119"] = 46,["120"] = 33,["121"] = 33,["122"] = 33,["123"] = 33,["124"] = 60});
items = items or ({})
do
    local craftRegister = minetest.register_craftitem
    local wieldScale = tools.wieldScale
    --- Easily register a dictionary of craft items.
    -- 
    -- @param inputArray Key value assignment of craftitems to be registered.
    local function processCraftItemArray(inputArray)
        for ____, ____value in ipairs(__TS__ObjectEntries(inputArray)) do
            local name = ____value[1]
            local definition = ____value[2]
            craftRegister(name, definition)
        end
    end
    local function turnIt(input)
        return input .. "^[transformR90"
    end
    local function turnItMore(input)
        return input .. "^[transformR180"
    end
    local function turnItMost(input)
        return input .. "^[transformR270"
    end
    local function flipIt(input)
        return input .. "^[transformFX"
    end
    local function bopIt()
    end
    local craftItems = {
        [":stick"] = {wield_scale = wieldScale, inventory_image = "default_stick.png"},
        [":coal"] = {wield_scale = wieldScale, inventory_image = "default_coal_lump.png"},
        [":iron"] = {
            wield_scale = wieldScale,
            inventory_image = flipIt("default_steel_ingot.png")
        },
        [":gold"] = {
            wield_scale = wieldScale,
            inventory_image = flipIt("default_gold_ingot.png")
        },
        [":diamond"] = {wield_scale = wieldScale, inventory_image = "default_diamond.png"},
        [":mese"] = {wield_scale = wieldScale, inventory_image = "default_mese_crystal.png"}
    }
    processCraftItemArray(craftItems)
end
