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
          progress: 0,
          speed: 1,
          up: true,
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
  export function setPlayerBoneAnimation(player: ObjectRef, boneName: string, animationName: string): void {
    const name = player.get_player_name();
    let state = playerRepository.get(name);
    if (state == null) {
      warning("Player [" + name + "] does not exist in database! Creating and aborting.");
      playerRepository.set(name, new PlayerState());
      return;
    }

    let boneState = state.boneStates.get(boneName);
    if (boneState == null) {
      error("Tried to set bone animation for bone [" + boneName + "] in character.b3d, which does not exist.");
    }

    // Allow functions to call this over and over without resetting.
    if (boneState.animation == animationName) {
      return;
    }

    // Reset the state.
    boneState.animation = animationName;
    boneState.up = true;
    boneState.progress = 0;
  }

  export function setPlayerBoneAnimationSpeed(player: ObjectRef, boneName: string, animationSpeed: number): void {
    const name = player.get_player_name();
    let state = playerRepository.get(name);
    if (state == null) {
      warning("Player [" + name + "] does not exist in database! Creating and aborting.");
      playerRepository.set(name, new PlayerState());
      return;
    }

    let boneState = state.boneStates.get(boneName);
    if (boneState == null) {
      error("Tried to set bone animation for bone [" + boneName + "] in character.b3d, which does not exist.");
    }

    boneState.speed = animationSpeed;
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

      // print(state.progress);

      // Next we apply timescale to the bone state.
      if (state.up) {
        state.progress += delta * state.speed;
        if (state.progress >= 1.0) {
          state.progress = 1.0;
          state.up = false;
        }
      } else {
        state.progress -= delta * state.speed;
        if (state.progress <= 0.0) {
          state.progress = 0.0;
          state.up = true;
        }
      }
    }
  }

  //? We have to do this on step because the player is not an object.
  utility.onStep((delta: number) => {
    for (let player of minetest.get_connected_players()) {
      processPlayerAnimations(player, delta);
    }
  });


}