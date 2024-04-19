namespace utility {
  type injectionFunction = (player: ObjectRef) => void;

  let injectionArray: injectionFunction[] = [];

  /**
   * This function is extremely dangerous and can lead to strange errors. Use it carefully.
   * @param func an injection function to bolt on metadata into the player's object.
   */
  export function registerInjectionFunction(func: injectionFunction): void {
    injectionArray.push(func);
  }


  /**
   * Payload injection on joining players.
   */
  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    for (const func of injectionArray) {
      func(player);
    }
  });

}