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

  // Silly helper functions, might make these global soon.
  function turnIt(input: string): string {
    return input + "^[transformR90"
  }
  function turnItMore(input: string): string {
    return input + "^[transformR180"
  }
  function turnItMost(input: string): string {
    return input + "^[transformR270"
  }
  function flipIt(input: string): string {
    return input + "^[transformFX"
  }

  print("Diamond needs a better texture! It's a sad lump at the moment.")

  const craftItems: {[id: string] : ItemDefinition} = {
    ":stick": {
      wield_scale: wieldScale,
      inventory_image: "default_stick.png",
    },
    ":iron": {
      wield_scale: wieldScale,
      inventory_image: flipIt("default_steel_ingot.png")
    },
    ":diamond": {
      wield_scale: wieldScale,
      inventory_image: "default_diamond.png"
    }
  }
  
  processCraftItemArray(craftItems)
}