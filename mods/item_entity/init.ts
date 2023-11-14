{
  const println = utility.println;
  const fakeRef = utility.fakeRef;

  class ItemEntity implements LuaEntity {
    name = "__builtin:item"
    object = fakeRef()
    itemString = ""
    movingState = true
    physicalState = true
    age = 0
    forceOut = vector.create()
    forceOutStart = vector.create()
    droppedBy = ""
    // Magnet components.
    collected = false

    initial_properties = {
      hp_max: 1,
      physical:  true,
      collide_with_objects:  false,
      collisionbox:  [-0.3, -0.3, -0.3, 0.3, 0.3, 0.3],
      visual: EntityVisual.cube,
      visual_size: vector.create2d(),
      textures:  [""],
      is_visible:  false,
      pointable:  false
    }

    setItem(item: ItemStackObject | string): void {
      const stack = ItemStack(item || this.itemString)
      this.itemString = stack.to_string()
      if (this.itemString == "") {
        // Item is unknown.
        return
      }

      const itemName: string = (stack.is_known() && stack.get_name()) || "unknown"
      const size = 0.21
      const def = minetest.registered_items[itemName]
      const glow = def && def.light_source && math.floor(def.light_source / 2 + 0.5)
      
      // Small random bias to counter Z-fighting.
      const sizeBias = 1e-3 * math.random()

      const c = [-size, -size, -size, size, size, size]

      this.object.set_properties({
        is_visible: true
      })




    }

    on_activate(staticData: string, delta: number): void {

    }
    on_step(delta: number, moveResult: MoveResult): void {
    }
  }


  minetest.registerTSEntity(ItemEntity)
}