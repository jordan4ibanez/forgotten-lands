import { Drawtype, Nodeboxtype, ParamType1, ParamType2 } from "../utility/enums";

namespace blocks {
  const blockType = types.BlockType;
  const pixel = utility.pixel
  const create = vector.create

  const grassSize: {[id: number] : Vec3} = {
    // Start, height, end
    1: create(3, 3, 13),
    2: create(3, 5, 13),
    3: create(3, 6, 13),
    4: create(2, 7, 14),
    5: create(2, 8, 14),
  }

  for (let i = 1; i <= 5; i++) {

    const size = grassSize[i]

    const collisionBox: boxTable = 
    [[
      pixel(size.x), pixel(0), pixel(size.x),
      pixel(size.z), pixel(size.y), pixel(size.z),
    ]]

    minetest.register_node(":tall_grass_" + i, {
      drawtype: Drawtype.plantlike,
      walkable: false,
      waving: 1,
      paramtype: ParamType1.light,
      paramtype2: ParamType2.degrotate,
      tiles: ["default_grass_" + i + ".png"],
      buildable_to: true,
      sounds: sounds.plant(),
      collision_box: {
        type: Nodeboxtype.fixed,
        fixed: collisionBox
      },
      selection_box: {
        type: Nodeboxtype.fixed,
        fixed: collisionBox
      },
      groups: {
        [blockType.break_instant]: 1,
        attached_node: 1
      },
      drop: ""
    })
  }

  utility.loadFiles(["normal", "ores", "furnace", "workbench"])
}