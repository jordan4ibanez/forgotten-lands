namespace utility {
	const sin = math.sin;
	const cosFromSin = math.cosFromSin;
	const fma = math.fma;
	const abs = math.abs;
	const atan2 = math.atan2;
	const invsqrt = math.invsqrt;
	const safeAsin = math.safeAsin;

	/**
	 * The only reason this exists is to smoothly interpolate euler rotation.
	 * Anything else is just a bonus.
	 *
	 * This is translated from D from Java into Typescript.
	 * https://github.com/jordan4ibanez/doml/blob/main/source/doml/quaternion_d.d
	 *
	 * This also tends to mutate in place to reduce garbage collector pressure.
	 */
	export class Quaternion {
		x: number = 0;
		y: number = 0;
		z: number = 0;
		w: number = 1;

		constructor(vec: Vec3) {
			this.fromVec(vec);
		}

		fromVec(vec: Vec3): void {
			let sx = sin(vec.x * 0.5);
			let cx = cosFromSin(sx, vec.x * 0.5);
			let sy = sin(vec.y * 0.5);
			let cy = cosFromSin(sy, vec.y * 0.5);
			let sz = sin(vec.z * 0.5);
			let cz = cosFromSin(sz, vec.z * 0.5);

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

		slerp(target: Quaternion, alpha: number, mutation: Quaternion): void {
			let cosom = fma(
				this.x,
				target.x,
				fma(this.y, target.y, fma(this.z, target.z, this.w * target.w))
			);
			let absCosom = abs(cosom);
			let scale0, scale1;
			if (1.0 - absCosom > 1e-6) {
				let sinSqr = 1.0 - absCosom * absCosom;
				let sinom = invsqrt(sinSqr);
				let omega = atan2(sinSqr * sinom, absCosom);
				scale0 = sin((1.0 - alpha) * omega) * sinom;
				scale1 = sin(alpha * omega) * sinom;
			} else {
				scale0 = 1.0 - alpha;
				scale1 = alpha;
			}
			scale1 = cosom >= 0.0 ? scale1 : -scale1;
			mutation.x = fma(scale0, this.x, scale1 * target.x);
			mutation.y = fma(scale0, this.y, scale1 * target.y);
			mutation.z = fma(scale0, this.z, scale1 * target.z);
			mutation.w = fma(scale0, this.w, scale1 * target.w);
		}

		// Mutates in place to prevent excessive objects.
		toVec3(mutation: Vec3): void {
			mutation.x = atan2(
				this.x * this.w - this.y * this.z,
				0.5 - this.x * this.x - this.y * this.y
			);
			mutation.y = safeAsin(2.0 * (this.x * this.z + this.y * this.w));
			mutation.z = atan2(
				this.z * this.w - this.x * this.y,
				0.5 - this.y * this.y - this.z * this.z
			);
		}
	}
}
