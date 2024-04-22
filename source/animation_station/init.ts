namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["master_containers"]);

  let repository = new ModelContainer();

  //! This is hardcoded because I'm prototyping per-bone animation.

  type BoneState = animationStation.BoneState;

  /**
   * Holds all the bone states for players.
   */
  class PlayerState {
    boneStates: Map<string, BoneState> = new Map();
    constructor() {
      // for (let i = 0; i < 100; i++) {
      //   print(i);
      // }
      //! Hardcoded-ness starts here. We simply iterate the character.b3d bones.
      const characterBones = repository.bones.get("character.b3d");

      if (characterBones == null) {
        error("Tried to create a player state without character.b3d bones registered!");
      }

      characterBones.forEach((value: string) => {
        print(value);
      });
    }
  }

  //? Expose the functional interface.
  export function registerAnimation(modelName: string, animationName: string, definition: BoneContainer): void {
    repository.registerAnimation(modelName, animationName, definition);
  }
  export function registerBones(modelName: string, bones: Set<string>): void {
    repository.registerBones(modelName, bones);
  }

  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    new PlayerState();
  });

  // registerAnimation("test.b3d", "walk", {
  //   bones: new Map([
  //     ["leg", {
  //       start: {
  //         translation: create3d(),
  //         rotation: create3d(),
  //         scale: create3d(),
  //       },
  //       end: {
  //         translation: create3d(),
  //         rotation: create3d(),
  //         scale: create3d(),
  //       }
  //     }]
  //   ])
  // });
}