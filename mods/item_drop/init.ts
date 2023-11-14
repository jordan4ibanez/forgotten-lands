{
  // Namespace magic.
  type Entity = BuiltinEntity.ItemEntity;

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
      const itemEntity = item.get_luaentity() as Entity
      itemEntity.age = 1

    }
  }
}