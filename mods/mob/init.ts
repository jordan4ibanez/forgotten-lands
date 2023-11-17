namespace mob {

  const fakeRef = Utility.fakeRef;

  class MobBase implements LuaEntity {
    name: string = "mob_base"
    object: ObjectRef = fakeRef()
    hp = 10
  }

  // Oh I'm looking forward to this now.
  class Cow extends MobBase {
    name = "cow"
    hp = 5
  }

}