namespace controls {

    const warning = utility.warning;
    const getTime = utility.getTime;
    type Keys = _Keys;
    const Keys = _Keys;
    const getPlayers = utility.getPlayers;

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

    class InputTimer {
        up: number;
        down: number;
        left: number;
        right: number;
        jump: number;
        aux1: number;
        sneak: number;
        dig: number;
        place: number;
        LMB: number;
        RMB: number;
        zoom: number;
        constructor() {
            const currentTime = getTime();
            this.up = currentTime;
            this.down = currentTime;
            this.left = currentTime;
            this.right = currentTime;
            this.jump = currentTime;
            this.aux1 = currentTime;
            this.sneak = currentTime;
            this.dig = currentTime;
            this.place = currentTime;
            this.LMB = currentTime;
            this.RMB = currentTime;
            this.zoom = currentTime;
        }
    }

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

    type keyCallback = (player: ObjectRef, elapsedTime: number) => void;


    // Little auto map population thing.
    function generateKeyedMap(): Map<Keys, keyCallback[]> {
        // Automatically populate the map.
        let map = new Map();
        for (let [key, _] of Object.entries(new PlayerControls()) as [keyof PlayerControls, any][]) {
            map.set(key, []);
        }
        return map;
    };

    let keysRepository: Map<string, PlayerControls> = new Map();
    let timeRepository: Map<string, InputTimer> = new Map();

    let onPress: Map<Keys, keyCallback[]> = generateKeyedMap();
    let onHold: Map<Keys, keyCallback[]> = generateKeyedMap();
    let onRelease: Map<Keys, keyCallback[]> = generateKeyedMap();

    /**
     * Register an on press callback for keys.
     * @param keys The keys in which you want your callback to run for.
     * @param callback The callback.
     */
    export function registerOnPress(keys: Keys[], callback: keyCallback): void {
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
    export function registerOnHold(keys: Keys[], callback: keyCallback): void {
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
    export function registerOnRelease(keys: Keys[], callback: keyCallback): void {
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
        print("hi");
        keysRepository.set(name, new PlayerControls);
        timeRepository.set(name, new InputTimer());
    });
    // Remove player from the repository when they leave.
    minetest.register_on_leaveplayer((player: ObjectRef) => {
        const name = player.get_player_name();
        keysRepository.delete(name);
        timeRepository.set(name, new InputTimer());
    });


    //* debugging components
    // registerOnHold([Keys.jump], (_, time: number) => {
    //   print("holding since: " + time);
    // });

    // registerOnPress([Keys.jump], (_, time: number) => {
    //   print("starting duration: " + time);
    // });

    // registerOnRelease([Keys.jump], (_, time: number) => {
    //   print("Releasing total: " + time);
    // });

    /**
     * Get if a key is down.
     * @param player The player.
     * @param key The key.
     * @returns If they key is down.
     */
    export function isKeyDown(player: ObjectRef, key: Keys): boolean {
        const name = player.get_player_name();
        let controlState: PlayerControls | undefined = keysRepository.get(name);
        if (controlState == null) {
            warning("Player control state did not exist. Creating and aborting.");
            keysRepository.set(name, new PlayerControls());
            return false;
        }
        return controlState[key];
    }

    /**
     * Get if any of a group of keys are down. Only one needs to be down to trigger true.
     * @param player The player.
     * @param keys The array of possible keys.
     * @returns True if any of them are down, false if none.
     */
    export function areKeysDown(player: ObjectRef, keys: Keys[]): boolean {
        const name = player.get_player_name();
        let controlState: PlayerControls | undefined = keysRepository.get(name);
        if (controlState == null) {
            warning("Player control state did not exist. Creating and aborting.");
            keysRepository.set(name, new PlayerControls());
            return false;
        }
        for (const key of keys) {
            if (controlState[key]) {
                return true;
            }
        }
        return false;
    }


    // Utility to poll player controls.
    function pollPlayerControls(player: ObjectRef): void {

        const name = player.get_player_name();

        const playerControl: PlayerControlObject = player.get_player_control();

        let controlState: PlayerControls | undefined = keysRepository.get(name);

        if (controlState == null) {
            warning("Player control state did not exist. Creating and aborting.");
            keysRepository.set(name, new PlayerControls());
            return;
        }

        let timeState = timeRepository.get(name);

        if (timeState == null) {
            warning("Player time state did not exist. Creating and aborting.");
            timeRepository.set(name, new InputTimer());
            return;
        }

        const currentTime = getTime();

        // Now iterate key to values in the objects and clone them into the repository.
        for (let [key, value] of Object.entries(playerControl) as [keyof PlayerControls, boolean][]) {
            // Memory has changed!
            if (controlState[key] != value) {
                // Get stateful change of this key action.
                const startTime: number = timeState[key as keyof InputTimer];
                if (startTime == null) {
                    error("Null start time for key " + key + " for player " + name);
                }
                const elapsedTime: number = (currentTime - startTime) / 1e6;
                // onPressed
                if (value == true) {
                    const callbacks = onPress.get(key as Keys);
                    if (callbacks == null) {
                        error("Something went horribly wrong with the onPress " + key);
                    }
                    // Elapsed time is from the last time the button was released. 
                    for (const callback of callbacks) {
                        callback(player, elapsedTime);
                    }
                    // Timer is re-initialized to utilize in the callbacks.
                    timeState[key as keyof InputTimer] = currentTime;
                } else {
                    const callbacks = onRelease.get(key as Keys);
                    if (callbacks == null) {
                        error("Something went horribly wrong with the onRelease " + key);
                    }
                    // Timer is the total time that the key was held down.
                    for (const callback of callbacks) {
                        callback(player, elapsedTime);
                    }

                    // Timer is now ready to re-poll from the time that this key was released
                    timeState[key as keyof InputTimer] = currentTime;
                }
            }

            // onHold
            if (value == true) {

                const startTime: number = timeState[key as keyof InputTimer];
                if (startTime == null) {
                    error("Null start time for key " + key + " for player " + name);
                }
                const elapsedTime: number = (currentTime - startTime) / 1e6;

                const callbacks = onHold.get(key as Keys);
                if (callbacks == null) {
                    error("Something went horribly wrong with the onHold " + key);
                }
                for (const callback of callbacks) {
                    callback(player, elapsedTime);
                }
            }
            controlState[key] = value;
        }
    }

    // Poll each players inputs on every server step.
    utility.onStep(() => {
        for (let player of getPlayers()) {
            pollPlayerControls(player);
        }
    });
}