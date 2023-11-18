-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
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

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
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
    end
    formSpec.FormSpecContainer = __TS__Class()
    local FormSpecContainer = formSpec.FormSpecContainer
    FormSpecContainer.name = "FormSpecContainer"
    function FormSpecContainer.prototype.____constructor(self)
        self.position = create(0, 0)
        self.elements = {}
    end
    function formSpec.newContainer(definition)
        local temp = {position = definition.position, elements = definition.elements}
        return temp
    end
    local function processElements(elementArray)
        print(dump(elementArray))
        for ____, element in ipairs(elementArray) do
            print(__TS__InstanceOf(element, formSpec.FormSpecContainer))
        end
    end
    local function generate(d)
        local accumulator = "formspec_version[7]\n"
        if d.size then
            local ____temp_1
            if d.fixedSize then
                ____temp_1 = true
            else
                ____temp_1 = false
            end
            local fixed = ____temp_1
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
        processElements(d.elements)
    end
    generate(__TS__New(
        formSpec.FormSpec,
        {
            size = create(8, 9),
            elements = {}
        }
    ))
end
