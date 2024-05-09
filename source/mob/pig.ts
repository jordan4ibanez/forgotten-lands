namespace mob {

  // Oh I'm looking forward to this now.
  class Pig extends Mob {
    name = "pig";
    hp = 5;

    on_step(delta: number, moveResult: MoveResult): void {
      print("Oink");
    }
  }

  minetest.registerTSEntity(Pig);
}