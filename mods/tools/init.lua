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
Tools = Tools or ({})
do
    Tools.CURRENT_MAX_LEVEL = 5
    Tools.ToolType = ToolType or ({})
    Tools.ToolType.Pickaxe = "pickaxe"
    Tools.ToolType.Shovel = "shovel"
    Tools.ToolType.Axe = "axe"
    Tools.ToolType.Hoe = "hoe"
    Tools.ToolType.Shears = "shears"
    --- Generates a node tool_groups array.
    -- 
    -- @param table Holds the ToolType and min tool level to drop an item.
    function Tools.generateDropRequirements(____table)
        local temp = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(____table)) do
            local toolType = ____value[1]
            local minLevel = ____value[2]
            do
                local i = minLevel
                while i <= Tools.CURRENT_MAX_LEVEL do
                    temp[#temp + 1] = (toolType .. "_") .. tostring(i)
                    i = i + 1
                end
            end
        end
        return temp
    end
    Tools.generateDropRequirements({[Tools.ToolType.Axe] = 3})
    minetest.register_tool(":pickaxe", {inventory_image = "default_tool_stonepick.png", tool_capabilities = {full_punch_interval = 0.5, max_drop_level = 1, groupcaps = {stone = {times = {[1] = 1}, maxlevel = 1, maxdrop = 0}}}, groups = {pickaxe_1 = 1}})
end
