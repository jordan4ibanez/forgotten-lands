namespace formSpec {
  // Extremely experimental formspec composable generation.
  //
  // Does a few things:
  //
  // 1.) Organizes better.
  // 2.) Reads better.
  // 3.) Enforces version 7.
  //
  // It is written as so (minorly verbose) to allow:
  // 1.) Elemental compilation (constructor pattern)
  // 2.) Literal compilation. An assignment via nested elements.

  const create = vector.create2d;

  //? Definition root.

  export interface FormsSpecDefinition {
    size?: Vec2
    fixedSize?: boolean
    position?: Vec2
    anchor?: Vec2
    padding?: Vec2
    disablePrepend?: boolean
    elements: FormSpecElement[]
  }

  export class FormSpec {
    size?: Vec2
    fixedSize?: boolean
    position?: Vec2
    anchor?: Vec2
    padding?: Vec2
    disablePrepend?: boolean
    elements: FormSpecElement[] = []

    constructor(definition: FormsSpecDefinition) {
      this.size = definition.size
      this.fixedSize = definition.fixedSize
      this.position = definition.position
      this.anchor = definition.anchor
      this.padding = definition.padding
      this.disablePrepend = definition.disablePrepend
      this.elements = definition.elements
    }

    attachElement(newElement: FormSpecElement): void {
      this.elements.push(newElement)
    }
  }

  // export function newDefinition(definition: FormsSpecDefinition): FormSpec {
  //   const temp: FormSpec = {
  //   }
  //   return temp
  // }

  //? Element prototype.

  interface FormSpecElement {

  }

  //? Container

  export class FormSpecContainer implements FormSpecElement {
    position: Vec2 = create(0,0)
    elements: FormSpecElement[] = []
  }
  export interface FormSpecContainerDefinition {
    position: Vec2
    elements: FormSpecElement[]
  }
  export function newContainer(definition: FormSpecContainerDefinition): FormSpecContainer {
    const temp: FormSpecContainer = {
      position: definition.position,
      elements: definition.elements
    }
    return temp
  }


  //? List

  export interface FormSpecList extends FormSpecElement {
    location: string
    listName: string
    position: Vec2
    size: Vec2
    startingIndex: number
  }

  function processElements(elementArray: FormSpecElement[]) {
    print(dump(elementArray))
    for (const element of elementArray) {
      print(element instanceof FormSpecContainer)
    }
  }

  function generate(d: FormSpec) {
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
    // Now recurse all elements in the array.
    processElements(d.elements)
    // print(accumulator)
  }

  generate(new FormSpec({
    size: create(8,9),
    elements: [
      
    ]
  }))

  
}