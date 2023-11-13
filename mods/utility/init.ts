module utility {
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
      print(forcePlace[databit] == true)
      countDown -= 1
    }

    for (const databit of ySliceProb) {
      table.insert(newSchematic.yslice_prob, {prob: databit})
    }

    return newSchematic
  }

  export function println(...any: any): void {
    let builder = ""
    for (const item of [any]) {
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
      builder += ","
    }
    print(builder)
  }

  export function randomRange(min: number, max: number): number {
    return (math.random() * (max - min) + min)
  }


}