namespace player {

  export const INVENTORY_SIZE = vector.create2d(9,4)

  const create = vector.create2d

  const generate = formSpec.generate
  const FormSpec = formSpec.FormSpec
  const BackGround = formSpec.Background
  const BGColor = formSpec.BGColor
  const List = formSpec.List
  const ListColors = formSpec.ListColors

  const color = utility.color
  const colorScalar = utility.colorScalar
  const colorRGB = utility.colorRGB

  const playerInventory: string = generate(new FormSpec({
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
        location: "current_player",
        listName: "craft",
        position: create(
          5.5,
          1.75
        ),
        size: create(
          2,
          2
        ),
        startingIndex: 0
      }),
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
          INVENTORY_SIZE.x,
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
          INVENTORY_SIZE.x,
          INVENTORY_SIZE.y - 1
        ),
        startingIndex: INVENTORY_SIZE.x
      })
    ]
  }))

  minetest.register_on_joinplayer((newPlayer: ObjectRef) => {
    newPlayer.hud_set_hotbar_itemcount(INVENTORY_SIZE.x)
    newPlayer.get_inventory().set_size("main", INVENTORY_SIZE.x * INVENTORY_SIZE.y)
    newPlayer.set_inventory_formspec(playerInventory)
  })

}