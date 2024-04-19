namespace animationStation {


  class PlayerAnimationState {
    animationProgress: number = 0;
  }

  let playerAnimationState: { [key: string]: PlayerAnimationState; } = {};


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