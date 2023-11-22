namespace blocks {

  const create = vector.create2d

  const blockType = types.BlockType;
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

  const playerInventorySize = player.MAIN_INVENTORY_SIZE

  export const WORKBENCH_INVENTORY_SIZE = create(3,3)
  

  const workBenchInventory: string = generate(new FormSpec({
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
      //! Craft area.
      new List({
        location: "context",
        listName: "craft",
        position: create(
          5.5,
          1.75
        ),
        size: WORKBENCH_INVENTORY_SIZE,
        startingIndex: 0
      }),
      //! Craft output
      new List({
        location: "context",
        listName: "output",
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
          playerInventorySize.x,
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
          playerInventorySize.x,
          playerInventorySize.y - 1
        ),
        startingIndex: playerInventorySize.x
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

  minetest.register_node(":workbench", {
    drawtype: Drawtype.normal,
    tiles: [
      "default_wood.png"
    ],
    sounds: sounds.wood(),
    groups: {
      [blockType.wood]: 1
    },

    on_construct(position: Vec3) {
      const meta = minetest.get_meta(position)
      const inventory = meta.get_inventory()
      meta.set_string("formspec", workBenchInventory)
      inventory.set_size("craft", WORKBENCH_INVENTORY_SIZE.x * WORKBENCH_INVENTORY_SIZE.y)
      inventory.set_width("craft", WORKBENCH_INVENTORY_SIZE.x)
      inventory.set_size("output", 1)
      inventory.set_width("output", 1)
    }
  })
}