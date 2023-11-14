namespace Blocks {
  const sounds = Sounds;

  for (let i = 1; i <= 5; i++) {
    minetest.register_node(":tall_grass_" + i, {
      drawtype: Drawtype.plantlike,
      walkable: false,
      waving: 1,
      paramtype: ParamType1.light,
      paramtype2: ParamType2.degrotate,
      tiles: ["default_grass_" + i + ".png"],
      buildable_to: true,
      sounds: sounds.plant(),
      groups: {
        break_instant: 1
      },
      drop: ""
    })
  }

  const modDirectory = minetest.get_modpath("blocks")
  for (const file of ["normal"]) {
    dofile(modDirectory + "/" + file + ".lua")
  }
}