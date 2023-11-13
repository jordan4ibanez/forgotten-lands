{
  const println = utility.println;
  const fakeObjectRef = utility.fakeObjectRef;

  let nextID = 0
  function idGenerator(): number {
    const gotten = nextID
    nextID++
    return gotten
  }

  class Cool implements LuaEntity {
    name = "flop"
    object = fakeObjectRef()
  }

  class ItemEntity implements LuaEntity {
    name = "__builtin:item"
    object = fakeObjectRef()
    timer = 0
    cool = 5
    id = -1

    on_activate(staticData: string, delta: number): void {
      this.id = idGenerator()
      print(this.cool)
      this.cool += 1
    }

    on_step(delta: number, moveResult: MoveResult): void {

    }
  }


  minetest.registerTSEntity(ItemEntity)
}