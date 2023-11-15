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

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
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
__TS__SourceMapTraceBack(debug.getinfo(1).short_src, {["190"] = 1,["192"] = 2,["193"] = 3,["194"] = 4,["195"] = 6,["196"] = 6,["197"] = 6,["198"] = 6,["199"] = 6,["200"] = 6,["201"] = 6,["202"] = 14,["203"] = 16,["204"] = 16,["205"] = 6,["206"] = 6,["207"] = 6,["208"] = 26,["210"] = 27,["214"] = 30,["215"] = 30,["216"] = 30,["217"] = 30,["218"] = 30,["219"] = 30,["220"] = 30,["221"] = 30,["222"] = 30,["223"] = 39,["224"] = 39,["225"] = 39,["226"] = 39,["227"] = 39,["228"] = 39,["229"] = 39,["230"] = 39,["231"] = 39,["232"] = 48,["233"] = 48,["234"] = 48,["235"] = 48,["236"] = 48,["237"] = 48,["238"] = 48,["239"] = 48,["240"] = 48,["241"] = 48,["242"] = 62,["243"] = 62,["244"] = 62,["245"] = 62,["246"] = 62,["247"] = 62,["248"] = 62,["249"] = 62,["250"] = 62,["251"] = 71,["252"] = 71,["253"] = 71,["254"] = 71,["255"] = 71,["256"] = 71,["257"] = 71,["258"] = 71,["259"] = 71,["260"] = 80,["261"] = 80,["262"] = 80,["263"] = 80,["264"] = 80,["265"] = 80,["266"] = 80,["267"] = 80,["268"] = 80,["269"] = 93,["270"] = 93,["271"] = 93,["272"] = 93,["273"] = 93,["274"] = 93,["275"] = 93,["276"] = 93,["277"] = 93,["278"] = 93,["279"] = 93,["280"] = 93,["281"] = 105,["282"] = 105,["283"] = 105,["284"] = 105,["285"] = 105,["286"] = 105,["287"] = 105,["288"] = 105,["289"] = 105,["290"] = 105,["291"] = 105,["292"] = 105,["293"] = 105,["294"] = 105,["295"] = 105,["296"] = 105,["297"] = 105,["298"] = 105,["299"] = 123,["300"] = 124,["301"] = 124,["302"] = 124,["303"] = 124,["304"] = 124,["305"] = 124,["306"] = 124,["307"] = 124,["309"] = 133,["310"] = 133,["311"] = 133,["312"] = 133,["313"] = 133,["314"] = 133,["315"] = 133,["316"] = 133,["317"] = 133,["318"] = 133,["319"] = 133,["320"] = 133,["321"] = 133,["322"] = 133});
Blocks = Blocks or ({})
do
    local sounds = Sounds
    local generateDropRequirements = Tools.generateDropRequirements
    local ToolType = Tools.ToolType
    minetest.register_node(
        ":stone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_stone.png"},
            sounds = sounds.stone(),
            groups = {stone = 1},
            drop = {items = {{
                tool_groups = generateDropRequirements({[ToolType.Pickaxe] = 1}),
                items = {"stone"}
            }}}
        }
    )
    if true then
        error(
            Error(nil, "cool"),
            0
        )
    end
    minetest.register_node(
        ":cobblestone",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_cobble.png"},
            sounds = sounds.stone(),
            groups = {stone = 1}
        }
    )
    minetest.register_node(
        ":dirt",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_dirt.png"},
            sounds = sounds.dirt(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":grass",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
            sounds = sounds.grass(),
            groups = {soil = 1},
            drop = "dirt"
        }
    )
    minetest.register_node(
        ":sand",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_sand.png"},
            sounds = sounds.sand(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":gravel",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_gravel.png"},
            sounds = sounds.gravel(),
            groups = {soil = 1}
        }
    )
    minetest.register_node(
        ":oak_tree",
        {
            drawtype = Drawtype.normal,
            tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
            sounds = sounds.wood(),
            groups = {wooden = 1}
        }
    )
    minetest.register_node(
        ":oak_leaves",
        {
            drawtype = Drawtype.allfaces_optional,
            paramtype = ParamType1.light,
            waving = 1,
            tiles = {"default_leaves.png"},
            sounds = sounds.plant(),
            groups = {leafy = 1},
            drop = ""
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
        "purple",
        "red",
        "violet",
        "white",
        "yellow"
    }
    for ____, color in ipairs(dyes) do
        minetest.register_node(
            (":" .. color) .. "_wool",
            {
                tiles = {("wool_" .. color) .. ".png"},
                sounds = sounds.wool(),
                groups = {wool = 1}
            }
        )
    end
    minetest.register_node(
        ":glass",
        {
            drawtype = Drawtype.glasslike_framed_optional,
            tiles = {"default_glass.png", "default_glass_detail.png"},
            use_texture_alpha = TextureAlpha.clip,
            paramtype = ParamType1.light,
            sunlight_propagates = true,
            is_ground_content = false,
            sounds = sounds.glass(),
            groups = {glass = 1},
            drop = ""
        }
    )
end
