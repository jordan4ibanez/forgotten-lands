namespace player {

  export const INVENTORY_SIZE = vector.create2d(9,4)

  const create = vector.create2d
  const generate = formSpec.generate
  const FormSpec = formSpec.FormSpec
  const BackGround = formSpec.Background
  const BGColor = formSpec.BGColor
  const List = formSpec.List
  const color = utility.color
  const colorScalar = utility.colorScalar

  const playerInventory: string = generate(new FormSpec({
    size: create(12,12),
    elements: [
      new BGColor({
        bgColor: colorScalar(85),
        fullScreen: "both",
        fullScreenbgColor: colorScalar(0,30)
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
          2.25
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
    newPlayer.get_inventory().set_size("main", INVENTORY_SIZE.x * INVENTORY_SIZE.y)
    newPlayer.set_inventory_formspec(playerInventory)
  })

}