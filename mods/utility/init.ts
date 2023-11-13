module utility {
  function concat(...input: string[]): string {
    let accumulator = ""
    input.forEach((val: string) => {
      accumulator += val 
    })
    return accumulator
  }

  function generateSchematic(size: Vec3, keys: Map<string, string>, forcePlace: Map<string, boolean>, data: string, ySliceProb: number[]): SchematicDefinition {

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
        name: keys.get(databit),
        forcePlace: forcePlace.get(databit)
      })
      countDown -= 1
    }

    for (const databit in ipairs(ySliceProb)) {
      table.insert(newSchematic.yslice_prob, {prob: databit})
    }

    ItemStack

    return newSchematic
  }
}