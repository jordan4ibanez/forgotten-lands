namespace mob {

  const create3d = vector.create3d;

  // Oh I'm looking forward to this now.
  class Pig extends Mob {
    name = "pig";
    hp = 5;

    initial_properties: ObjectProperties = {
      visual: EntityVisual.mesh,
      mesh: "mobs_mc_pig.b3d",
      textures: ["blank.png", "mobs_mc_pig.png", "mobs_mc_pig.png"],
      visual_size: create3d(3, 3, 3)
    };

    on_step(delta: number, moveResult: MoveResult): void {
      print("Oink");
    }
  }

  utility.registerTSEntity(Pig);
}