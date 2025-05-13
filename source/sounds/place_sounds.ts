namespace sounds {


    const playSound = minetest.sound_play;

    // Cache this pointer.
    const nodes = minetest.registered_nodes;

    // Server runs the place sound so they actually play normally.
    //? This is a fix for an ancient bug in minetest's audio handling.
    minetest.register_on_placenode(function (position: Vec3, node: NodeTable) {

        const name = node.name;

        const definition = nodes[name];

        if (definition == null) {
            error("Tried to get a null definition of node " + name + "! Bailing out.");
        }

        const sounds = definition.sounds;

        if (sounds == null) {
            return;
        }

        const placed = sounds.placed;

        if (placed == null) {
            return;
        }

        // print(`Playing sound ${placed.name} at ${position.x} | ${position.y} | ${position.z}`);
        playSound({
            name: placed.name,
            gain: placed.gain,
            pitch: placed.pitch,
        }, {
            pos: position,
            max_hear_distance: 16
        });
    });
}