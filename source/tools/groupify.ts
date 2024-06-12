namespace utility {
  const blockType = types.BlockType;
  export function allBlockTypes(): void {
    for (const type of Object.entries(blockType)) {
      print(type);
    }
  }
}