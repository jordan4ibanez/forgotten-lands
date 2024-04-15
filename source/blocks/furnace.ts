namespace blocks {

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
  const Label = formSpec.Label
  const Style = formSpec.Style

  const color = utility.color
  const colorScalar = utility.colorScalar
  const colorRGB = utility.colorRGB
  const vec3ToString = utility.vec3ToString
  const pixel = utility.pixel

  //? Functionality

  function turnTexture(input: string): string {
    return input + "^[transformR270"
  }

  function chopTexture(input: string, percent: number): string {
    return "^[lowpart:" + percent + ":" + input
  }

  function generateFurnaceFormspec(fuelPercent: number, smeltPercent: number): string {
    // Convert to 0-1 range.
    const fuelForegroundMultiplier = (minetest.is_nan(fuelPercent / 100)) ? 0 : (fuelPercent / 100) 
    // print (fuelForegroundMultiplier)
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
        //! Add a nice label to the top.
        new Label({
          position: create(5.5,0.5),
          //! Flame red foreground. 164,40,33 (Turns pink/peach)
          //? Cool blue background. 24,154,211 (Not possible yet)
          label: minetest.colorize( color(164 * fuelForegroundMultiplier, 0, 0), "Furnace")
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
        }),
        new ListRing({
          location: "current_player",
          listName: "main"
        }),
        new ListRing({
          location: "context",
          listName: "output"
        })

      ]
    }))
  }

  function startCookTimer(position: Vec3) {
    // print("start")
    const timer = minetest.get_node_timer(position)
    if (timer.is_started()) {
      // print("timer is already started")
      return
    }
    minetest.get_node_timer(position).start(0)
  }

  function continueCookTimer(position: Vec3) {
    // print("continue")
    const timer = minetest.get_node_timer(position)
    if (timer.is_started()) {
      // print("timer is already started")
      return
    }
    minetest.get_node_timer(position).start(1)
  }

  function initialPayload(inventory: InvRef, justConstructed?: boolean) {
    if (!justConstructed)  return
    print("setting up new furnace")
    inventory.set_size("input", 1)
    inventory.set_size("fuel", 1)
    inventory.set_size("output", 1)
  }

  function turnOn(position: Vec3, rotation: number) {
    minetest.swap_node(position, {name: "furnace_active", param2: rotation})
  }

  function turnOff(position:Vec3, rotation: number) {
    minetest.swap_node(position, {name: "furnace", param2: rotation})
  }

  function fuelCheck(fuelInventory: ItemStackObject[]): CraftResultObject {
    const [result,] = minetest.get_craft_result({
      method: CraftCheckType.fuel,
      width: 1,
      items: fuelInventory
    })
    
    return result
  }

  function itemCheck(inputInventory: ItemStackObject[]): CraftResultObject {
    const [result,] = minetest.get_craft_result({
      method: CraftCheckType.cooking,
      width: 1,
      items: inputInventory
    })
    return result
  }

  function outputCheck(inventory: InvRef, itemInHearth: ItemStackObject) {
    return inventory.room_for_item("output", itemInHearth)
  }

  function takeFromFuel(inventory: InvRef, fuelInventory: ItemStackObject[]) {
    fuelInventory[0].take_item(1)
    inventory.set_list("fuel", fuelInventory)
  }

  function processFuelLogic(
    hasItem: boolean,
    hasFuel: boolean,
    fuelBuffer: number,
    fuelTime: number,
    meta: MetaRef,
    inventory: InvRef,
    fuelInventory: ItemStackObject[]
  ): number {
    if (hasItem && hasFuel && fuelBuffer == -1) {
      takeFromFuel(inventory, fuelInventory)
      meta.set_int("fuelBuffer", fuelTime)
      meta.set_int("fuelMax", fuelTime)
      return fuelTime
    } else {
      meta.set_int("fuelBuffer", fuelBuffer)
      return math.clamp(0, 100000, fuelBuffer)
    }
  }

  function smeltItemLogic(
    hasItem: boolean, 
    hasRoom: boolean, 
    fuelMax: number,
    itemBuffer: number,
    itemTime: number,
    meta: MetaRef,
    inputInventory: ItemStackObject[],
    inventory: InvRef,
    outputInventory: ItemStackObject[],
    itemInHearth: CraftResultObject
  ): number {
    if (hasItem && fuelMax > 0) {
      if (itemBuffer == -1) {
        meta.set_int("itemMax", itemTime)
        meta.set_int("itemBuffer", itemTime)
        return itemTime
      } else {
        if (itemBuffer == 0 && hasRoom) {
          inputInventory[0].take_item(1)
          inventory.set_list("input", inputInventory)
          outputInventory[0].add_item(itemInHearth.item)
          inventory.set_list("output", outputInventory)
        }
        meta.set_int("itemBuffer", itemBuffer)
        return itemBuffer
      }
    } else {
      // Ran out of fuel.
      if (!hasItem) {
        meta.set_int("itemMax", -1)
      }
      meta.set_int("itemBuffer", -1)
      return -1
    }
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


    // print(`thinking at ${vec3ToString(position)}.............`)
    
    const furnaceIsActive = (currentBlock.name == "furnace_active")
    const rotation = currentBlock.param2 || 0


    // Simulate any time lost. Furnace works in 1 second intervals.
    for (let i = 0; i < elapsedTime; i++) {

      // print("run " + i)
      // print("elapsed time: " + elapsedTime)
     
      const inputInventory = inventory.get_list("input")
      const fuelInventory = inventory.get_list("fuel")
      const outputInventory = inventory.get_list("output")

      const fuelInFirebox = fuelCheck(fuelInventory)
      const fuelTime = fuelInFirebox.time
      const hasFuel = fuelTime > 0
      
      // Quick note: The item is what it would be after being cooked.
      const itemInHearth = itemCheck(inputInventory)
      const itemTime = itemInHearth.time
      const hasItem = itemInHearth.item.get_name() != ""

      const hasRoom = outputCheck(inventory, itemInHearth.item)

      const fuelBuffer = math.clamp(-1, 10000, (meta.get_int("fuelBuffer") || 0) - 1)
      const itemBuffer = math.clamp(-1, 10000, (meta.get_int("itemBuffer") || 0) - 1)

      // print("Do I have fuel? " + hasFuel)
      // print("Do I have input? " + hasItem)
      // print("My fuel buffer: " + fuelBuffer)

      // Setting the initial timer.

      const fuelProgress = processFuelLogic(hasItem, hasFuel, fuelBuffer, fuelTime, meta, inventory, fuelInventory)


      // Furnace activity continuity.
      if ((hasFuel && hasItem && hasRoom) || fuelBuffer > 0) {
        // print("continuing")
        continueCookTimer(position)
        if (!furnaceIsActive) {
          turnOn(position, rotation)
        }
      } else {
        if (furnaceIsActive) {
          turnOff(position, rotation)
          meta.set_int("fuelMax", 0)
        }
      }

      const fuelMax = meta.get_int("fuelMax") || 0

      const itemProgress = smeltItemLogic(hasItem, hasRoom, fuelMax, itemBuffer, itemTime, meta, inputInventory, inventory, outputInventory, itemInHearth)

      const itemMax = meta.get_int("itemMax") || 0

      const smeltPercent = (itemMax == -1) ? 0 : 100 - math.floor((itemProgress / itemMax) * 100)
      const fuelPercent = math.floor((fuelProgress / fuelMax) * 100)

      // print("item progress: " + itemProgress)

      meta.set_string("formspec", generateFurnaceFormspec(fuelPercent, smeltPercent))
      // meta.set_int("fuelBuffer", fuelBuffer)
      // meta.set_int("itemBuffer", itemBuffer)

      if (!hasFuel) {
        break
      }
    }
  }

  function allowPut(
    position: Vec3,
    listName: string,
    index: number,
    stack: ItemStackObject,
    player: ObjectRef
  ): number {

    //* Protection can be bolted on here.

    switch (listName) {
      case "output":
        return 0
      case "input":
        return (itemCheck([stack]).item.get_name() != "") ? stack.get_count() : 0
      case "fuel":
        return (fuelCheck([stack]).time > 0) ? stack.get_count() : 0
      default:
        return 0
    }
  }

  function allowMove(
    position: Vec3,
    fromList: string,
    fromIndex: number,
    toList: string,
    toIndex: number,
    count: number,
    player: ObjectRef
  ): number {
    const meta = minetest.get_meta(position)
    const inventory = meta.get_inventory()
    const stack = inventory.get_stack(fromList, fromIndex)
    return allowPut(position, toList, toIndex, stack, player)
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
    on_construct: function(pos: Vec3) {
      think(pos, 1, true)
    },
    on_timer: think,
    on_punch: startCookTimer,
    on_metadata_inventory_move: startCookTimer,
    on_metadata_inventory_put: startCookTimer,
    on_metadata_inventory_take: startCookTimer,
    allow_metadata_inventory_put: allowPut,
    allow_metadata_inventory_move: allowMove
  })

  minetest.register_node(":furnace_active", {
    drawtype: Drawtype.nodebox,
    paramtype2: ParamType2.facedir,
    is_ground_content: false,
    light_source: 8,
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
    on_construct: function(pos: Vec3) {
      think(pos, 1, true)
    },
    on_timer: think,
    on_punch: startCookTimer,
    on_metadata_inventory_move: startCookTimer,
    on_metadata_inventory_put: startCookTimer,
    on_metadata_inventory_take: startCookTimer,
    allow_metadata_inventory_put: allowPut,
    allow_metadata_inventory_move: allowMove
  })

}