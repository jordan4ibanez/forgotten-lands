namespace utility {
	const rr = randomRange;

	type microVec3 = { x: number; y: number; z: number };

	vector.create3d = function (
		x?: number | microVec3,
		y?: number,
		z?: number
	): Vec3 {
		let temp = vector.zero();
		if (x != null) {
			if (type(x) == "table") {
				temp.x = (x as microVec3).x;
				temp.y = (x as microVec3).y || 0;
				temp.z = (x as microVec3).z || 0;
			} else {
				temp.x = (x as number) || 0;
				temp.y = y || 0;
				temp.z = z || 0;
			}
		}
		return temp;
	};

	vector.create2d = function (x?: number, y?: number): Vec2 {
		let temp = {
			x: x || 0,
			y: y || 0,
		};
		return temp;
	};

	const create3d = vector.create3d;

	// TS is kinda cool
	vector.random = function (
		minX: number,
		maxX: number,
		minY: number,
		maxY: number,
		minZ: number,
		maxZ: number
	): Vec3 {
		return create3d(rr(minX, maxX), rr(minY, maxY), rr(minZ, maxZ));
	};

	vector.distance2d = (() => {
		// Hidden localized variables.
		const vecA = vector.create3d();
		const vecB = vector.create3d();
		return function (vec1: Vec3, vec2: Vec3): number {
			vecA.x = vec1.x;
			vecA.y = 0;
			vecA.z = vec1.z;
			vecB.x = vec2.x;
			vecB.y = 0;
			vecB.z = vec2.z;
			return vector.distance(vecA, vecB);
		};
	})();

	export function vec3ToString(input: Vec3): string {
		return input.x + ", " + input.y + ", " + input.z;
	}
}
