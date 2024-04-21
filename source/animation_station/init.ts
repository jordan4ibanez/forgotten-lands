namespace animationStation {

  const warning = utility.warning;
  const Quaternion = utility.Quaternion;
  const create3d = vector.create3d;
  const loadFiles = utility.loadFiles;

  loadFiles(["container"]);

  let repository = new ModelContainer();

  export function registerAnimation(modelName: string, animationName: string, definition: BoneContainer) {
    repository.registerAnimation(modelName, animationName, definition);
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