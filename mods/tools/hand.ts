namespace Tools {

  const blockType = Types.BlockType

  minetest.override_item("", {
    wield_scale: vector.create(1,1,2.5),
    tool_capabilities: {
      full_punch_interval: 0.9,
      max_drop_level: 1,
      groupcaps: {
        [blockType.break_instant]: {
          times: {
            1: 0.1
          },
          uses: 0
        },
        [blockType.soil]: {
          times: {
            1: 2,
          },
          uses: 0
        },
        [blockType.wood]: {
          times: {
            1: 2,
          },
          uses: 0
        },
        [blockType.leaf]: {
          times: {
            1: 1,
          },
          uses: 0
        },
        [blockType.stone]: {
          times: {
            0: 5.0,
            1: 10.0,
            2: 20.0,
            3: 30.0,
            4: 40.0
          },
          maxlevel: 0,
          maxdrop: 0,
          uses: 0
        },
        [blockType.metal]: {
          times: {
            0: 5.0,
            1: 10.0,
            2: 20.0,
            3: 30.0,
            4: 40.0
          },
          maxlevel: 0,
          maxdrop: 0,
          uses: 0
        },
        [blockType.glass]: {
          times: {
            0: 5.0,
            1: 10.0,
            2: 20.0,
            3: 30.0,
            4: 40.0
          },
          maxlevel: 0,
          uses: 0
        },
        [blockType.wool]: {
          times: {
            1: 0.4,
            2: 0.7,
            3: 1.5,
            4: 4.5
          },
          uses: 0
        }
      },
      damage_groups: {
        // Needs a better group name.
        fleshy: 1
      }
    }
  })
}