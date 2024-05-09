namespace mob {

  // Oh I'm looking forward to this now.
  class Cow extends Mob {
    name = "cow";
    hp = 5;

    on_step(delta: number, moveResult: MoveResult): void {
      // print("I'm a cow, moo");
    }
  }

  minetest.registerTSEntity(Cow);
}