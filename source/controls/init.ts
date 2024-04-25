namespace controls {

  const warning = utility.warning;
  const Keys = _Keys;

  /**
   * 
   * This was basically translated from this:
   * https://github.com/mt-mods/controls
   * 
   * But we're going to give it a little TypeScript twist.
   * 
   * This is written out verbosely so no mistakes are made.
   * 
   */


  class PlayerControls implements PlayerControlObject {
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
  let onPress: ((player: ObjectRef) => void)[];
  let onHold: ((player: ObjectRef) => void)[];
  let onRelease: ((player: ObjectRef) => void)[];



  // Add player to the repository when they join.
  minetest.register_on_joinplayer((player: ObjectRef) => {
    const name = player.get_player_name();
    repository.set(name, new PlayerControls);
  });
  // Remove player from the repository when they leave.
  minetest.register_on_leaveplayer((player: ObjectRef) => {
    const name = player.get_player_name();
    repository.delete(name);
  });

  // Utility to poll player controls.
  function pollPlayerControls(player: ObjectRef): void {
    const name = player.get_player_name();
    const playerControl: PlayerControlObject = player.get_player_control();
    let controlState = repository.get(name);
    if (controlState == null) {
      warning("Player control state did not exist. Creating and aborting.");
      repository.set(name, new PlayerControls());
      return;
    }
    // Now iterate key to values in the objects and clone them into the repository.
    for (let [key, value] of Object.entries(playerControl) as [keyof PlayerControls, boolean][]) {
      controlState[key] = value;
    }
    // todo: do long press and whatnot.
  }

  // Poll each players inputs on every server step.
  minetest.register_globalstep(() => {
    for (let player of minetest.get_connected_players()) {
      pollPlayerControls(player);
    }
  });









}