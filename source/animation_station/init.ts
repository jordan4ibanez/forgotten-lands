namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;

  /**
   * This is the base of the animation for players.
   * Players are a special case because they don't work like
   * lua entities. They are pure userdata. It's EXTREMELY ANNOYING.
   */
  class PlayerAnimationState {
    currentAnimation: string = "";
    animationProgress: number = 0;
    up: boolean = true;
  }

  /**
   * AnimationPoint defines TRS for a frame of the animation.
   */
  export interface AnimationPoint {
    translation: Vec3;
    rotation: Vec3;
    scale: Vec3;
  }

  /**
   * Internal worker for Animation Point.
   */
  class AnimationWorker implements AnimationPoint {
    translation: Vec3 = vector.create3d(0, 0, 0);
    rotation: Vec3 = vector.create3d(0, 0, 0);
    scale: Vec3 = vector.create3d(1, 1, 1);

    /**
     * You can see this is so verbose specifically not to create new objects.
     */
    identity(): void {
      this.translation.x = 0;
      this.translation.y = 0;
      this.translation.z = 0;
      this.rotation.x = 0;
      this.rotation.y = 0;
      this.rotation.z = 0;
      this.scale.x = 1;
      this.scale.y = 1;
      this.scale.z = 1;
    }

    /**
     * So is this one.
     */
    set(trsObject: AnimationPoint): void {
      this.translation.x = trsObject.translation.x;
      this.translation.y = trsObject.translation.y;
      this.translation.z = trsObject.translation.z;
      this.rotation.x = trsObject.rotation.x;
      this.rotation.y = trsObject.rotation.y;
      this.rotation.z = trsObject.rotation.z;
      this.scale.x = trsObject.scale.x;
      this.scale.y = trsObject.scale.y;
      this.scale.z = trsObject.scale.z;
    }
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

  /**
   * Animation Repository holds all the animations for all bones on all models.
   */
  class AnimationRepository {

    models: ModelRepo = new Map();

    bones: BoneRepository = new Map();


    getStart(entity: ObjectRef, animationName: string, boneName: string): AnimationPoint {

      // We call identity to allow this to escape out early if a bone doesn't have animation.
      workerAnimationPointStart.identity();

      //! Check if the model has a mesh.
      const meshName: string | undefined = entity.get_properties().mesh;

      if (meshName == null) {
        warning("Mesh was not defined for entity [" + tostring(entity) + "]!");
        return workerAnimationPointStart;
      }

      //! Check if we have this mesh in the animation repo.
      const modelAnimation: MeshAnimationContainer | undefined = this.models.get(meshName);

      if (modelAnimation == null) {
        warning("Mesh [" + meshName + "] has no registered animations!");
        return workerAnimationPointStart;
      }

      //! Check if we have this animation in the mesh's repo.
      const animation: Animation | undefined = modelAnimation.get(animationName);

      if (animation == null) {
        warning("Mesh [" + meshName + "] does not have animation [" + animationName + "]!");
        return workerAnimationPointStart;
      }

      //! Check if we have the bone in the animation.
      const boneStartEnd: BoneTRSStartEnd | undefined = animation.get(boneName);

      if (boneStartEnd == null) {
        warning("Mesh [" + meshName + "] animation [" + animation + "] does not contain bone [" + boneName + "]!");
        return workerAnimationPointEnd;
      }

      //! Finally, even though we don't have to, check that the start exists.
      const start: AnimationPoint | undefined = boneStartEnd.start;

      if (start == null) {
        warning("Mesh [" + meshName + "] animation [" + animation + "] bone [" + boneName + "] does not contain a start point!");
      }

      workerAnimationPointStart.set(start);
      return workerAnimationPointStart;
    };

    getEnd(entity: ObjectRef, animationName: string, boneName: string): AnimationPoint {

      // We call identity to allow this to escape out early if a bone doesn't have animation.
      workerAnimationPointEnd.identity();

      //! Check if the model has a mesh.
      const meshName: string | undefined = entity.get_properties().mesh;

      if (meshName == null) {
        warning("Mesh was not defined for entity [" + tostring(entity) + "]!");
        return workerAnimationPointEnd;
      }

      //! Check if we have this mesh in the animation repo.
      const modelAnimation: MeshAnimationContainer | undefined = this.models.get(meshName);

      if (modelAnimation == null) {
        warning("Mesh [" + meshName + "] has no registered animations!");
        return workerAnimationPointEnd;
      }

      //! Check if we have this animation in the mesh's repo.
      const animation: Animation | undefined = modelAnimation.get(animationName);

      if (animation == null) {
        warning("Mesh [" + meshName + "] does not have animation [" + animationName + "]!");
        return workerAnimationPointEnd;
      }

      //! Check if we have the bone in the animation.
      const boneStartEnd: BoneTRSStartEnd | undefined = animation.get(boneName);

      if (boneStartEnd == null) {
        warning("Mesh [" + meshName + "] animation [" + animation + "] does not contain bone [" + boneName + "]!");
        return workerAnimationPointEnd;
      }

      //! Finally, even though we don't have to, check that the end exists.
      const end: AnimationPoint | undefined = boneStartEnd.end;

      if (end == null) {
        warning("Mesh [" + meshName + "] animation [" + animation + "] bone [" + boneName + "] does not contain an end point!");
      }

      workerAnimationPointEnd.set(end);
      return workerAnimationPointEnd;
    };

    registerAnimation(meshName: string, animationName: string, animation: Animation): void {

      //! Check if we have this mesh in the animation repo.
      let modelAnimation: MeshAnimationContainer | undefined = this.models.get(meshName);
      if (modelAnimation == null) {
        this.models.set(meshName, new Map());
      }
      modelAnimation = this.models.get(meshName) as MeshAnimationContainer;

      //! Check if we have this animation in the mesh's repo.
      let gottenAnimation: Animation | undefined = modelAnimation.get(animationName);
      if (gottenAnimation != null) {
        // modelAnimation.set(animationName, new Map());
        error("Tried to redefine animation [" + animationName + "] for mesh [" + meshName + "]");
      }

      //! Finally set it.
      modelAnimation.set(animationName, animation);
    }

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

  // /**
  //  * Utilize this class to more easily animate entities and players.
  //  */
  // export function getPlayerAnimationProgress(player: ObjectRef): number {
  //   let name = player.get_player_name();
  //   let gotten = playerAnimationState[name];
  //   if (gotten) {
  //     return gotten.animationProgress;
  //   }
  //   playerAnimationState[name] = new PlayerAnimationState();
  //   return 0;
  // };


  // export function setPlayerAnimationProgress(player: ObjectRef, newValue: number): void {
  //   let name = player.get_player_name();
  //   let gotten = playerAnimationState[name];
  //   if (gotten) {
  //     gotten.animationProgress = newValue;
  //   } else {
  //     playerAnimationState[name] = new PlayerAnimationState();
  //   }

  // };

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
  function handlePlayerAnimation(player: ObjectRef): void {
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

    if (currentAnimationState.currentAnimation == "") {//&& currentAnimationState.animationProgress != 0) {
      // No animation, reset.

      workerAnimationPointEnd.identity();

      let boneArray = animationRepository.bones.get("character.b3d");

      if (boneArray == null) {
        error("Forgot to register character.b3d with AnimationStation for players!");
      }

      for (const bone of boneArray) {
        print(bone);
        player.set_bone_override(bone, workerAnimationPointEnd);
      }

      currentAnimationState.animationProgress = 0;
      currentAnimationState.up = true;
      return;
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
      handlePlayerAnimation(player);
    }
  });

}