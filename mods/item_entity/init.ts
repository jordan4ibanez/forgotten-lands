{
  const println = utility.println;
  const fakeObjectRef = utility.fakeObjectRef;

  class ItemEntity implements LuaEntity {
    name = "__builtin:item"
    object = fakeObjectRef()
    on_activate(staticData: string, delta: number): void {
    }
    on_step(delta: number, moveResult: MoveResult): void {
    }
  }


  minetest.registerTSEntity(ItemEntity)
}