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
    local fakeRef = utility.fakeRef
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = "__builtin:item"
        self.object = fakeRef()
        self.itemString = ""
        self.movingState = true
        self.physicalState = true
        self.age = 0
        self.forceOut = vector.create()
        self.forceOutStart = vector.create()
        self.droppedBy = ""
        self.collected = false
        self.initial_properties = {
            hp_max = 1,
            physical = true,
            collide_with_objects = false,
            collisionbox = {
                -0.3,
                -0.3,
                -0.3,
                0.3,
                0.3,
                0.3
            },
            visual = EntityVisual.cube,
            visual_size = vector.create2d(),
            textures = {""},
            is_visible = false,
            pointable = false
        }
    end
    function ItemEntity.prototype.setItem(self, item)
        local stack = ItemStack(item or self.itemString)
        self.itemString = stack:to_string()
        if self.itemString == "" then
            return
        end
        local itemName = stack:is_known() and stack:get_name() or "unknown"
        local size = 0.21
        local def = minetest.registered_items[itemName]
        local sizeBias = 0.001 * math.random()
    end
    function ItemEntity.prototype.on_activate(self, staticData, delta)
    end
    function ItemEntity.prototype.on_step(self, delta, moveResult)
    end
    minetest.registerTSEntity(ItemEntity)
end
