namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;

  /**
   * This is the base of the animation for players.
   * Players are a special case because they don't work like
   * lua entities. They are pure userdata. It's EXTREMELY ANNOYING.
   */
  class PlayerAnimationState {
    currentAnimation: string = "";
    animationProgress: number = 0;
    up: boolean = true;
    speed: number = 1.0;
    newAnimationTrigger: boolean = true;
  }




  /**
   * Animation Register defines a basic animation for a bone.
   */
  export interface BoneTRSStartEnd {
    //? If I ever feel like making longer animations, I can use this.
    // frames: { [key: number]: AnimationPoint; } = {};

    start: AnimationPoint;
    end: AnimationPoint;
  }

  /**
   * Holds the bones in a model
   */
  type BoneRepository = Map<string, string[]>;

  /**
   * BoneTRSStartEnd is the start and end of a bone's animation point in an animation.
   */
  export type Animation = Map<string, BoneTRSStartEnd>;
  /**
   * Animation encapsulates the Bone Animation's for a single animation in one container.
   */
  type MeshAnimationContainer = Map<string, Animation>;
  /**
   * ModelRepo holds all the animations, for all registered models.
   */
  type ModelRepo = Map<string, MeshAnimationContainer>;

  /**
   * Worker Animation Point start and end is a piece of data which is used to reduce pressure
   * on the garbage collector by reusing it's memory address over and over.
   */
  let workerAnimationPointStart: AnimationWorker = new AnimationWorker();
  let workerAnimationPointEnd: AnimationWorker = new AnimationWorker();
  /**
   * Same with these, they simply help performance.
   */
  let rotationStart = new Quaternion(vector.create3d(0, 0, 0));
  let rotationEnd = new Quaternion(vector.create3d(0, math.pi, 0));
  let workerRotation = new Quaternion(vector.create3d(0, 0, 0));
  let workerVec = vector.create3d(0, 0, 0);


  let boneOverrideWorker: BoneOverrideWorker = new BoneOverrideWorker();

  /**
   * Animation Repository holds all the animations for all bones on all models.
   */
  class AnimationRepository {

    models: ModelRepo = new Map();

    bones: BoneRepository = new Map();


  

    registerBones(meshName: string, bones: string[]): void {
      if (this.bones.has(meshName)) {
        error("Tried to override bones for mesh [" + meshName + "]");
      }

      this.bones.set(meshName, bones);
    }
  }

  let playerAnimationState: Map<string, PlayerAnimationState> = new Map<string, PlayerAnimationState>();
  let animationRepository = new AnimationRepository();

  //? Now we publicize the animationRepository as a functional interface.
  export function registerAnimation(meshName: string, animationName: string, animation: Animation): void {
    animationRepository.registerAnimation(meshName, animationName, animation);
  }
  export function registerBones(meshName: string, bones: string[]): void {
    animationRepository.registerBones(meshName, bones);
  }


  /**
   * We literally have to create a separate function for players to set their animation because they
   * are userdata.
   */
  export function setPlayerAnimation(playerName: string, animation: string) {
    let currentAnimationState = playerAnimationState.get(playerName);
    if (currentAnimationState == null) {
      playerAnimationState.set(playerName, new PlayerAnimationState());
      warning("Tried to set a player animation for [" + playerName + "] when they were not in the state list.");
      currentAnimationState = playerAnimationState.get(playerName) as PlayerAnimationState;
    }

    // Already had this animation.
    if (currentAnimationState.currentAnimation == animation) {
      return;
    }

    currentAnimationState.currentAnimation = animation;
    currentAnimationState.animationProgress = 0;
    currentAnimationState.up = true;
    currentAnimationState.newAnimationTrigger = true;
  }

  export function setPlayerAnimationSpeed(playerName: string, animationSpeed: number) {
    let currentAnimationState = playerAnimationState.get(playerName);
    if (currentAnimationState == null) {
      playerAnimationState.set(playerName, new PlayerAnimationState());
      warning("Tried to set a player animation for [" + playerName + "] when they were not in the state list.");
      currentAnimationState = playerAnimationState.get(playerName) as PlayerAnimationState;
    }

    currentAnimationState.speed = animationSpeed;
  }

  /**
   * A player joins, add them to the state container.
   */
  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    let name = player.get_player_name();
    if (name == null) {
      error("Got a null player name!");
    }
    playerAnimationState.set(name, new PlayerAnimationState());
  });

  /**
   * A player leaves, remove them from the state container.
   */
  minetest.register_on_leaveplayer((player: ObjectRef, _: boolean) => {
    let name = player.get_player_name();
    if (name == null) {
      error("Got a null player name!");
    }
    playerAnimationState.delete(name);
  });

  /**
   * Handle the player's current animation.
   * @param player A player.
   */
  function handlePlayerAnimation(player: ObjectRef, delta: number): void {
    const name = player.get_player_name();
    if (name == null) {
      error("Got a null player name!");
    }

    let currentAnimationState = playerAnimationState.get(name);
    if (currentAnimationState == null) {
      warning("Player [" + name + "] has no animation state.");
      playerAnimationState.set(name, new PlayerAnimationState());
      // Bail out
      return;
    }

    if (currentAnimationState.currentAnimation == "" && currentAnimationState.newAnimationTrigger == true) {
      // No animation, reset.

      workerAnimationPointEnd.identity();

      let boneArray = animationRepository.bones.get("character.b3d");

      if (boneArray == null) {
        error("Forgot to register character.b3d with AnimationStation for players!");
      }

      boneOverrideWorker.identity();

      for (const bone of boneArray) {
        // print(bone);
        player.set_bone_override(bone, boneOverrideWorker.override);
      }

      currentAnimationState.animationProgress = 0;
      currentAnimationState.up = true;
      currentAnimationState.newAnimationTrigger = false;
      return;
    }

    // Don't care about nothing.
    if (currentAnimationState.currentAnimation == "") {
      return;
    }

    //? Now we begin animation!

    let boneArray = animationRepository.bones.get("character.b3d");

    if (boneArray == null) {
      error("Forgot to register character.b3d with AnimationStation for players!");
    }

    const currentAnimation = currentAnimationState.currentAnimation;
    const animationProgress = currentAnimationState.animationProgress;

    for (const bone of boneArray) {

      boneOverrideWorker.identity();

      animationRepository.getStart(player, currentAnimation, bone);
      animationRepository.getEnd(player, currentAnimation, bone);

      // todo: implement vector.lerp!

      //workerAnimationPointStart

      rotationStart.fromVec(workerAnimationPointStart.rotation);
      rotationEnd.fromVec(workerAnimationPointEnd.rotation);
      rotationStart.slerp(rotationEnd, animationProgress, workerRotation);

      workerRotation.toVec3(workerVec);

      boneOverrideWorker.setRotation(workerVec);

      player.set_bone_override(bone, boneOverrideWorker.override);
    }

    if (currentAnimationState.up == true) {
      currentAnimationState.animationProgress += delta * currentAnimationState.speed;
      if (currentAnimationState.animationProgress >= 1.0) {
        currentAnimationState.up = false;
        currentAnimationState.animationProgress = 1.0;
      }
    } else {
      currentAnimationState.animationProgress -= delta * currentAnimationState.speed;
      if (currentAnimationState.animationProgress <= 0.0) {
        currentAnimationState.up = true;
        currentAnimationState.animationProgress = 0.0;
      }
    }

  }

  /**
   * Finally, we make it function.
   */
  minetest.register_globalstep((delta: number) => {
    for (const player of minetest.get_connected_players()) {
      if (player == null) {
        warning("AnimationStation got a null player!");
        continue;
      }
      // And if the player is in existence, we do their animation.
      handlePlayerAnimation(player, delta);
    }
  });

}