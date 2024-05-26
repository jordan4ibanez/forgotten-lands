namespace utility {

  const pixel = utility.pixel;

  const textureSize = utility.textureSize;

  /**
   * Generates a nodebox. The height is originated at the bottom and the sides at equidistant
   * lengths from the center of the block.
   * @param width The literal width with origin center.
   * @param height The literal height with origin bottom.
   * @param depth The literal depth with origin center.
   * @returns box which is just number[].
   */
  export function nodeBoxGen(width: number, height: number, depth: number): box {
    const x = width / 2.0;
    const z = depth / 2.0;

    return [-x, -0.5, -z, x, height - 0.5, z];
  }


  /**
   * Generates a nodebox in pixels. The height is originated at the bottom and the sides at equidistant
   * lengths from the center of the block.
   * @param width The literal width with origin center.
   * @param height The literal height with origin bottom.
   * @param depth The literal depth with origin center.
   * @returns box which is just number[].
   */
  export function nodeBoxGenPixel(width: number, height: number, depth: number): box {

    const x = (width / 2) / textureSize;
    const z = (depth / 2) / textureSize;
    const yHeight = (height / textureSize);

    return [-x, -0.5, -z, x, yHeight - 0.5, z];
  }

}