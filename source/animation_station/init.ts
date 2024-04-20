namespace animationStation {

  const warning = utility.warning;

  /**
   * This is the base of the animation for players.
   * Players are a special case because they don't work like
   * lua entities. They are pure userdata. It's EXTREMELY ANNOYING.
   */
  class PlayerAnimationState {
    animationProgress: number = 0;
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
  interface BoneTRSStartEnd {
    //? If I ever feel like making longer animations, I can use this.
    // frames: { [key: number]: AnimationPoint; } = {};

    start: AnimationPoint;
    end: AnimationPoint;
  }

  /**
   * BoneTRSStartEnd is the start and end of a bone's animation point in an animation.
   */
  type Animation = Map<string, BoneTRSStartEnd>;
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
   * Animation Repository holds all the animations for all bones on all models.
   */
  class AnimationRepository {

    models: ModelRepo = new Map();

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
  }

  let playerAnimationState: { [key: string]: PlayerAnimationState; } = {};
  let animationRepository = new AnimationRepository();


  /**
   * Utilize this class to more easily animate entities and players.
   */
  export function getPlayerAnimationProgress(player: ObjectRef): number {
    let name = player.get_player_name();
    let gotten = playerAnimationState[name];
    if (gotten) {
      return gotten.animationProgress;
    }
    playerAnimationState[name] = new PlayerAnimationState();
    return 0;
  };


  export function setPlayerAnimationProgress(player: ObjectRef, newValue: number): void {
    let name = player.get_player_name();
    let gotten = playerAnimationState[name];
    if (gotten) {
      gotten.animationProgress = newValue;
    } else {
      playerAnimationState[name] = new PlayerAnimationState();
    }

  };
  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    let name = player.get_player_name();
    playerAnimationState[name] = new PlayerAnimationState();
  });

  /**
   * AnimationStation is a model container to make procedural animation easier.
   */
  export class AnimationStation {


  }

}