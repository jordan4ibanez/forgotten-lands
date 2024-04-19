namespace utility {
  /**
   * The only reason this exists is to smoothly interpolate euler rotation.
   * Anything else is just a bonus.
   * 
   * This is translated from D from Java into Typescript.
   * https://github.com/jordan4ibanez/doml/blob/main/source/doml/quaternion_d.d
   */
  class Quaternion {
    x: number = 0;
    y: number = 0;
    z: number = 0;
    w: number = 1;

    constructor(vec: Vec3) {
      let sx = math.sin(vec.x * 0.5);
      let cx = math.cosFromSin(sx, vec.x * 0.5);
      let sy = math.sin(vec.y * 0.5);
      let cy = math.cosFromSin(sy, vec.y * 0.5);
      let sz = math.sin(vec.z * 0.5);
      let cz = math.cosFromSin(sz, vec.z * 0.5);

      let cycz = cy * cz;
      let sysz = sy * sz;
      let sycz = sy * cz;
      let cysz = cy * sz;
      this.w = cx * cycz - sx * sysz;
      this.x = sx * cycz + cx * sysz;
      this.y = cx * sycz - sx * cysz;
      this.z = cx * cysz + sx * sycz;
    }
  }
}