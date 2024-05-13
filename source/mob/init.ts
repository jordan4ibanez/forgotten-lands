namespace mob {

  const loadFiles = utility.loadFiles;
  const AnimatedEntity = animationStation.AnimatedEntity;

  export class Mob extends AnimatedEntity {
    name: string = "mob_base";

    hp = 10;

    on_step(delta: number, moveResult: MoveResult): void {
      print("Not implemented");
    }
  }


  loadFiles(["pig", "death_knell"]);

}