namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["master_containers"]);

  let repository = new ModelContainer();

  //! This is hardcoded because I'm prototyping per-bone animation.

  type BoneState = animationStation.BoneState;

  /**
   * Holds all the bone states for players.
   */
  export class PlayerState {
    boneStates: Map<string, BoneState> = new Map();
    constructor() {
      //! Hardcoded-ness starts here. We simply iterate the character.b3d bones.

    }
  }

  //? Expose the functional interface.
  export function registerAnimation(modelName: string, animationName: string, definition: BoneContainer): void {
    repository.registerAnimation(modelName, animationName, definition);
  }
  export function registerBones(modelName: string, bones: Set<string>): void {
    repository.registerBones(modelName, bones);
  }

  registerAnimation("test.b3d", "walk", {
    bones: new Map([
      ["leg", {
        start: {
          translation: create3d(),
          rotation: create3d(),
          scale: create3d(),
        },
        end: {
          translation: create3d(),
          rotation: create3d(),
          scale: create3d(),
        }
      }]
    ])
  });
}