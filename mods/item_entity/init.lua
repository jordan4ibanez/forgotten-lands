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

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end
-- End of Lua Library inline imports
do
    local println = utility.println
    local fakeObjectRef = utility.fakeObjectRef
    local nextID = 0
    local function idGenerator()
        local gotten = nextID
        nextID = nextID + 1
        return gotten
    end
    local velocityWorker = vector.create(0, 0, 0)
    local Cool = __TS__Class()
    Cool.name = "Cool"
    function Cool.prototype.____constructor(self)
        self.name = "flop"
        self.object = fakeObjectRef()
    end
    local function clamp(min, max, input)
        if input < min then
            return min
        elseif input > max then
            return max
        end
        return input
    end
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = "test"
        self.object = fakeObjectRef()
        self.timer = 0
        self.cool = 5
        self.id = -1
    end
    function ItemEntity.prototype.on_activate(self, staticData, delta)
        self.id = idGenerator()
        print(self.cool)
        self.cool = self.cool + 1
    end
    function ItemEntity.prototype.on_step(self, delta, moveResult)
        local pos = self.object:get_pos()
        print("begin ----")
        __TS__ArrayForEach(
            __TS__ArrayFilter(
                minetest.get_objects_inside_radius(pos, 1),
                function(____, reference)
                    return not reference:is_player()
                end
            ),
            function(____, entity)
                local luaEntity = entity:get_luaentity()
                print(__TS__InstanceOf(luaEntity, Cool))
                print(__TS__InstanceOf(luaEntity, ItemEntity))
            end
        )
    end
    minetest.registerTSEntity(ItemEntity)
end
