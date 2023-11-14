ItemDrop = ItemDrop or ({})
do
    local function extractNodeGroups(position)
        local node = minetest.get_node_or_nil(position)
        if not node then
            return nil
        end
        if node.name == "ignore" then
            return nil
        end
        local def = minetest.registered_nodes[node.name]
        if not def then
            minetest.log(LogLevel.warning, ("Tried to get an UNKNOWN node! " .. node.name) .. " does not exist!")
            return nil
        end
        local groups = def.groups
        if not groups then
            minetest.log(LogLevel.warning, ("Node " .. node.name) .. " has no defined groups!")
            return nil
        end
        return groups
    end
    local function extractWieldGroups(digger)
        if not digger:is_player() then
            return
        end
        local wieldedItem = digger:get_wielded_item()
        if not wieldedItem then
            local name = digger:get_player_name()
            minetest.log(LogLevel.warning, ("Attempt to get wield item from player " .. name) .. " gave a null value!")
            return
        end
        local itemName = wieldedItem:get_name()
        local def = minetest.registered_items[itemName]
        if not def then
            minetest.log(LogLevel.warning, ("Tried to get an UNKNOWN item! " .. itemName) .. " does not exist!")
            return
        end
        local itemType = def.type
        print((("type of " .. itemName) .. " is ") .. tostring(itemType))
        local groups = def.groups
        if not groups then
            minetest.log(LogLevel.warning, ("Item " .. itemName) .. " has no defined groups!")
        end
    end
    minetest.handle_node_drops = function(position, drops, digger)
        local groups = extractNodeGroups(position)
        extractWieldGroups(digger)
        if not groups then
            return
        end
        for ____, drop in ipairs(drops) do
            do
                local item = minetest.add_item(position, drop)
                if not item then
                    print("ERROR! Failed to add item via handle_node_drops!")
                    goto __continue15
                end
                item:add_velocity(vector.random(
                    -1,
                    1,
                    1,
                    2,
                    -1,
                    1
                ))
                local itemEntity = item:get_luaentity()
                itemEntity.age = 1
            end
            ::__continue15::
        end
    end
    minetest.spawn_item = function(pos, item)
        local stack = ItemStack(item)
        local object = minetest.add_entity(pos, "__builtin:item")
        if object then
            local luaEntity = object:get_luaentity()
            luaEntity:setItem(stack:to_string())
        end
        return object
    end
end
