-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["85"] = 1,["89"] = 1,["90"] = 1,["91"] = 7,["92"] = 40,["93"] = 8,["94"] = 41,["95"] = 40,["96"] = 10,["97"] = 11,["98"] = 10,["99"] = 14,["100"] = 15,["101"] = 14,["102"] = 18,["103"] = 19,["104"] = 20,["106"] = 22,["108"] = 18,["109"] = 26,["110"] = 27,["111"] = 28,["113"] = 30,["114"] = 26,["115"] = 33,["116"] = 34,["117"] = 35,["119"] = 37,["120"] = 33,["121"] = 44,["122"] = 45,["123"] = 46,["124"] = 44,["125"] = 1,["131"] = 1,["132"] = 60,["133"] = 59});
utility = utility or ({})
do
    --- Mini null safety wrapper.
    -- Since this is single threaded, it's gonna get real weird.
    utility.Option = __TS__Class()
    local Option = utility.Option
    Option.name = "Option"
    function Option.prototype.____constructor(self, input)
        self.data = nil
        self.data = input
    end
    function Option.prototype.is_some(self)
        return self.data ~= nil
    end
    function Option.prototype.is_none(self)
        return self.data == nil
    end
    function Option.prototype.unwrap(self)
        if self.data then
            return self.data
        else
            error("Tried to unwrap nothing!")
        end
    end
    function Option.prototype.someFun(self, f)
        if self.data ~= nil then
            f(self.data)
        end
        return self
    end
    function Option.prototype.noneFun(self, f)
        if self.data == nil then
            f()
        end
        return self
    end
    function Option.prototype.mutate(self, input)
        self.data = input
        return self
    end
    local singleton = __TS__New(utility.Option, nil)
    --- If you're not sure if it's going to be nothing, safely wrap it.
    -- ! Do not use this in a threaded environment or it WILL explode. :D
    -- 
    -- @param input Something...or maybe nothing?
    -- @returns OptionSingleThreaded<Type>
    function utility.optionWrap(input)
        return singleton:mutate(input)
    end
end
