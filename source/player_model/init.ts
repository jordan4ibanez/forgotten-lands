namespace playerModel {

  type AnimationStation = animationStation.AnimationStation;
  /*
  character.b3d bone documentation, tree view.
  --------------------------------------------
  Body
  -Head 
  -Arm_Left
  -Arm_Right
  -Leg_Left
  -Leg_Right
  */

  minetest.register_globalstep((delta: number) => {
    for (let player of minetest.get_connected_players()) {
      print(player.get_player_name());
    }
  });


  //! End this debug mess!!!

  minetest.register_on_joinplayer((player: ObjectRef) => {


    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });

  });
}