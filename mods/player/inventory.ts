namespace player {

  const create = vector.create2d
  const generate = formSpec.generate
  const FormSpec = formSpec.FormSpec
  const BackGround = formSpec.Background
  const BGColor = formSpec.BGColor
  const List = formSpec.List
  const color = utility.color

  print(color(1,2,3))

  const playerInventory: string = generate(new FormSpec({
    size: create(12,12),
    elements: [
      new BGColor({
        bgColor: color(80,80,80),
        fullScreen: "both",
        fullScreenbgColor: color(0,0,0,20)
      }),
      //! Craft area.
      new List({
        location: "current_player",
        listName: "craft",
        position: create(
          1.5,
          1.5
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
          8,
          2.25
        ),
        size: create(
          1,
          1
        ),
        startingIndex: 0
      }),
      //! Main inventory.
      new List({
        location: "current_player",
        listName: "main",
        position: create(
          1,
          6
        ),
        size: create(
          8,
          4
        ),
        startingIndex: 0
      }),
    ]
  }))

  minetest.register_on_joinplayer((player: ObjectRef) => {
    player.set_inventory_formspec(playerInventory)
  })

}