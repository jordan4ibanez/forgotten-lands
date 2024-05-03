namespace playerModel {

  const Quaternion = utility.Quaternion;
  const registerAnimation = animationStation.registerAnimation;
  const registerBones = animationStation.registerBones;
  const setPlayerBoneAnimation = animationStation.setPlayerBoneAnimation;
  const setPlayerBoneAnimationSpeed = animationStation.setPlayerBoneAnimationSpeed;
  const setPlayerBoneAnimationWithSync = animationStation.setPlayerBoneAnimationWithSync;
  const create3d = vector.create3d;
  const Keys = _Keys;
  type Keys = _Keys;
  const isKeyDown = controls.isKeyDown;

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


  registerAnimation("character.b3d",
    "walk",
    new Map([
      ["Arm_Left", {
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
      }],
      ["Leg_Right", {
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
      }],

      ["Arm_Right", {
        start: {
          translation: create3d(0, 0, 0),
          rotation: create3d(-math.pi / 4, 0, 0),
          scale: create3d(0, 0, 0)
        },
        end: {
          translation: create3d(0, 0, 0),
          rotation: create3d(math.pi / 4, 0, 0),
          scale: create3d(1, 1, 1)
        }
      }],
      ["Leg_Left", {
        start: {
          translation: create3d(0, 0, 0),
          rotation: create3d(-math.pi / 4, 0, 0),
          scale: create3d(0, 0, 0)
        },
        end: {
          translation: create3d(0, 0, 0),
          rotation: create3d(math.pi / 4, 0, 0),
          scale: create3d(1, 1, 1)
        }
      }]
    ])
  );

  registerAnimation("character.b3d",
    "mine",
    new Map([
      ["Arm_Right", {
        start: {
          translation: create3d(0, 0, 0),
          rotation: create3d((math.pi / 2) + (math.pi / 4), 0, 0),
          scale: create3d(0, 0, 0)
        },
        end: {
          translation: create3d(0, 0, 0),
          rotation: create3d((math.pi / 2) - (math.pi / 4), math.pi / 8, 0),
          scale: create3d(0, 0, 0)
        }
      }],
    ])
  );

  registerBones("character.b3d", new Set([
    "Body",
    "Head",
    "Arm_Left",
    "Arm_Right",
    "Leg_Left",
    "Leg_Right"
  ]));


  minetest.register_on_joinplayer((player: ObjectRef) => {

    // const name = player.get_player_name();

    player.set_properties({
      mesh: "character.b3d",
      textures: ["character.png"],
      visual: EntityVisual.mesh,
      visual_size: vector.create3d(1, 1, 1)
    });


  });

  // // speed based animation

  utility.onStep((_: number) => {
    for (const player of minetest.get_connected_players()) {
      let vel = player.get_velocity();
      let speed = vector.length(vel);
      // const name = player.get_player_name();

      let diggingTrigger = false;

      if (isKeyDown(player, Keys.dig)) {
        setPlayerBoneAnimation(player, "Arm_Left", "");
        setPlayerBoneAnimation(player, "Arm_Right", "mine");
        setPlayerBoneAnimationSpeed(player, "Arm_Right", 7);
        diggingTrigger = true;
      }

      if (speed == 0) {
        setPlayerBoneAnimation(player, "Leg_Left", "");
        setPlayerBoneAnimation(player, "Leg_Right", "");
        if (!diggingTrigger) {
          setPlayerBoneAnimation(player, "Arm_Left", "");
          setPlayerBoneAnimation(player, "Arm_Right", "");
        }
      } else {
        setPlayerBoneAnimation(player, "Leg_Left", "walk");
        setPlayerBoneAnimation(player, "Leg_Right", "walk");
        setPlayerBoneAnimationSpeed(player, "Leg_Left", speed);
        setPlayerBoneAnimationSpeed(player, "Leg_Right", speed);

        if (!diggingTrigger) {
          setPlayerBoneAnimationWithSync(player, "Arm_Left", "walk", "Leg_Left");
          setPlayerBoneAnimationWithSync(player, "Arm_Right", "walk", "Leg_Right");
          setPlayerBoneAnimationSpeed(player, "Arm_Right", speed);
          setPlayerBoneAnimationSpeed(player, "Arm_Left", speed);
        }
      }
    }
  });
}