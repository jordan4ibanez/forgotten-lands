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
 * Contains Bones.
 *! (Please do not make a boneless version of this)
 */
  export interface BoneContainer {
    /**
     * String is the bone name.
     */
    bones: Map<string, Animation>;
  }

  /**
   * Animation Container contains a map of Animations.
   */
  export interface AnimationContainer {
    /**
     * String is the animation name.
     */
    animations: Map<string, BoneContainer>;
  }

  /**
   * Holds the Models.
   */
  export class ModelContainer {
    /**
     * String is the model name.
     */
    models: Map<string, AnimationContainer> = new Map();

    registerAnimation(modelName: string, animationName: string, definition: BoneContainer) {

      // Create a blank model map if none exists.
      if (!this.models.has(modelName)) {
        this.models.set(modelName, {
          animations: new Map()
        });
      }

      // Now we can safely get it.
      let container = this.models.get(modelName) as AnimationContainer;

      // Don't allow overriding.
      if (container.animations.has(animationName)) {
        error("Tried to redefine animation [" + animationName + "] for model [" + modelName + "].");
      }

      // Then set it.
      container.animations.set(animationName, definition);
    }
  }
}