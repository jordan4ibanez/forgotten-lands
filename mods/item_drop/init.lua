ItemDrop = ItemDrop or ({})
do
    minetest.handle_node_drops = function(position, drops, digger)
        local node = minetest.get_node_or_nil(position)
        if not node then
            return
        end
        if node.name == "ignore" then
            return
        end
        local def = minetest.registered_nodes[node.name]
        if not def then
            minetest.log(LogLevel.warning, ("Tried to get an UNKNOWN node! " .. node.name) .. " does not exist!")
            return
        end
        local groups = def.groups
        if not groups then
            minetest.log(LogLevel.warning, ("Node " .. node.name) .. " has no defined groups!")
            return
        end
        print(dump(groups))
        for ____, drop in ipairs(drops) do
            do
                local item = minetest.add_item(position, drop)
                if not item then
                    print("ERROR! Failed to add item via handle_node_drops!")
                    goto __continue8
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
            ::__continue8::
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
