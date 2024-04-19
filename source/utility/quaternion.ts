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
      let sx = Math.sin(vec.x * 0.5);
      let cx = Math.cosFromSin(sx, vec.x * 0.5);
      let sy = Math.sin(vec.y * 0.5);
      let cy = Math.cosFromSin(sy, vec.y * 0.5);
      let sz = Math.sin(vec.Z * 0.5);
      let cz = Math.cosFromSin(sz, vec.Z * 0.5);

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