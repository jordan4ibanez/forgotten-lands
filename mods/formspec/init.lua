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
    local function sVec(input)
        return (tostring(input.x) .. ",") .. tostring(input.y)
    end
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
    formSpec.ElementToolTip = __TS__Class()
    local ElementToolTip = formSpec.ElementToolTip
    ElementToolTip.name = "ElementToolTip"
    function ElementToolTip.prototype.____constructor(self, definition)
        self.guiElementName = ""
        self.text = ""
        self.bgColor = ""
        self.fontColor = ""
        self.guiElementName = definition.guiElementName
        self.text = definition.text
        self.bgColor = definition.bgColor
        self.fontColor = definition.fontColor
    end
    formSpec.AreaToolTip = __TS__Class()
    local AreaToolTip = formSpec.AreaToolTip
    AreaToolTip.name = "AreaToolTip"
    function AreaToolTip.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.text = ""
        self.bgColor = ""
        self.fontColor = ""
        self.position = definition.position
        self.size = definition.size
        self.text = definition.text
        self.bgColor = definition.bgColor
        self.fontColor = definition.fontColor
    end
    formSpec.Image = __TS__Class()
    local Image = formSpec.Image
    Image.name = "Image"
    function Image.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.texture = ""
        self.position = definition.position
        self.size = definition.size
        self.texture = definition.texture
        self.middle = definition.middle
    end
    formSpec.AnimatedImage = __TS__Class()
    local AnimatedImage = formSpec.AnimatedImage
    AnimatedImage.name = "AnimatedImage"
    __TS__ClassExtends(AnimatedImage, formSpec.Image)
    function AnimatedImage.prototype.____constructor(self, definition)
        AnimatedImage.____super.prototype.____constructor(self, definition)
        self.name = ""
        self.frameCount = 0
        self.frameDuration = 0
        self.frameStart = 0
        self.name = definition.name
        self.frameCount = definition.frameCount
        self.frameDuration = definition.frameDuration
        self.frameStart = definition.frameStart
    end
    formSpec.Model = __TS__Class()
    local Model = formSpec.Model
    Model.name = "Model"
    function Model.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.name = ""
        self.mesh = ""
        self.textures = ""
        self.rotation = create(0, 0)
        self.continuous = true
        self.mouseControl = true
        self.frameLoopRange = create(0, 0)
        self.animationSpeed = 1
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.mesh = definition.mesh
        self.textures = definition.textures
        self.rotation = definition.rotation
        self.continuous = definition.continuous
        self.mouseControl = definition.mouseControl
        self.frameLoopRange = definition.frameLoopRange
        self.animationSpeed = definition.animationSpeed
    end
    formSpec.BGColor = __TS__Class()
    local BGColor = formSpec.BGColor
    BGColor.name = "BGColor"
    function BGColor.prototype.____constructor(self, definition)
        self.bgColor = ""
        self.fullScreen = true
        self.fullScreenbgColor = ""
        self.bgColor = definition.bgColor
        self.fullScreen = definition.fullScreen
        self.fullScreenbgColor = definition.fullScreenbgColor
    end
    formSpec.Background = __TS__Class()
    local Background = formSpec.Background
    Background.name = "Background"
    function Background.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.texture = ""
        self.position = definition.position
        self.size = definition.size
        self.texture = definition.texture
        self.autoclip = definition.autoClip
        self.middle = definition.middle
    end
    formSpec.PasswordField = __TS__Class()
    local PasswordField = formSpec.PasswordField
    PasswordField.name = "PasswordField"
    function PasswordField.prototype.____constructor(self, definition)
        self.position = create(0, 0)
        self.size = create(0, 0)
        self.name = ""
        self.label = ""
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
    end
    formSpec.Field = __TS__Class()
    local Field = formSpec.Field
    Field.name = "Field"
    function Field.prototype.____constructor(self, definition)
        self.name = ""
        self.label = ""
        self.default = ""
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
        self.default = definition.default
    end
    formSpec.FieldEnterAfterEdit = __TS__Class()
    local FieldEnterAfterEdit = formSpec.FieldEnterAfterEdit
    FieldEnterAfterEdit.name = "FieldEnterAfterEdit"
    function FieldEnterAfterEdit.prototype.____constructor(self, name)
        self.name = name
    end
    formSpec.FieldCloseOnEnter = __TS__Class()
    local FieldCloseOnEnter = formSpec.FieldCloseOnEnter
    FieldCloseOnEnter.name = "FieldCloseOnEnter"
    function FieldCloseOnEnter.prototype.____constructor(self, name)
        self.name = name
    end
    formSpec.TextArea = __TS__Class()
    local TextArea = formSpec.TextArea
    TextArea.name = "TextArea"
    function TextArea.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
        self.default = definition.default
    end
    formSpec.Label = __TS__Class()
    local Label = formSpec.Label
    Label.name = "Label"
    function Label.prototype.____constructor(self, definition)
        self.position = definition.position
        self.label = definition.label
    end
    formSpec.HyperText = __TS__Class()
    local HyperText = formSpec.HyperText
    HyperText.name = "HyperText"
    function HyperText.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.text = definition.text
    end
    formSpec.VertLabel = __TS__Class()
    local VertLabel = formSpec.VertLabel
    VertLabel.name = "VertLabel"
    function VertLabel.prototype.____constructor(self, definition)
        self.position = definition.position
        self.label = definition.label
    end
    formSpec.Button = __TS__Class()
    local Button = formSpec.Button
    Button.name = "Button"
    function Button.prototype.____constructor(self, definition)
        self.position = definition.position
        self.size = definition.size
        self.name = definition.name
        self.label = definition.label
    end
    formSpec.ImageButton = __TS__Class()
    local ImageButton = formSpec.ImageButton
    ImageButton.name = "ImageButton"
    __TS__ClassExtends(ImageButton, formSpec.Button)
    function ImageButton.prototype.____constructor(self, definition)
        ImageButton.____super.prototype.____constructor(self, definition)
        self.texture = definition.texture
    end
    local function processElements(accumulator, elementArray)
        for ____, element in ipairs(elementArray) do
            if __TS__InstanceOf(element, formSpec.Container) then
                local pos = element.position
                accumulator = accumulator .. ("container[" .. sVec(pos)) .. "]\n"
                accumulator = accumulator .. "container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.ScrollContainer) then
                local pos = element.position
                local size = element.size
                accumulator = accumulator .. ((((((((("scroll_container[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. element.name) .. ";") .. element.orientation) .. ";") .. tostring(element.factor)) .. "]\n"
                accumulator = accumulator .. "scroll_container_end[]\n"
            elseif __TS__InstanceOf(element, formSpec.List) then
                local location = element.location
                local listName = element.listName
                local pos = element.position
                local size = element.size
                local startingIndex = element.startingIndex
                accumulator = accumulator .. ((((((((("list[" .. location) .. ";") .. listName) .. ";") .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. tostring(startingIndex)) .. "]\n"
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
            elseif __TS__InstanceOf(element, formSpec.ElementToolTip) then
                local guiElementName = element.guiElementName
                local text = element.text
                local bgColor = element.bgColor
                local fontColor = element.fontColor
                accumulator = accumulator .. ((((((("tooltip[" .. guiElementName) .. ";") .. text) .. ";") .. bgColor) .. ";") .. fontColor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.AreaToolTip) then
                local pos = element.position
                local size = element.size
                local text = element.text
                local bgcolor = element.bgColor
                local fontcolor = element.fontColor
                accumulator = accumulator .. ((((((((("tooltip[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. text) .. ";") .. bgcolor) .. ";") .. fontcolor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Image) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local middle = element.middle
                accumulator = accumulator .. (((("image[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. texture
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.AnimatedImage) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local name = element.name
                local frameCount = element.frameCount
                local frameDuration = element.frameDuration
                local frameStart = element.frameStart
                local middle = element.middle
                accumulator = accumulator .. (((((((((((("animated_image[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. texture) .. ";") .. tostring(frameCount)) .. ";") .. tostring(frameDuration)) .. ";") .. tostring(frameStart)
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Model) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local mesh = element.mesh
                local textures = element.textures
                local rotation = element.rotation
                local continuous = element.continuous
                local mouseControl = element.mouseControl
                local frameLoopRange = element.frameLoopRange
                local animationSpeed = element.animationSpeed
                accumulator = accumulator .. ((((((((((((((((((("model[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. mesh) .. ";") .. textures) .. ";") .. sVec(rotation)) .. ";") .. tostring(continuous)) .. ";") .. tostring(mouseControl)) .. ";") .. sVec(frameLoopRange)) .. ";") .. tostring(animationSpeed)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.BGColor) then
                local bgcolor = element.bgColor
                local fullScreen = element.fullScreen
                local fullScreenbgColor = element.fullScreenbgColor
                accumulator = accumulator .. ((((("bgcolor[" .. bgcolor) .. ";") .. tostring(fullScreen)) .. ";") .. fullScreenbgColor) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Background) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local ____temp_2
                if element.autoclip then
                    ____temp_2 = true
                else
                    ____temp_2 = false
                end
                local autoClip = ____temp_2
                local middle = element.middle
                if middle then
                    accumulator = accumulator .. "background9["
                else
                    accumulator = accumulator .. "background["
                end
                accumulator = accumulator .. (((((sVec(pos) .. ";") .. sVec(size)) .. ";") .. texture) .. ";") .. tostring(autoClip)
                if middle then
                    accumulator = accumulator .. ";" .. middle
                end
                accumulator = accumulator .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.PasswordField) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((("pwdfield[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Field) then
                local pos = element.position
                local size = element.size
                accumulator = accumulator .. "field["
                if pos and size then
                    accumulator = accumulator .. ((sVec(pos) .. ";") .. sVec(size)) .. ";"
                end
                local name = element.name
                local label = element.label
                local def = element.default
                accumulator = accumulator .. ((((name .. ";") .. label) .. ";") .. def) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.FieldEnterAfterEdit) then
                local name = element.name
                accumulator = accumulator .. ((("field_enter_after_edit[" .. name) .. ";") .. tostring(true)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.FieldCloseOnEnter) then
                local name = element.name
                accumulator = accumulator .. ((("field_close_on_enter[" .. name) .. ";") .. tostring(true)) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.TextArea) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                local def = element.default
                accumulator = accumulator .. ((((((((("textarea[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. label) .. ";") .. def) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Label) then
                local pos = element.position
                local label = element.label
                accumulator = accumulator .. ((("label[" .. sVec(pos)) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.HyperText) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local text = element.text
                accumulator = accumulator .. ((((((("hypertext[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. text) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.VertLabel) then
                local pos = element.position
                local label = element.label
                accumulator = accumulator .. ((("vertlabel[" .. sVec(pos)) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.Button) then
                local pos = element.position
                local size = element.size
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((("button[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. name) .. ";") .. label) .. "]\n"
            elseif __TS__InstanceOf(element, formSpec.ImageButton) then
                local pos = element.position
                local size = element.size
                local texture = element.texture
                local name = element.name
                local label = element.label
                accumulator = accumulator .. ((((((((("button[" .. sVec(pos)) .. ";") .. sVec(size)) .. ";") .. texture) .. ";") .. name) .. ";") .. label) .. "]\n"
            end
        end
        return accumulator
    end
    function formSpec.generate(d)
        local accumulator = "formspec_version[7]\n"
        if d.size then
            local ____temp_3
            if d.fixedSize then
                ____temp_3 = true
            else
                ____temp_3 = false
            end
            local fixed = ____temp_3
            local size = d.size
            accumulator = accumulator .. ((("size[" .. sVec(size)) .. ",") .. tostring(fixed)) .. "]\n"
        end
        if d.position then
            local pos = d.position
            accumulator = accumulator .. ("position[" .. sVec(pos)) .. "]\n"
        end
        if d.anchor then
            local anchor = d.anchor
            accumulator = accumulator .. ("anchor[" .. sVec(anchor)) .. "]\n"
        end
        if d.padding then
            local p = d.padding
            accumulator = accumulator .. ("padding[" .. sVec(p)) .. "]\n"
        end
        if d.disablePrepend then
            accumulator = accumulator .. "no_prepend[]\n"
        end
        accumulator = processElements(accumulator, d.elements)
        return accumulator
    end
end
