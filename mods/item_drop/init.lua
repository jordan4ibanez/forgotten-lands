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
end
