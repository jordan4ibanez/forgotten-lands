-- Lua Library inline imports
local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end
-- End of Lua Library inline imports
Items = Items or ({})
do
    local craftRegister = minetest.register_craftitem
    local wieldScale = Tools.wieldScale
    --- Easily register a dictionary of craft items.
    -- 
    -- @param inputArray Key value assignment of craftitems to be registered.
    function Items.processCraftItemArray(inputArray)
        for ____, ____value in ipairs(__TS__ObjectEntries(inputArray)) do
            local name = ____value[1]
            local definition = ____value[2]
            craftRegister(name, definition)
        end
    end
    local craftItems = {[":stick"] = {wield_scale = wieldScale, inventory_image = "default_stick.png"}}
    Items.processCraftItemArray(craftItems)
end
