namespace Player {
  minetest.override_item("", {
    wield_scale: vector.create(1,1,2.5),
    tool_capabilities: {
      full_punch_interval: 0.9,
      max_drop_level: 1,
      groupcaps: {
        break_instant: {
          times: {
            1: 0.1
          },
          uses: 0
        },
        soil: {
          times: {
            1: 0.4,
            2: 0.7,
            3: 1.5,
            4: 4.5
          },
          uses: 0
        },
        wooden: {
          times: {
            1: 1.5,
            2: 4.0,
            3: 8.0,
            4: 14.0
          },
          uses: 0
        },
        leafy: {
          times: {
            1: 0.3,
            2: 0.6,
            3: 0.9,
            4: 1.2
          },
          uses: 0
        },
        stone: {
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
        metal: {
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
        glass: {
          times: {
            1: 1.0,
            2: 3.0,
            3: 6.0,
            4: 9.0
          },
          maxlevel: 0,
          uses: 0
        },
        wool: {
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