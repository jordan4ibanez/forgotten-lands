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


  minetest.register_on_joinplayer((player: ObjectRef) => {
    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });

    // player.set_animation(vector.create2d(0, 79), 30, 0, true);

    // print(dump(player.get_bone_override("bone").rotation?.absolute));
    // print(dump(player.get_bone_overrides()));

  });
}