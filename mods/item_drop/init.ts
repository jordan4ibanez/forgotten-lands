{
  // Namespace magic.
  type ItemEntity = BuiltinEntity.ItemEntity;

  minetest.handle_node_drops = function(position: Vec3, drops: string[], digger: ObjectRef) {
    for (const drop of drops) {
      const item = minetest.add_item(position, drop)
      if (!item) {
        print("ERROR! Failed to add item via handle_node_drops!");
        continue
      }
      item.add_velocity(vector.random(
        -1,1,
        1,2,
        -1,1
      ))
      const itemEntity = item.get_luaentity() as ItemEntity
      itemEntity.age = 1
    }
  }

  minetest.spawn_item = function(pos: Vec3, item: string | ItemStackObject): ObjectRef | null {
    // Take item in any format.
    const stack = ItemStack(item)
    const object = minetest.add_entity(pos, "__builtin:item")
    // Don't use object if it couldn't be added to the map.
    if (object) {
      const luaEntity = object.get_luaentity() as ItemEntity
      luaEntity.setItem(stack.to_string())
    }
    return object
  }
}