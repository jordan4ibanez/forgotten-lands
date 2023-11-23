-- Lua Library inline imports
local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end
-- End of Lua Library inline imports
minecart = minecart or ({})
do
    local fakeRef = utility.fakeRef
    local MinecartEntity = __TS__Class()
    MinecartEntity.name = "MinecartEntity"
    function MinecartEntity.prototype.____constructor(self)
        self.name = "minecart"
        self.object = fakeRef()
        self.initial_properties = {mesh = "minecart.b3d", textures = {"default_dirt.png"}}
    end
    minetest.registerTSEntity(MinecartEntity)
end
