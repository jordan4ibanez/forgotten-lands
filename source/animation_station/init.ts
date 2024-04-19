namespace animationStation {


  /**
   * Utilize this class to more easily animate entities and players.
   */
  export interface AnimatedEntity extends ObjectRef {
    /** 0.0 - 1.0 */
    animationProgress: number;
  }

  /**
   * AnimationStation is a model container to make procedural animation easier.
   */
  export class AnimationStation {


  }


  /**
   * Automatically injects a player with the proper animation variables.
   */
  utility.registerInjectionFunction((player: ObjectRef) => {
    let oldSelf = getmetatable(player) as any;
    if (oldSelf != null) {
      oldSelf.animationProgress = 0;
    }
  });

}