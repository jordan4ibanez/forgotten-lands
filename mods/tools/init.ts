namespace Tools {
  // Alphabetical ordering, A = 1, B = 2, etc
  export enum Pickaxe {
    A = "pickaxe_1",
    B = "pickaxe_2",
    C = "pickaxe_3",
    D = "pickaxe_4",
    E = "pickaxe_5"
  }

  minetest.register_tool(":pickaxe", {
    inventory_image: "default_tool_stonepick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 1,
      groupcaps: {
        stone: {
          times: {
            1: 1.0
          },
          maxlevel: 1,
          maxdrop: 0
        }
      }
    },
    groups: {
      [Pickaxe.A]: 1
    }
  })
}