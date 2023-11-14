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

  function extractWieldGroups(digger: ObjectRef) {

    // A mod made the server dig or someone is hacking.
    if (!digger.is_player()) return

    const wieldedItem = digger.get_wielded_item()

    // Something wild happened. If this is hit, there is an engine problem.
    if (!wieldedItem) {
      const name = digger.get_player_name()
      minetest.log(LogLevel.warning, `Attempt to get wield item from player ${name} gave a null value!`)
      return
    }

    const itemName = wieldedItem.get_name()

    const def = minetest.registered_items[itemName]
    // Something has gone seriously wrong, we'll role with it.
    if (!def) {
      // But we're going going to notify.
      minetest.log(LogLevel.warning, `Tried to get an UNKNOWN item! ${itemName} does not exist!`)
      return
    }

    // Make sure this is an actual tool.
    const itemType = def.type

    print(`type of ${itemName} is ${itemType}`)


    const groups = def.groups
    if (!groups) {
      // Again, this is an error. If no groups are defined there's a problem with the item definition.
     minetest.log(LogLevel.warning, `Item ${itemName} has no defined groups!`) 
    }

    // print(dump(def))
    // print(dump(wieldedItem))
  }

  minetest.handle_node_drops = function(position: Vec3, drops: string[], digger: ObjectRef) {

    const groups = extractNodeGroups(position)

    extractWieldGroups(digger)

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