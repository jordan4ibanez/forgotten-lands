itemDrop = itemDrop or ({})
do
    minetest.handle_node_drops = function(position, drops, digger)
        for ____, drop in ipairs(drops) do
            do
                local item = minetest.add_item(position, drop)
                if not item then
                    print("ERROR! Failed to add item via handle_node_drops!")
                    goto __continue4
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
            ::__continue4::
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
