namespace controls {

  /**
   * 
   * This was basically translated from this:
   * https://github.com/mt-mods/controls
   * 
   * But we're going to give it a little TypeScript twist.
   * 
   */


  minetest.register_on_joinplayer((player: ObjectRef) => {
    const gotten_control_module: Keys = player.get_player_control();
  });







}