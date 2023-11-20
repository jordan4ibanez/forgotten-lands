namespace blocks {


  const textureSize = 16
  const MAIN_INVENTORY_SIZE = player.MAIN_INVENTORY_SIZE
  const create = vector.create2d
  const generate = formSpec.generate
  const FormSpec = formSpec.FormSpec
  const BackGround = formSpec.Background
  const BGColor = formSpec.BGColor
  const List = formSpec.List
  const ListColors = formSpec.ListColors
  const ListRing = formSpec.ListRing

  const color = utility.color
  const colorScalar = utility.colorScalar
  const colorRGB = utility.colorRGB

  function think(position: Vec3, elapsed: number) {
    print("thinking")
  }

  //? Functionality

  //! This should probably be a utility function.
  function pixel(inputPixel: number): number {
    return (inputPixel / textureSize) - 0.5
  }


  const furnaceInventory: string = generate(new FormSpec({
    size: create(12,12),
    elements: [
      //! Nice background colors.
      new BGColor({
        bgColor: colorScalar(85),
        fullScreen: "both",
        fullScreenbgColor: colorScalar(0,40)
      }),
      //! Make these lists look nice as well.
      new ListColors({
        slotBGHover: colorScalar(70),
        slotBGNormal: colorScalar(55),
        slotBorder: colorScalar(0),
        toolTipBGColor: colorRGB(123,104,238),
        toolTipFontColor: colorScalar(100)
      }),
      //todo: this will be the fuel and cooking portion
      // //! Craft area.
      // new List({
      //   location: "current_player",
      //   listName: "craft",
      //   position: create(
      //     5.5,
      //     1.75
      //   ),
      //   size: CRAFT_INVENTORY_SIZE,
      //   startingIndex: 0
      // }),
      //! Craft output
      new List({
        location: "current_player",
        listName: "craftpreview",
        position: create(
          9,
          2.375
        ),
        size: create(
          1,
          1
        ),
        startingIndex: 0
      }),
      //! Hot bar.
      new List({
        location: "current_player",
        listName: "main",
        position: create(
          0.5,
          6.5
        ),
        size: create(
          MAIN_INVENTORY_SIZE.x,
          1
        ),
        startingIndex: 0
      }),
      //! Main inventory.
      new List({
        location: "current_player",
        listName: "main",
        position: create(
          0.5,
          8
        ),
        size: create(
          MAIN_INVENTORY_SIZE.x,
          MAIN_INVENTORY_SIZE.y - 1
        ),
        startingIndex: MAIN_INVENTORY_SIZE.x
      }),
      //! List Rings.
      new ListRing({
        location: "current_player",
        listName: "main"
      }),
      new ListRing({
        location: "current_player",
        listName: "craft"
      })
    ]
  }))


  //? Visuals

  const furnaceNodeBox: NodeBox = {
    type: Nodeboxtype.fixed,
    fixed:[
      [ // Left slice.
        pixel(0),pixel(0),pixel(0),
        pixel(2),pixel(16),pixel(16)
      ],
      [ // Right slice.
        pixel(14),pixel(0),pixel(0),
        pixel(16),pixel(16),pixel(16)
      ],
      [ // Top slice.
        pixel(0),pixel(13),pixel(0),
        pixel(16),pixel(16),pixel(16)
      ],
      [ // Center slice.
        pixel(0),pixel(6),pixel(0),
        pixel(16),pixel(9),pixel(16)
      ],
      [ // Bottom slice.
        pixel(0),pixel(0),pixel(0),
        pixel(16),pixel(1),pixel(16)
      ],
      [ // Inner core.
        pixel(0),pixel(0),pixel(2),
        pixel(16),pixel(16),pixel(16)
      ],
    ] 
  }

  const furnaceSelectionBox: NodeBox = {
    type: Nodeboxtype.fixed,
    fixed: [
      [pixel(0),pixel(0),pixel(0),pixel(16),pixel(16),pixel(16)]
    ]
  }

  //? Implementation

  minetest.register_node(":furnace", {
    drawtype: Drawtype.nodebox,
    paramtype2: ParamType2.facedir,
    is_ground_content: false,
    node_box: furnaceNodeBox,
    selection_box: furnaceSelectionBox,
    groups: {
      stone: 1
    },
    sounds: sounds.stone(),
    tiles: [
      "default_furnace_top.png",
      "default_furnace_bottom.png",
		  "default_furnace_side.png",
      "default_furnace_side.png",
		  "default_furnace_side.png",
      "default_furnace_front.png"
    ],
    on_timer: think,
    on_construct(position: Vec3) {
      print(dump(position))
      const meta = minetest.get_meta(position)
      const inventory = meta.get_inventory()
      inventory.set_size("source", 1)
      inventory.set_size("fuel", 1)
      inventory.set_size("destination", 1)
      meta.set_string("formspec", furnaceInventory)
    }
  })

  minetest.register_node(":furnace_active", {
    drawtype: Drawtype.nodebox,
    paramtype2: ParamType2.facedir,
    is_ground_content: false,
    node_box: furnaceNodeBox,
    selection_box: furnaceSelectionBox,
    groups: {
      stone: 1
    },
    sounds: sounds.stone(),
    tiles: [
      "default_furnace_top.png",
      "default_furnace_bottom.png",
		  "default_furnace_side.png",
      "default_furnace_side.png",
		  "default_furnace_side.png",
      "default_furnace_front_active.png"
    ]
  })

}