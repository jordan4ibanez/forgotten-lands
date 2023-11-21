namespace blocks {


  const textureSize = 16
  const MAIN_INVENTORY_SIZE = player.MAIN_INVENTORY_SIZE
  const create = vector.create2d
  const generate = formSpec.generate
  const FormSpec = formSpec.FormSpec
  const BackGround = formSpec.Background
  const Image = formSpec.Image
  const BGColor = formSpec.BGColor
  const List = formSpec.List
  const ListColors = formSpec.ListColors
  const ListRing = formSpec.ListRing

  const color = utility.color
  const colorScalar = utility.colorScalar
  const colorRGB = utility.colorRGB
  const vec3ToString = utility.vec3ToString

  //? Functionality

  function turnTexture(input: string): string {
    return input + "^[transformR270"
  }

  function chopTexture(input: string, percent: number): string {
    return "^[lowpart:" + percent + ":" + input
  }

  function generateFurnaceFormspec(fuelPercent: number, smeltPercent: number): string {
    return generate(new FormSpec({
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
        //! Flame.
        new Image({
          position: create(
            3,
            2.5
          ),
          size: create(
            1,
            1
          ),
          texture: "default_furnace_fire_bg.png" + chopTexture("default_furnace_fire_fg.png", fuelPercent) + "]"
        }),
        //! Arrow.
        new Image({
          position: create(
            5.5,
            2.5
          ),
          size: create(
            1,
            1
          ),
          texture: turnTexture("gui_furnace_arrow_bg.png" + chopTexture("gui_furnace_arrow_fg.png", smeltPercent)) + "]"
        }),
        //! Fuel.
        new List({
          location: "context",
          listName: "fuel",
          position: create(
            3,
            4
          ),
          size: create(
            1,
            1
          ),
          startingIndex: 0
        }),
        //! Input.
        new List({
          location: "context",
          listName: "input",
          position: create(
            3,
            1
          ),
          size: create(
            1,
            1
          ),
          startingIndex: 0
        }),
        //! Output.
        new List({
          location: "context",
          listName: "output",
          position: create(
            8,
            2.5
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
          location: "context",
          listName: "fuel"
        }),
        new ListRing({
          location: "current_player",
          listName: "main"
        }),
        new ListRing({
          location: "context",
          listName: "input"
        })

      ]
    }))
  }

  function initialPayload(inventory: InvRef, justConstructed?: boolean) {
    if (!justConstructed)  return
    print("setting up new furnace")
    inventory.set_size("input", 1)
    inventory.set_size("fuel", 1)
    inventory.set_size("output", 1)
  }

  function turnOn(position: Vec3) {
    minetest.swap_node(position, {name: "furnace_active"})
  }

  function turnOff(position:Vec3) {
    minetest.swap_node(position, {name: "furnace"})
  }

  function fuelCheck(fuelInventory: ItemStackObject[]): CraftResultObject {
    const result = minetest.get_craft_result({
      method: CraftCheckType.fuel,
      width: 1,
      items: fuelInventory
    })
    
    return result as CraftResultObject
  }

  function think(position: Vec3, elapsedTime: number, justConstructed?: boolean) {

    const currentBlock = minetest.get_node_or_nil(position)
    if (!currentBlock || currentBlock.name == "ignore") {
      print("Furnace: Error, tried to do work on null object.")
      return false
    }

    const meta = minetest.get_meta(position)
    const inventory = meta.get_inventory()

    initialPayload(inventory, justConstructed)


    print(`thinking at ${vec3ToString(position)}.............`)
    
    const currentlyActive = (currentBlock.name == "furnace_active")


    // Simulate any time lost. Furnace works in 1 second intervals.
    for (let i = 0; i <= elapsedTime; i++) {
      print("run " + i)
      print("elapsed time: " + elapsedTime)
     
      const inputInventory = inventory.get_list("input")
      const fuelInventory = inventory.get_list("fuel")
      const outputInventory = inventory.get_list("output")

      const fuelInFirefox = fuelCheck(fuelInventory)
      const hasFuel = fuelInFirefox.time > 0

      

      const fuelBuffer = meta.get_int("fuelBuffer") | 0

      print("Do I have fuel? " + hasFuel)
      print("My fuel buffer: " + fuelBuffer)

      const smeltPercent = 50
      const fuelPercent = 50//100 - math.floor((fuelTime / fuelTotalTime) * 100)

      meta.set_string("formspec", generateFurnaceFormspec(fuelPercent, smeltPercent))
      meta.set_int("fuelBuffer", (fuelBuffer <= 0) ? 0 : fuelBuffer - 1)

      if (!hasFuel) {
        break
      }
    }
  }

  //! This should probably be a utility function.
  function pixel(inputPixel: number): number {
    return (inputPixel / textureSize) - 0.5
  }

  function startTimer(position: Vec3) {
    minetest.get_node_timer(position).start(1)
  }

  function allowPut() {
    // todo
  }


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
    on_punch: function(pos: Vec3){
      think(pos, 0, true)
    },
    on_construct(position: Vec3) {
      // print(dump(position))
      think(position, 0, true)
    },
    on_metadata_inventory_move: startTimer,
    on_metadata_inventory_put: startTimer,
    on_metadata_inventory_take: startTimer
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
    ],
    on_timer: think,
    on_punch: function(pos: Vec3){
      think(pos, 0, true)
    },
    on_construct(position: Vec3) {
      think(position, 0, true)
    },
    on_metadata_inventory_move: startTimer,
    on_metadata_inventory_put: startTimer,
    on_metadata_inventory_take: startTimer
  })

}