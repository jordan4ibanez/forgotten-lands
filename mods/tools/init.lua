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
    Tools.wieldScale = vector.create(1.5, 1.5, 1)
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
    --- Generates a tool group dictionary.
    -- 
    -- @param table The ToolType max level in which it can drop items from the tool group.
    function Tools.generateToolDropGroups(____table)
        local temp = {}
        for ____, ____value in ipairs(__TS__ObjectEntries(____table)) do
            local toolType = ____value[1]
            local maxLevel = ____value[2]
            do
                local i = 1
                while i <= maxLevel do
                    temp[(toolType .. "_") .. tostring(i)] = 1
                    i = i + 1
                end
            end
        end
        return temp
    end
    utility.loadFiles({
        "hand",
        "pickaxe",
        "shovel",
        "axe",
        "sword"
    })
end
