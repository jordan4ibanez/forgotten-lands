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
items = items or ({})
do
    local craftRegister = minetest.register_craftitem
    local wieldScale = tools.wieldScale
    --- Easily register a dictionary of craft items.
    -- 
    -- @param inputArray Key value assignment of craftitems to be registered.
    function items.processCraftItemArray(inputArray)
        for ____, ____value in ipairs(__TS__ObjectEntries(inputArray)) do
            local name = ____value[1]
            local definition = ____value[2]
            craftRegister(name, definition)
        end
    end
    local function turnIt(input)
        return input .. "^[transformR90"
    end
    local function turnItMore(input)
        return input .. "^[transformR180"
    end
    local function turnItMost(input)
        return input .. "^[transformR270"
    end
    local function flipIt(input)
        return input .. "^[transformFX"
    end
    local function bopIt()
    end
    local craftItems = {
        [":stick"] = {wield_scale = wieldScale, inventory_image = "default_stick.png"},
        [":coal"] = {wield_scale = wieldScale, inventory_image = "default_coal_lump.png"},
        [":iron"] = {
            wield_scale = wieldScale,
            inventory_image = flipIt("default_steel_ingot.png")
        },
        [":gold"] = {
            wield_scale = wieldScale,
            inventory_image = flipIt("default_gold_ingot.png")
        },
        [":diamond"] = {wield_scale = wieldScale, inventory_image = "default_diamond.png"},
        [":mese"] = {wield_scale = wieldScale, inventory_image = "default_mese_crystal.png"}
    }
    items.processCraftItemArray(craftItems)
end
