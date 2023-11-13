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
    local ItemEntity = __TS__Class()
    ItemEntity.name = "ItemEntity"
    function ItemEntity.prototype.____constructor(self)
        self.name = ""
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
        self.timer = self.timer + delta
        if self.timer > 2 then
            print((("id: " .. tostring(self.id)) .. " | cool: ") .. tostring(self.cool))
            self.cool = self.cool + math.random()
            self.timer = 0
            print(self.name)
            print("---------")
            if math.random() > 0.7 then
                self.object:remove()
                self.on_step = function(self, delta)
                    self.timer = self.timer + delta
                    if self.timer > 2 then
                        print("I don't feel like it anymore | id:" .. tostring(self.id))
                        self.timer = 0
                    end
                end
            end
        end
    end
    minetest.register_entity(
        ":test",
        __TS__New(ItemEntity)
    )
end
