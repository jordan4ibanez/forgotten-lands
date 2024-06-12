namespace utility {
  const blockType = types.BlockType;

  /**
   * Get all block groups.
   * @returns An array of all block groups..
   */
  export function allBlockGroups(): string[] {
    let accumulator: string[] = [];
    for (const type of Object.keys(blockType)) {
      accumulator.push(`group:${type}`);
    }
    return accumulator;
  }
}