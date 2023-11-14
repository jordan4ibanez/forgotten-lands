

minetest.handle_node_drops = function(pos: Vec3, drops: {string}, _digger: ObjectRef)
  -- print("test", pos.x, pos.y, pos.z)
  -- minetest.add_particle({
  --   pos = pos,
  --   texture = "default_dirt.png"
  -- })
  --[[
    ! fixme: Need to look into:
    ! - drop chance
    ! - multiple items
    unless it's handled automatically of course.
  ]]
  -- Needs to handle multiple drops in an ItemStack.
  for _,drop in ipairs(drops) do
    local item: ObjectRef = minetest.add_item(pos, drop)
    if item then
      item:add_velocity(
        vector.random(
          -1,1,
           1,2,
          -1,1
        )
      )
      local entity = (item:get_luaentity() as table)
      entity.age = 1
    end
  end
end