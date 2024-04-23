namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["master_containers"]);

  const BoneOverrideWorker = animationStation.BoneOverrideWorker;

  //? Workers
  // let overrideStart: BoneOverrideWorker = new BoneOverrideWorker();
  // let overrideEnd: BoneOverrideWorker = new BoneOverrideWorker();

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
          progress: 0,
          speed: 1,
          up: true,
          newAnimationTrigger: true
        });
      });
    }
  }

  /**
   * Player Repository holds all the player bone states because:
   * - the player is userdata, not an object. >:(
   */
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

  //? We have to process player animation separately as the player is not an object.
  function processPlayerAnimations(player: ObjectRef, delta: number): void {
    const name: string = player.get_player_name();
    let playerContainer = playerRepository.get(name);
    if (playerContainer == null) {
      warning("Processing player animation failed! Nonexistent. Creating then aborting.");
      playerRepository.set(name, new PlayerState());
      return;
    }

    // Now process all bone animations and apply.
    for (let [boneName, state] of playerContainer.boneStates) {
      // We simply throw everything into the repository and it does the work for us.
      repository.applyBoneAnimation(player, state.progress, "character.b3d", state.animation, boneName);
    }
  }

  //? We have to do this on step because the player is not an object.
  minetest.register_globalstep((delta: number) => {
    for (let player of minetest.get_connected_players()) {
      processPlayerAnimations(player, delta);
    }
  });


}