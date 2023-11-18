namespace formSpec {
  // Extremely experimental formspec composable generation.
  // Does a few things:
  // 1.) Organizes better.
  // 2.) Reads better.
  // 3.) Enforces version 7.

  const create = vector.create2d;

  interface FormSpecElement {

  }

  export interface FormSpecList extends FormSpecElement {
    location: string
    listName: string
    position: Vec2
    size: Vec2
    startingIndex: number
  }

  export interface FormSpecDefinition {
    size?: Vec2
    fixedSize?: boolean
    position?: Vec2
    anchor?: Vec2
    padding?: Vec2
    disablePrepend?: boolean
    container?: Vec2
  }

  function generate(d: FormSpecDefinition) {
    //? figure out if newlines are necessary.
    //* note: components of formspecs are context sensitive.
    //* so this turns into a bunch of if-then checks in order.
    
    let accumulator = "formspec_version[7]\n"
    if (d.size) {
      const fixed = (d.fixedSize) ? true : false
      const size = d.size
      accumulator += "size[" + size.x + "," + size.y + "," + fixed + "]\n"
    }
    if (d.position) {
      const pos = d.position
      accumulator += "position[" + pos.x + "," + pos.y + "]\n"
    }
    if (d.anchor) {
      const anchor = d.anchor
      accumulator += "anchor[" + anchor.x + "," + anchor.y + "]\n"
    }
    if (d.padding) {
      const p = d.padding
      accumulator += "padding[" + p.x + "," + p.y + "]\n"
    }
    if (d.disablePrepend) {
      accumulator += "no_prepend[]\n"
    }
    print(accumulator)
  }

  generate({
    size: create(8,9)
  })

  
}