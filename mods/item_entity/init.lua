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
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = "__builtin:item"
        self.object = fakeObjectRef()
    end
    function ItemEntity.prototype.on_activate(self, staticData, delta)
    end
    function ItemEntity.prototype.on_step(self, delta, moveResult)
    end
    minetest.registerTSEntity(ItemEntity)
end
