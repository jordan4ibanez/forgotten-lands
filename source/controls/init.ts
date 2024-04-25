namespace controls {

  /**
   * 
   * This was basically translated from this:
   * https://github.com/mt-mods/controls
   * 
   * But we're going to give it a little TypeScript twist.
   * 
   */

  class PlayerControls implements Keys {
    up: boolean = false;
    down: boolean = false;
    left: boolean = false;
    right: boolean = false;
    jump: boolean = false;
    aux1: boolean = false;
    sneak: boolean = false;
    dig: boolean = false;
    place: boolean = false;
    LMB: boolean = false;
    RMB: boolean = false;
    zoom: boolean = false;
  }

  let repository: Map<string, PlayerControls> = new Map();


  // Add player to the repository when they join.
  minetest.register_on_joinplayer((player: ObjectRef) => {
    const name = player.get_player_name();

    repository.set(name, new PlayerControls);

    // const playerControl: Keys = player.get_player_control();
  });
  // Remove player from the repository when they leave.
  minetest.register_on_leaveplayer((player: ObjectRef) => {
    const name = player.get_player_name();
    repository.delete(name);
  });

  function pollPlayerControls(player: ObjectRef): void {

  }

  // Poll each players inputs on every server step.
  minetest.register_globalstep(() => {
    for (let player of minetest.get_connected_players()) {
      pollPlayerControls(player);
    }
  });









}