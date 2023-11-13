function concat(...input: string[]): string {
  let accumulator = ""
  input.forEach((val: string) => {
    accumulator += val 
  })
  return accumulator
}

function generateSchematic(size: Vec3) {
  
}