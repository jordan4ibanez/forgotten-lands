namespace animationStation {

  const create3d = vector.create3d;
  const Quaternion = utility.Quaternion;

  /**
   * And the final processor, this guy.
   */
  export class BoneOverrideWorker {
    override: BoneOverride = {
      position: {
        vec: create3d(0, 0, 0),
        interpolate: 0.05,
        absolute: false
      },
      rotation: {
        vec: create3d(0, 0, 0),
        interpolate: 0.05,
        absolute: false
      },
      scale: {
        vec: create3d(1, 1, 1),
        interpolate: 0.05,
        absolute: true
      }
    };

    identity(): void {
      if (this.override.position != null) {
        this.override.position.vec.x = 0;
        this.override.position.vec.y = 0;
        this.override.position.vec.z = 0;
      }
      if (this.override.rotation != null) {
        this.override.rotation.vec.x = 0;
        this.override.rotation.vec.y = 0;
        this.override.rotation.vec.z = 0;
      }
      if (this.override.scale != null) {
        this.override.scale.vec.x = 1;
        this.override.scale.vec.y = 1;
        this.override.scale.vec.z = 1;
      }
    }

    setPosition(vec: Vec3): void {
      if (this.override.position == null) {
        error("Position went null in bone override worker.");
      }
      this.override.position.vec.x = vec.x;
      this.override.position.vec.y = vec.y;
      this.override.position.vec.z = vec.z;
    }
    setRotation(vec: Vec3): void {
      if (this.override.rotation == null) {
        error("Rotation went null in bone override worker.");
      }
      this.override.rotation.vec.x = vec.x;
      this.override.rotation.vec.y = vec.y;
      this.override.rotation.vec.z = vec.z;
    }
    setScale(vec: Vec3): void {
      if (this.override.scale == null) {
        error("Scale went null in bone override worker.");
      }
      this.override.scale.vec.x = vec.x;
      this.override.scale.vec.y = vec.y;
      this.override.scale.vec.z = vec.z;
    }
  }

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
   * Internal keyframe worker container
   */
  class AnimationWorker implements Keyframe {
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
    set(trsObject: Keyframe): void {
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
  // export interface BoneContainer {
  /**
   * String is the bone name.
   */
  export type BoneContainer = Map<string, Animation>;
  // }

  /**
   * Animation Container contains a map of Animations.
   */
  export interface AnimationContainer {
    /**
     * String is the animation name.
     */
    animations: Map<string, BoneContainer>;
  }

  //? Workers
  // Animation keyframes.
  let workerAnimationStart: AnimationWorker = new AnimationWorker();
  let workerAnimationEnd: AnimationWorker = new AnimationWorker();
  // Math workers.
  let rotationStart = new Quaternion(vector.create3d(0, 0, 0));
  let rotationEnd = new Quaternion(vector.create3d(0, math.pi, 0));
  let outputRotation = new Quaternion(vector.create3d(0, 0, 0));
  let workerVec = vector.create3d(0, 0, 0);
  // This is the output worker.
  let outputOverride = new BoneOverrideWorker();

  /**
   * Holds the Models.
   */
  export class ModelContainer {
    /**
     * String is the model name.
     */
    models: Map<string, AnimationContainer> = new Map();
    /**
     * String model name, Map of bones.
     */
    bones: Map<string, Set<string>> = new Map();

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

    registerBones(modelName: string, bones: Set<string>): void {
      if (this.bones.has(modelName)) {
        error("AnimationStation: Tried to redefine bones for model [" + modelName + "].");
      }
      this.bones.set(modelName, bones);
    }

    getStart(modelName: string, animationName: string, boneName: string): AnimationWorker {
      if (this.bones.has(modelName)) {
        const gotten = this.bones.get(modelName) as Set<string>;
        if (!gotten.has(boneName)) {
          error("Model [" + modelName + "] bone [" + boneName + "] is not registered.");
        }
      } else {
        error("Model [" + modelName + "] has no registered bones.");
      }
      workerAnimationStart.identity();
      if (!this.models.has(modelName)) {
        return workerAnimationStart;
      }
      const modelContainer = this.models.get(modelName) as AnimationContainer;
      if (!modelContainer.animations.has(animationName)) {
        return workerAnimationStart;
      }
      const animationContainer = modelContainer.animations.get(animationName) as BoneContainer;
      if (!animationContainer.has(boneName)) {
        return workerAnimationStart;
      }
      const boneContainer = animationContainer.get(boneName) as Animation;
      const startKeyframe = boneContainer.start;
      workerAnimationStart.set(startKeyframe);
      return workerAnimationStart;
    }

    getEnd(modelName: string, animationName: string, boneName: string): AnimationWorker {
      if (this.bones.has(modelName)) {
        const gotten = this.bones.get(modelName) as Set<string>;
        if (!gotten.has(boneName)) {
          error("Model [" + modelName + "] bone [" + boneName + "] is not registered.");
        }
      } else {
        error("Model [" + modelName + "] has no registered bones.");
      }
      workerAnimationEnd.identity();
      if (!this.models.has(modelName)) {
        return workerAnimationEnd;
      }
      const modelContainer = this.models.get(modelName) as AnimationContainer;
      if (!modelContainer.animations.has(animationName)) {
        return workerAnimationEnd;
      }
      const animationContainer = modelContainer.animations.get(animationName) as BoneContainer;
      if (!animationContainer.has(boneName)) {
        return workerAnimationEnd;
      }
      const boneContainer = animationContainer.get(boneName) as Animation;
      const endKeyframe = boneContainer.end;
      workerAnimationEnd.set(endKeyframe);
      return workerAnimationEnd;
    }

    /**
     * Apply animation to an object's model.
     */
    applyBoneAnimation(object: ObjectRef, animationProgress: number, modelName: string, animationName: string, boneName: string): void {
      // These values are stored into the workers.
      this.getStart(modelName, animationName, boneName);
      this.getEnd(modelName, animationName, boneName);

      // todo: implement vector.lerp!

      // todo: Translation

      // Rotation

      rotationStart.fromVec(workerAnimationStart.rotation);
      rotationEnd.fromVec(workerAnimationEnd.rotation);
      rotationStart.slerp(rotationEnd, animationProgress, outputRotation);
      outputRotation.toVec3(workerVec);

      outputOverride.setRotation(workerVec);

      // todo: Scale

      object.set_bone_override(boneName, outputOverride.override);
    }
  }

  /**
   * Specialized bone container interface.
   */
  export interface BoneState {
    animation: string;
    progress: number;
    speed: number;
    up: boolean;
  }

}