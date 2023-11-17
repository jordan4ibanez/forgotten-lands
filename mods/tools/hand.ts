namespace tools {

  const blockType = types.BlockType


  //! NOTE: Do not ever add element 0 to times!

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
            1: 4.0,
            2: 6.0,
            3: 8.0,
            4: 10.0
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