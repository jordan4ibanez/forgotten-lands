namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["master_containers"]);

  /**
   * Holds all the model animation information.
   */
  let repository = new ModelContainer();

  //! This is hardcoded because I'm prototyping per-bone animation.

  type BoneState = animationStation.BoneState;

  /**
   * Holds all the bone states for players.
   */
  class PlayerState {
    boneStates: Map<string, BoneState> = new Map();

    constructor() {
      //! Hardcoded-ness starts here. We simply iterate the character.b3d bones.
      const characterBones = repository.bones.get("character.b3d");

      if (characterBones == null) {
        error("Tried to create a player state without [character.b3d] bones registered!");
      }

      characterBones.forEach((bone: string) => {
        // print("setting bone: " + bone);
        this.boneStates.set(bone, {
          animation: "",
          progress: 0
        });
      });
    }
  }

  let playerRepository: Map<string, PlayerState> = new Map();

  //? Expose the functional interface.
  export function registerAnimation(modelName: string, animationName: string, definition: BoneContainer): void {
    repository.registerAnimation(modelName, animationName, definition);
  }
  export function registerBones(modelName: string, bones: Set<string>): void {
    repository.registerBones(modelName, bones);
  }

  // When a player joins, add them to the player repository.
  minetest.register_on_joinplayer((player: ObjectRef) => {
    const name = player.get_player_name();
    playerRepository.set(name, new PlayerState());
  });
  // When a player leaves, remove them from the player repository.
  minetest.register_on_leaveplayer((player: ObjectRef) => {
    const name = player.get_player_name();
    playerRepository.delete(name);
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