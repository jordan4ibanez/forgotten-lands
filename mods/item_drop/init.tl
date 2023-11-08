function minetest.handle_node_drops(pos: Vec3, drops: {string}, digger: ObjectRef)
  print("test", pos.x, pos.y, pos.z)
  minetest.add_particle({
    pos = pos,
    texture = "default_dirt.png"
  })
  --[[
    ! fixme: Need to look into:
    ! - drop chance
    ! - multiple items
    unless it's handled automatically of course.
  ]]
  
  print(dump(drops))
  -- Needs to handle multiple drops in an ItemStack.
  for _,drop in ipairs(drops) do
    local item: ObjectRef = minetest.add_item(pos, drop)
    if item then
      (item as ObjectRef):add_velocity(vector.new())
    end
  end
end