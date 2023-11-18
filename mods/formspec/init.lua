-- Lua Library inline imports
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

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end
-- End of Lua Library inline imports
formSpec = formSpec or ({})
do
    local create = vector.create2d
    formSpec.FormSpec = __TS__Class()
    local FormSpec = formSpec.FormSpec
    FormSpec.name = "FormSpec"
    function FormSpec.prototype.____constructor(self, definition)
        self.elements = {}
        self.size = definition.size
        self.fixedSize = definition.fixedSize
        self.position = definition.position
        self.anchor = definition.anchor
        self.padding = definition.padding
        self.disablePrepend = definition.disablePrepend
        self.elements = definition.elements
    end
    function FormSpec.prototype.attachElement(self, newElement)
        local ____self_elements_0 = self.elements
        ____self_elements_0[#____self_elements_0 + 1] = newElement
        return self
    end
    formSpec.Container = __TS__Class()
    local Container = formSpec.Container
    Container.name = "Container"
    function Container.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.elements = {}
        do
            self.position = definition.position
            self.elements = definition.elements
        end
    end
    function Container.prototype.attachElement(self, newElement)
        local ____self_elements_1 = self.elements
        ____self_elements_1[#____self_elements_1 + 1] = newElement
        return self
    end
    formSpec.ScrollOrientation = ScrollOrientation or ({})
    formSpec.ScrollOrientation.vertical = "vertical"
    formSpec.ScrollOrientation.horizontal = "horizontal"
    formSpec.ScrollContainer = __TS__Class()
    local ScrollContainer = formSpec.ScrollContainer
    ScrollContainer.name = "ScrollContainer"
    __TS__ClassExtends(ScrollContainer, formSpec.Container)
    function ScrollContainer.prototype.____constructor(self, definition)
        ScrollContainer.____super.prototype.____constructor(self, {position = definition.position, elements = definition.elements})
        self.size = create(0, 0)
        self.orientation = formSpec.ScrollOrientation.vertical
        self.factor = 0.1
        self.name = "placeHolder"
        self.size = definition.size
        self.orientation = definition.orientation
        self.factor = definition.factor or 0.1
        self.name = definition.name
    end
    formSpec.List = __TS__Class()
    local List = formSpec.List
    List.name = "List"
    function List.prototype.____constructor(self, definition)
        self.location = ""
        self.listName = ""
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.startingIndex = 0
        self.location = definition.location
        self.listName = definition.listName
        self.position = definition.position
        self.size = definition.size
        self.startingIndex = definition.startingIndex
    end
    formSpec.ListRing = __TS__Class()
    local ListRing = formSpec.ListRing
    ListRing.name = "ListRing"
    function ListRing.prototype.____constructor(self, definition)
        self.location = ""
        self.listName = ""
        self.location = definition.location
        self.listName = definition.listName
    end
    formSpec.ListColors = __TS__Class()
    local ListColors = formSpec.ListColors
    ListColors.name = "ListColors"
    function ListColors.prototype.____constructor(self)
        self.slotBGNormal = ""
        self.slotBGHover = ""
    end
    local function processElements(accumulator, elementArray)
        for ____, element in ipairs(elementArray) do
            if __TS__InstanceOf(element, formSpec.Container) then
                local pos = element.position
                accumulator = accumulator .. ((("container[" .. tostring(pos.x)) .. ",") .. tostring(pos.y)) .. "]\n"
                accumulator = accumulator .. "container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.ScrollContainer) then
                local pos = element.position
                local size = element.size
                accumulator = accumulator .. ((((((((((((("scroll_container[" .. tostring(pos.x)) .. ",") .. tostring(pos.y)) .. ";") .. tostring(size.x)) .. ",") .. tostring(size.y)) .. ";") .. element.name) .. ";") .. element.orientation) .. ";") .. tostring(element.factor)) .. "]\n"
                accumulator = accumulator .. "scroll_container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.List) then
                local location = element.location
                local listName = element.listName
                local pos = element.position
                local size = element.size
                local startingIndex = element.startingIndex
                accumulator = accumulator .. ((((((((((((("list[" .. location) .. ";") .. listName) .. ";") .. tostring(pos.x)) .. ",") .. tostring(pos.y)) .. ";") .. tostring(size.x)) .. ",") .. tostring(size.y)) .. ";") .. tostring(startingIndex)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ListRing) then
                local location = element.location
                local listName = element.listName
                accumulator = accumulator .. ((("listring[" .. location) .. ";") .. listName) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ListColors) then
                local slotBGNormal = element.slotBGNormal
                local slotBGHover = element.slotBGHover
                accumulator = accumulator .. (("listcolors[" .. slotBGNormal) .. ";") .. slotBGHover
                local slotBorder = element.slotBorder
                if slotBorder then
                    accumulator = accumulator .. ";" .. slotBorder
                    local toolTipBGColor = element.toolTipBGColor
                    local toolTipFontColor = element.toolTipFontColor
                    if toolTipBGColor and toolTipFontColor then
                        accumulator = accumulator .. ((";" .. toolTipBGColor) .. ";") .. toolTipFontColor
                    end
                end
                accumulator = accumulator .. "]\n"
            end
        end
        return accumulator
    end
    function formSpec.generate(d)
        local accumulator = "formspec_version[7]\n"
        if d.size then
            local ____temp_2
            if d.fixedSize then
                ____temp_2 = true
            else
                ____temp_2 = false
            end
            local fixed = ____temp_2
            local size = d.size
            accumulator = accumulator .. ((((("size[" .. tostring(size.x)) .. ",") .. tostring(size.y)) .. ",") .. tostring(fixed)) .. "]\n"
        end
        if d.position then
            local pos = d.position
            accumulator = accumulator .. ((("position[" .. tostring(pos.x)) .. ",") .. tostring(pos.y)) .. "]\n"
        end
        if d.anchor then
            local anchor = d.anchor
            accumulator = accumulator .. ((("anchor[" .. tostring(anchor.x)) .. ",") .. tostring(anchor.y)) .. "]\n"
        end
        if d.padding then
            local p = d.padding
            accumulator = accumulator .. ((("padding[" .. tostring(p.x)) .. ",") .. tostring(p.y)) .. "]\n"
        end
        if d.disablePrepend then
            accumulator = accumulator .. "no_prepend[]\n"
        end
        accumulator = processElements(accumulator, d.elements)
        return accumulator
    end
end
