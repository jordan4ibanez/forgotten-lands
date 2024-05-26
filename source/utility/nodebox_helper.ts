namespace utility {

  const pixel = utility.pixel;

  /**
   * Generates a nodebox. The height is originated at the bottom and the sides at equidistant
   * lengths from the center of the block.
   * @param width The literal width with origin center.
   * @param height The literal height with origin bottom.
   * @param depth The literal depth with origin center.
   * @returns box which is just number[].
   */
  export function nodeBoxGen(width: number, height: number, depth: number): box {
    return [-width / 2.0, 0, -depth / 2.0, width / 2.0, height, depth / 2.0];
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

    const x = pixel(width / 2.0);
    const z = pixel(depth / 2.0);

    return [-x, 0, -z, x, pixel(height), z];
  }

}