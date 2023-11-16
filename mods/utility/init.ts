module utility {

  const modDir = minetest.get_modpath("utility")
  dofile(modDir + "/enums.lua")

  export function concat(...input: string[]): string {
    let accumulator = ""
    input.forEach((val: string) => {
      accumulator += val 
    })
    return accumulator
  }

  export function generateSchematic(size: Vec3, keys: {[id: string] : string}, forcePlace: {[id: string] : boolean}, data: string, ySliceProb: number[]): SchematicDefinition {

    let newSchematic = {
      size: size,
      data: [],
      yslice_prob: []
    };

    const length = data.length
    let countDown = length
    for (let i = 1; i <= length; i++ ) {
      const databit = string.sub(data, countDown, countDown)
      table.insert(newSchematic.data, {
        name: keys[databit],
        force_place: forcePlace[databit] == true
      })
      // print(forcePlace[databit] == true)
      countDown -= 1
    }

    for (const databit of ySliceProb) {
      table.insert(newSchematic.yslice_prob, {prob: databit})
    }

    return newSchematic
  }

  export function println(...any: any): void {
    let builder = ""
    for (const item of any) {
      builder += (function() {
        switch (type(item)) {
          case "string":
            return item
          case "number":
            return tostring(item)
          case "table":
            return dump(item)
          case "userdata":
            const thing = item as ObjectRef
            if (thing.is_player()) {
              return thing.get_player_name()
            }
            return thing.name
          default:
            return "unknown"
        }
      })();
    }
    print(builder)
  }

  export function randomRange(min: number, max: number): number {
    return (math.random() * (max - min) + min)
  }

  export function fakeRef(): ObjectRef {
    return {} as ObjectRef
  }

  const rr = randomRange;

  vector.create = function(x?: number, y?: number, z?: number): Vec3 {
    let temp = vector.zero()
    temp.x = x || 0
    temp.y = y || 0
    temp.z = z || 0
    return temp
  };
  vector.create2d = function(x?: number, y?: number): Vec2 {
    let temp = {
      x: x || 0,
      y: y || 0
    }
    return temp
  }

  const create = vector.create;

  // TS is kinda cool
  vector.random = function(minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number): Vec3 {
    return create(
      rr(minX, maxX),
      rr(minY, maxY),
      rr(minZ, maxZ)
    )
  }

  vector.distance2d = (() => {
    // Hidden localized variables.
    const vecA = vector.create()
    const vecB = vector.create()
    return function(vec1: Vec3, vec2: Vec3): number {
      vecA.x = vec1.x
      vecA.y = 0
      vecA.z = vec1.z
      vecB.x = vec2.x
      vecB.y = 0
      vecB.z = vec2.z
      return vector.distance(vecA, vecB)
    }
  })();

  minetest.registerTSEntity = function(prototype: { new(): LuaEntity }) {
    let instance: LuaEntity = new prototype()
    // print(dump(instance))
    if (instance.name == null) {
      throw new Error("Unable to register entity: Name is null")
    }
    instance.__index = instance
    minetest.registered_entities[instance.name] = instance
  }


  math.clamp = function(min: number, max: number, input: number): number {
    if (input < min) {
      return min
    } else if (input > max) {
      return max
    }
    return input
  }

  export function loadFiles(filesToLoad: string[]): void {
    const currentMod = minetest.get_current_modname()
    const currentDirectory = minetest.get_modpath(currentMod)
    for (const file of filesToLoad) {
      dofile(currentDirectory + "/" + file + ".lua")
    }
  }
}