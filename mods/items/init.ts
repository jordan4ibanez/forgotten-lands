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
  function bopIt(): void {
    
  }

  const craftItems: {[id: string] : ItemDefinition} = {
    ":stick": {
      wield_scale: wieldScale,
      inventory_image: "default_stick.png",
    },
    ":coal": {
      wield_scale: wieldScale,
      inventory_image: "default_coal_lump.png"
    },
    ":iron": {
      wield_scale: wieldScale,
      inventory_image: flipIt("default_steel_ingot.png")
    },
    //! fixme: where is gold?
    ":diamond": {
      wield_scale: wieldScale,
      inventory_image: "default_diamond.png"
    },
    ":mese": {
      wield_scale: wieldScale,
      inventory_image: "default_mese_crystal.png"
    }
  }
  
  processCraftItemArray(craftItems)
}