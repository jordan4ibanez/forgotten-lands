namespace ItemDrop {
  // Namespace magic.
  type ItemEntity = BuiltinEntity.ItemEntity;

  function extractNodeGroups(position: Vec3): {[id: string] : number} | null {
    // If you dig a node, it should never be ignore. But it might be.
    const node = minetest.get_node_or_nil(position)
    if (!node) return null
    if (node.name == "ignore") return null
    const def = minetest.registered_nodes[node.name]
    // Something has gone seriously wrong, we'll role with it.
    if (!def) {
      // But we're going going to notify.
      minetest.log(LogLevel.warning, `Tried to get an UNKNOWN node! ${node.name} does not exist!`)
      return null
    }
    const groups = def.groups
    if (!groups) {
      // Again, this is an error. If no groups are defined there's a problem with the node definition.
      minetest.log(LogLevel.warning, `Node ${node.name} has no defined groups!`)
      return null
    }
    return groups
  }


  minetest.handle_node_drops = function(position: Vec3, drops: string[], digger: ObjectRef) {

    const groups = extractNodeGroups(position)
    
    print(dump(groups))

    // Group extraction has failed, abort.
    if (!groups) return

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