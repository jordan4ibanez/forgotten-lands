
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
  const playerRegularCraftSize = player.CRAFT_INVENTORY_SIZE

  const WORKBENCH_INVENTORY_SIZE = create(3, 3)


  const workBenchInventory: string = generate(new FormSpec({
    size: create(12, 12),
    elements: [
      //! Nice background colors.
      new BGColor({
        bgColor: colorScalar(85),
        fullScreen: "both",
        fullScreenbgColor: colorScalar(0, 40)
      }),
      //! Make these lists look nice as well.
      new ListColors({
        slotBGHover: colorScalar(70),
        slotBGNormal: colorScalar(55),
        slotBorder: colorScalar(0),
        toolTipBGColor: colorRGB(123, 104, 238),
        toolTipFontColor: colorScalar(100)
      }),
      //! Craft area.
      new List({
        location: "current_player",
        listName: "craft",
        position: create(
          4,
          1.125
        ),
        size: WORKBENCH_INVENTORY_SIZE,
        startingIndex: 0
      }),
      //! Craft craftpreview
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
      }),
      new ListRing({
        location: "current_player",
        listName: "main"
      }),
      new ListRing({
        location: "current_player",
        listName: "craftpreview"
      })
    ]
  }))

  // function allowPut(
  //   position: Vec3,
  //   listName: string,
  //   index: number,
  //   stack: ItemStackObject,
  //   player: ObjectRef
  // ): number {
  //   switch (listName) {
  //     case "craftpreview":
  //       return 0
  //     default:
  //       return stack.get_count()
  //   }
  // }

  // function workBenchLogic(position: Vec3, listName: string) {
  //   const meta = minetest.get_meta(position)
  //   const inventory = meta.get_inventory()
  //   const craftArea = inventory.get_list("craft")

  //   const [result, leftOver] = minetest.get_craft_result({
  //     method: CraftCheckType.normal,
  //     width: WORKBENCH_INVENTORY_SIZE.x,
  //     items: craftArea
  //   })

  //   inventory.set_list("craftpreview", [result.item])

  //   // If user takes from the craftpreview, the craft has been finalized. Take the items.
  //   if (listName == "craftpreview") {
  //     inventory.set_list("craft", leftOver.items)
  //     // Now recurse 1 deep to update the craftpreview slot.
  //     workBenchLogic(position, "")
  //   }
  // }


  // function workBenchPut(
  //   position: Vec3,
  //   listName: string,
  //   index: number,
  //   stack: ItemStackObject,
  //   player: ObjectRef
  //  ) {
  //   workBenchLogic(position, listName)
  // }

  // function workBenchMove(
  //   position: Vec3,
  //   fromList: string,
  //   fromIndex: number,
  //   toList: string,
  //   toIndex: number,
  //   count: number,
  //   player: ObjectRef
  // ) {
  //   workBenchLogic(position, toList)
  // }

  // function workBenchTake(
  //   position: Vec3,
  //   listName: string,
  //   index: number,
  //   stack: ItemStackObject,
  //   player: ObjectRef
  // ) {
  //   workBenchLogic(position, listName)
  // }


  minetest.register_node(":workbench", {
    drawtype: utility.Drawtype.normal,
    tiles: [
      "crafting_workbench_top.png",
      "default_wood.png",
      "crafting_workbench_side.png"
    ],
    sounds: sounds.wood(),
    groups: {
      [blockType.wood]: 1
    },

    //! Fixme: Make a persistent inventory. :(
    on_rightclick(position: Vec3, node: NodeTable, clicker: ObjectRef, itemStack: ItemStackObject, pointedThing: PointedThing) {
      const inventory = clicker.get_inventory()
      inventory.set_size("craft", WORKBENCH_INVENTORY_SIZE.x * WORKBENCH_INVENTORY_SIZE.y)
      inventory.set_width("craft", WORKBENCH_INVENTORY_SIZE.x)
    },

    on_receive_fields(position: Vec3, formName: string, fields: { [id: string]: any }, sender: ObjectRef) {
      // Just throw the items for now.
      const inventory = sender.get_inventory()
      const playerPos = sender.get_pos()
      playerPos.y += 1.5
      const yaw = sender.get_look_horizontal()

      const items = inventory.get_list("craft")
      for (const item of items) {
        if (item.is_empty()) continue
        const stackSize = item.get_count()
        const itemName = item.get_name()
        for (let i = 0; i < stackSize; i++) {
          const item = minetest.add_item(playerPos, itemName)
          if (!item) {
            continue
          }
          const dir = vector.multiply(minetest.yaw_to_dir(yaw + ((math.random() - 0.5) * 1.25)), 2 + math.random())
          dir.y = 1 + (math.random() * 3)
          item.add_velocity(dir)
        }
      }
      inventory.set_list("craft", [])
      inventory.set_size("craft", playerRegularCraftSize.x * playerRegularCraftSize.y)
      inventory.set_width("craft", playerRegularCraftSize.x)
    },

    on_construct(position: Vec3) {
      const meta = minetest.get_meta(position)
      // const inventory = meta.get_inventory()
      meta.set_string("formspec", workBenchInventory)
      // inventory.set_size("craft", WORKBENCH_INVENTORY_SIZE.x * WORKBENCH_INVENTORY_SIZE.y)
      // inventory.set_width("craft", WORKBENCH_INVENTORY_SIZE.x)
    },
  })
}