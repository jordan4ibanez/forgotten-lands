{
  const println = utility.println;
  const fakeRef = utility.fakeRef;

  class ItemEntity implements LuaEntity {
    name = "__builtin:item"
    object = fakeRef()
    itemString = ""
    movingState = false
    physicalState = false
    age = 0
    forceOut = vector.create()
    on_activate(staticData: string, delta: number): void {

    }
    on_step(delta: number, moveResult: MoveResult): void {
    }
  }


  minetest.registerTSEntity(ItemEntity)
}