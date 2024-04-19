namespace playerModel {

  type AnimationStation = animationStation.AnimationStation;


  minetest.register_on_joinplayer((player: ObjectRef) => {
    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });

    // player.set_animation(vector.create2d(0, 79), 30, 0, true);
    
  });
}