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
    local velocityWorker = vector.create(0, 0, 0)
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
        for ____, player in ipairs(minetest.get_connected_players()) do
            print(player:get_player_name())
            local playerPos = player:get_pos()
            local pos = self.object:get_pos()
            local normalized = vector.direction(playerPos, pos)
            local maxSpeed = 100
            local goalDistance = 10
            local snappiness = 1000
            local distance = clamp(
                0,
                maxSpeed,
                (goalDistance - vector.distance(pos, playerPos)) * snappiness
            )
            local velocity = vector.multiply(normalized, distance)
            self.object:set_velocity(velocity)
            if math.random() > 0.995 then
                print("see ya")
                self.object:remove()
            else
                print("not this time! " .. tostring(math.random()))
            end
        end
    end
    minetest.register_entity(
        ":test",
        __TS__New(ItemEntity)
    )
end
