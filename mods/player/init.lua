minetest.override_item("", {
   wield_scale = { x = 1, y = 1, z = 2.5 },
   tool_capabilities = {
      full_punch_interval = 0.9,
      max_drop_level = 1,
      groupcaps = {
         break_instant = {
            times = {
               0.1,
            },
            uses = 0,
         },
         soil = {
            times = {
               0.4,
               0.7,
               1.5,
               4.5,
            },
            uses = 0,
         },
         wooden = {
            times = {
               1.5,
               4.0,
               8.0,
               14.0,
            },
            uses = 0,
         },
         leafy = {
            times = {
               0.3,
               0.6,
               0.9,
               1.2,
            },
            uses = 0,
         },
         stone = {
            times = {
               0.7,
               2.0,
               3.5,
               8.0,
            },
            uses = 0,
         },
         metal = {
            times = {
               1.5,
               4.0,
               8.0,
               14.0,
            },
            uses = 0,
         },
         glass = {
            times = {
               1.0,
               3.0,
               6.0,
               9.0,
            },
            uses = 0,
         },
         wool = {
            times = {
               0.4,
               0.7,
               1.5,
               4.5,
            },
            uses = 0,
         },
      },
      damage_groups = {

         fleshy = 1,
      },
   },
})
