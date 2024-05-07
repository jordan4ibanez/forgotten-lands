namespace mob {
  
  const loadFiles = utility.loadFiles;
  const AnimatedEntity = animationStation.AnimatedEntity;

  class Mob extends AnimatedEntity {
    name: string = "mob_base";

    hp = 10;

    on_step(delta: number, moveResult: MoveResult): void {
      print("Not implemented");
    }
  }

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