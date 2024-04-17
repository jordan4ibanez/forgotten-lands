namespace utility {

  export const textureSize = 16

  export function pixel(inputPixel: number): number {
    return (inputPixel / textureSize) - 0.5
  }

  export function loadFiles(filesToLoad: string[]): void {
    const currentMod = minetest.get_current_modname()
    const currentDirectory = minetest.get_modpath(currentMod)
    for (const file of filesToLoad) {
      dofile(currentDirectory + "/" + file + ".lua")
    }
  }

  loadFiles(["math", "enums", "color_generator", "vector"])

  export function concat(...input: string[]): string {
    let accumulator = ""
    input.forEach((val: string) => {
      accumulator += val
    })
    return accumulator
  }

  export function generateSchematic(size: Vec3, keys: { [id: string]: string }, forcePlace: { [id: string]: boolean }, data: string, ySliceProb: number[]): SchematicDefinition {

    let newSchematic = {
      size: size,
      data: [],
      yslice_prob: []
    };

    const length = data.length
    let countDown = length
    for (let i = 1; i <= length; i++) {
      const databit = string.sub(data, countDown, countDown)
      table.insert(newSchematic.data, {
        name: keys[databit],
        force_place: forcePlace[databit] == true
      })
      // print(forcePlace[databit] == true)
      countDown -= 1
    }

    for (const databit of ySliceProb) {
      table.insert(newSchematic.yslice_prob, { prob: databit })
    }

    return newSchematic
  }

  export function println(...any: any): void {
    let builder = ""
    for (const item of any) {
      builder += (function () {
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

  export function fakeRef(): ObjectRef {
    return {} as ObjectRef
  }

  /**
   * A bolt on to allow you to directly register MT lua entities as TS classes.
   * @param clazz Class definition.
   */
  minetest.registerTSEntity = function (clazz: { new(): LuaEntity }) {
    let instance: LuaEntity = new clazz()
    // print(dump(instance))
    if (instance.name == null) {
      throw new Error("Unable to register entity: Name is null")
    }
    instance.__index = instance
    minetest.registered_entities[instance.name] = instance
  }

  /**
   * Register a node regardless of it's name.
   * @param nodeName The node name.
   * @param definition The node definition.
   */
  export function registerNode(nodeName: string, definition: NodeDefinition): void {
    minetest.register_node(":" + nodeName, definition);
  }

  /**
   * Print a warning message instead of an error.
   * @param message The warning message.
   */
  export function warning(message: string): void {
    pcall(function () {
      error(message)
    })
  }

}