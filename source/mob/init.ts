namespace mob {

  const fakeRef = utility.fakeRef;
  const loadFiles = utility.loadFiles;

  class MobBase implements LuaEntity {
    name: string = "mob_base"
    object: ObjectRef = fakeRef()
    hp = 10

    on_step(delta: number, moveResult: MoveResult): void {
      print("Not implemented");
    }
  }

  // Oh I'm looking forward to this now.
  class Cow extends MobBase {
    name = "cow"
    hp = 5

    on_step(delta: number, moveResult: MoveResult): void {
      // print("I'm a cow, moo");
    }
  }

  minetest.registerTSEntity(Cow);

}