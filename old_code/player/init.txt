
minetest.register_on_joinplayer((player: ObjectRef) => {
    player.set_physics_override({
        jump: 1.25,
        gravity: 1.25
    });
});