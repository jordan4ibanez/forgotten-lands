namespace utility {
  const PI_HALF = math.pi / 2;

  /**
   * The only reason this exists is to smoothly interpolate euler rotation.
   * Anything else is just a bonus.
   * 
   * This is translated from D from Java into Typescript.
   * https://github.com/jordan4ibanez/doml/blob/main/source/doml/quaternion_d.d
   * 
   * This also tends to mutate in place to reduce garbage collector pressure.
   */
  class Quaternion {
    x: number = 0;
    y: number = 0;
    z: number = 0;
    w: number = 1;

    constructor(vec: Vec3) {
      this.fromVec(vec);
    }

    fromVec(vec: Vec3): void {
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

    identity(): void {
      this.x = 0;
      this.y = 0;
      this.z = 0;
      this.w = 0;
    }

    slerp(target: Quaternion, alpha: number): void {
      let cosom = math.fma(this.x, target.x, math.fma(this.y, target.y, math.fma(this.z, target.z, this.w * target.w)));
      let absCosom = math.abs(cosom);
      let scale0, scale1;
      if (1.0 - absCosom > 1E-6) {
        let sinSqr = 1.0 - absCosom * absCosom;
        let sinom = math.invsqrt(sinSqr);
        let omega = math.atan2(sinSqr * sinom, absCosom);
        scale0 = (math.sin((1.0 - alpha) * omega) * sinom);
        scale1 = (math.sin(alpha * omega) * sinom);
      } else {
        scale0 = 1.0 - alpha;
        scale1 = alpha;
      }
      scale1 = cosom >= 0.0 ? scale1 : -scale1;
      this.x = math.fma(scale0, this.x, scale1 * target.x);
      this.y = math.fma(scale0, this.y, scale1 * target.y);
      this.z = math.fma(scale0, this.z, scale1 * target.z);
      this.w = math.fma(scale0, this.w, scale1 * target.w);
    }

    // Mutates in place to prevent excessive objects.
    toVec3(mutation: Vec3): void {
      mutation.x = math.atan2(this.x * this.w - this.y * this.z, 0.5 - this.x * this.x - this.y * this.y);
      mutation.y = math.safeAsin(2.0 * (this.x * this.z + this.y * this.w));
      mutation.z = math.atan2(this.z * this.w - this.x * this.y, 0.5 - this.y * this.y - this.z * this.z);
    }

  }
}