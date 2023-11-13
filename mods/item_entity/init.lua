-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
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
    local Cool = __TS__Class()
    Cool.name = "Cool"
    function Cool.prototype.____constructor(self)
        self.name = "flop"
        self.object = fakeObjectRef()
    end
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = "__builtin:item"
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
    end
    minetest.registerTSEntity(ItemEntity)
end
