namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["master_container"]);

  let repository = new ModelContainer();

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