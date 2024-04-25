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
    upTime: number;
    down: boolean = false;
    downTime: number;
    left: boolean = false;
    leftTime: number;
    right: boolean = false;
    rightTime: number;
    jump: boolean = false;
    jumpTime: number;
    aux1: boolean = false;
    aux1Time: number;
    sneak: boolean = false;
    sneakTime: number;
    dig: boolean = false;
    digTime: number;
    place: boolean = false;
    placeTime: number;
    LMB: boolean = false;
    LMBTime: number;
    RMB: boolean = false;
    RMBTime: number;
    zoom: boolean = false;
    zoomTime: number;
    constructor() {
      const currentTime = minetest.get_us_time();
      this.upTime = currentTime;
      this.downTime = currentTime;
      this.leftTime = currentTime;
      this.rightTime = currentTime;
      this.jumpTime = currentTime;
      this.aux1Time = currentTime;
      this.sneakTime = currentTime;
      this.digTime = currentTime;
      this.placeTime = currentTime;
      this.LMBTime = currentTime;
      this.RMBTime = currentTime;
      this.zoomTime = currentTime;
    }
  }

  // Little auto map population thing.
  function generateKeyedMap(): Map<_Keys, ((player: ObjectRef) => void)[]> {
    // Automatically populate the map.
    let map = new Map();
    for (let [key, _] of Object.entries(new PlayerControls()) as [keyof PlayerControls, any][]) {
      map.set(key, []);
    }
    return map;
  };

  let repository: Map<string, PlayerControls> = new Map();

  let onPress: Map<_Keys, ((player: ObjectRef) => void)[]> = generateKeyedMap();
  let onHold: Map<_Keys, ((player: ObjectRef) => void)[]> = generateKeyedMap();
  let onRelease: Map<_Keys, ((player: ObjectRef) => void)[]> = generateKeyedMap();

  /**
   * Register an on press callback for keys.
   * @param keys The keys in which you want your callback to run for.
   * @param callback The callback.
   */
  export function registerOnPress(keys: _Keys[], callback: ((player: ObjectRef) => void)): void {
    // All these pushes will point to the same function memory address.
    for (const key of keys) {
      let funcArray = onPress.get(key);
      if (funcArray == null) {
        error("Tried to assign [on press] to key [" + key + "] which doesn't exist.");
      }
      funcArray.push(callback);
    }
  }

  /**
   * Register an on press callback for keys.
   * @param keys The keys in which you want your callback to run for.
   * @param callback The callback
   */
  export function registerOnHold(keys: _Keys[], callback: ((player: ObjectRef) => void)): void {
    // All these pushes will point to the same function memory address.
    for (const key of keys) {
      let funcArray = onHold.get(key);
      if (funcArray == null) {
        error("Tried to assign [on hold] to key [" + key + "] which doesn't exist.");
      }
      funcArray.push(callback);
    }
  }

  /**
   * Register an on release callback for keys.
   * @param keys The keys in which you want your callback to run for.
   * @param callback The callback.
   */
  export function registerOnRelease(keys: _Keys[], callback: ((player: ObjectRef) => void)): void {
    // All these pushes will point to the same function memory address.
    for (const key of keys) {
      let funcArray = onRelease.get(key);
      if (funcArray == null) {
        error("Tried to assign [on release] to key [" + key + "] which doesn't exist.");
      }
      funcArray.push(callback);
    }
  }


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