namespace Items {
  const craftRegister = minetest.register_craftitem;
  const wieldScale = Tools.wieldScale;


  /**
   * Easily register a dictionary of craft items.
   * @param inputArray Key value assignment of craftitems to be registered.
   */
  export function processCraftItemArray(inputArray: {[id: string] : ItemDefinition}) {
    for (const [name, definition] of Object.entries(inputArray)) {
      craftRegister(name, definition)
    }
  }

  const craftItems: {[id: string] : ItemDefinition} = {
    ":stick": {
      wield_scale: wieldScale,
      inventory_image: "default_stick.png",
    }
  }
  
  processCraftItemArray(craftItems)
}