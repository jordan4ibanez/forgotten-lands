namespace animationStation {
  //? As you can see, this is the nesting doll of protection.

  /**
   * Keyframe for an Animation.
   */
  export interface Keyframe {
    translation: Vec3;
    rotation: Vec3;
    scale: Vec3;
  }

  /**
   * Animation holds 2 keyframes. (start and end)
   */
  export interface Animation {
    start: Keyframe;
    end: Keyframe;
  }

  /**
   * Animation Container contains a map of Animations.
   */
  export interface AnimationContainer {
    /**
     * String is the animation name.
     */
    animations: Map<string, Animation>;
  }

  /**
   * Contains Bones.
   *! (Please do not make a boneless version of this)
   */
  export interface BoneContainer {
    /**
     * String is the bone name.
     */
    bones: Map<string, AnimationContainer>;
  }

  /**
   * Holds the Models.
   */
  export class ModelContainer {
    /**
     * String is the model name.
     */
    models: Map<string, BoneContainer> = new Map();
  }
}