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
  interface AnimationPoint {
    translation: Vec3,
    rotation: Vec3,
    scale: Vec3,
  }

  /**
   * Animation Register defines a basic animation for a bone.
   */
  interface AnimationRegister {
    //? If I ever feel like making longer animations, I can use this.
    // frames: { [key: number]: AnimationPoint; } = {};

    start: AnimationPoint;
    end: AnimationPoint;
  }

  /**
   * BoneTRSStartEnd is the start and end of a bone's animation point in an animation.
   */
  type BoneTRSStartEnd = { [boneName: string]: AnimationRegister; };
  /**
   * Animation encapsulates the Bone Animation's for a single animation in one container.
   */
  type Animation = { [animationName: string]: BoneTRSStartEnd; };
  /**
   * ModelRepo holds all the animations, for all registered models.
   */
  type ModelRepo = { [modelName: string]: Animation; };

  /**
   * Worker Animation Point is a piece of data which is used to reduce pressure
   * on the garbage collector by reusing it's memory address over and over.
   */
  let workerAnimationPoint: AnimationPoint = {
    translation: vector.create3d(0, 0, 0),
    rotation: vector.create3d(0, 0, 0),
    scale: vector.create3d(1, 1, 1)
  };

  /**
   * Animation Repository holds all the animations for all bones on all models.
   */
  class AnimationRepository {
    models: { [modelName: string]: Animation; } = {};

    getStart(entity: ObjectRef): {

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