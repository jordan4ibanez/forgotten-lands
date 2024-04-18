namespace utility {
  export function randomRange(min: number, max: number): number {
    return (math.random() * (max - min) + min);
  }

  /**
   * Clamp a number between two number. (inclusive)
   * @param min Min value.
   * @param max Max value.
   * @param input Value to be clamped.
   * @returns Clamped value.
   */
  math.clamp = function (min: number, max: number, input: number): number {
    if (input < min) {
      return min;
    } else if (input > max) {
      return max;
    }
    return input;
  };

}