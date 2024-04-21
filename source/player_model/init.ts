namespace playerModel {

  // const getPlayerAnimationProgress = animationStation.getPlayerAnimationProgress;
  // const setPlayerAnimationProgress = animationStation.setPlayerAnimationProgress;
  const Quaternion = utility.Quaternion;
  // const registerAnimation = animationStation.registerAnimation;
  // const registerBones = animationStation.registerBones;
  // const setPlayerAnimation = animationStation.setPlayerAnimation;
  // const setPlayerAnimationSpeed = animationStation.setPlayerAnimationSpeed;
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


  // registerAnimation("character.b3d",
  //   "walk",
  //   new Map([
  //     ["Arm_Left", {
  //       start: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(math.pi / 4, 0, 0),
  //         scale: create3d(0, 0, 0)
  //       },
  //       end: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(-math.pi / 4, 0, 0),
  //         scale: create3d(1, 1, 1)
  //       }
  //     }],
  //     ["Leg_Right", {
  //       start: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(math.pi / 4, 0, 0),
  //         scale: create3d(0, 0, 0)
  //       },
  //       end: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(-math.pi / 4, 0, 0),
  //         scale: create3d(1, 1, 1)
  //       }
  //     }],

  //     ["Arm_Right", {
  //       start: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(-math.pi / 4, 0, 0),
  //         scale: create3d(0, 0, 0)
  //       },
  //       end: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(math.pi / 4, 0, 0),
  //         scale: create3d(1, 1, 1)
  //       }
  //     }],
  //     ["Leg_Left", {
  //       start: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(-math.pi / 4, 0, 0),
  //         scale: create3d(0, 0, 0)
  //       },
  //       end: {
  //         translation: create3d(0, 0, 0),
  //         rotation: create3d(math.pi / 4, 0, 0),
  //         scale: create3d(1, 1, 1)
  //       }
  //     }]
  //   ]));

  // registerBones("character.b3d", [
  //   "Body",
  //   "Head",
  //   "Arm_Left",
  //   "Arm_Right",
  //   "Leg_Left",
  //   "Leg_Right"
  // ]);


  minetest.register_on_joinplayer((player: ObjectRef) => {

    const name = player.get_player_name();

    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });


  });

  // // speed based animation

  // This works with the default character.b3d
  const start = vector.create3d(math.pi / 4, 0, 0);
  const end = vector.create3d(-math.pi / 4, 0, 0);
  let timer = 0;
  let state = false;

  minetest.register_globalstep((delta: number) => {

    timer += delta;
    if (timer > 1) {
      // Get the players.
      let playerIterator: ObjectRef[] = minetest.get_connected_players();
      // Restart the timer.
      timer = 0;
      // Flip the state.
      state = !state;
      // Change the head bone override.
      if (state) {
        print("tick");
        for (let player of playerIterator) {
          player.set_bone_override("Head", {
            rotation: {
              vec: start,
              // Literally does nothing.
              interpolation: 1.0,
              absolute: false,
            }
          });
        }
      } else {
        print("tock");
        for (let player of playerIterator) {
          player.set_bone_override("Head", {
            rotation: {
              vec: end,
              // Literally does nothing.
              interpolation: 1.0,
              absolute: false,
            }
          });
        }
      }
    }
  });

  // minetest.register_globalstep((_: number) => {
  //   for (const player of minetest.get_connected_players()) {
  //     let vel = player.get_velocity();
  //     let speed = vector.length(vel);
  //     const name = player.get_player_name();

  //     if (speed == 0) {
  //       setPlayerAnimation(name, "");
  //     } else {
  //       setPlayerAnimation(name, "walk");
  //       setPlayerAnimationSpeed(name, speed);
  //     }

  //   }

  // });
}