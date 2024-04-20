namespace playerModel {

  // const getPlayerAnimationProgress = animationStation.getPlayerAnimationProgress;
  // const setPlayerAnimationProgress = animationStation.setPlayerAnimationProgress;
  const Quaternion = utility.Quaternion;
  const registerAnimation = animationStation.registerAnimation;
  const registerBones = animationStation.registerBones;
  const create3d = vector.create3d;
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

  //! Begin debugging mess !!!

  let rotationStart = new Quaternion(vector.create3d(0, 0, 0));
  let rotationEnd = new Quaternion(vector.create3d(0, math.pi, 0));
  let workerRotation = new Quaternion(vector.create3d(0, 0, 0));
  let workerVec = vector.create3d(0, 0, 0);

  // minetest.register_globalstep((delta: number) => {
  //   for (let player of minetest.get_connected_players()) {
  //     let animationProgress = getPlayerAnimationProgress(player);
  //     animationProgress += delta;
  //     setPlayerAnimationProgress(player, animationProgress);
  //     print(animationProgress);

  //     rotationStart.slerp(rotationEnd, animationProgress, workerRotation);
  //     workerRotation.toVec3(workerVec);

  //     player.set_bone_override("Head", {
  //       rotation: {
  //         vec: workerVec,
  //         interpolation: 1,
  //         absolute: false,
  //       }
  //     });

  //   }
  // });

  registerAnimation("character.b3d", "idle", new Map([
    ["Body", {
      start: {
        translation: create3d(0, 0, 0),
        rotation: create3d(math.pi / 4, 0, 0),
        scale: create3d(0, 0, 0)
      },
      end: {
        translation: create3d(0, 0, 0),
        rotation: create3d(-math.pi / 4, 0, 0),
        scale: create3d(1, 1, 1)
      }
    }]
  ]));

  registerBones("character.b3d", [
    "Body",
    "Head",
    "Arm_Left",
    "Arm_Right",
    "Leg_Left",
    "Leg_Right"
  ]);


  //! End this debug mess!!!

  minetest.register_on_joinplayer((player: ObjectRef) => {

    const name = player.get_player_name();

    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });

    animationStation.setPlayerAnimation(name, "idle");
  });
}