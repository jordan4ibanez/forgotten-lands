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

  //? Element prototype.

  interface FormSpecElement {

  }

  //? Container

  export interface FormSpecContainerDefinition {
    position: Vec2
    elements: FormSpecElement[]
  }

  export class FormSpecContainer implements FormSpecElement {
    position: Vec2 = create(0,0)
    elements: FormSpecElement[] = []
    constructor(definition: FormSpecContainerDefinition) {
      this.position = definition.position,
      this.elements = definition.elements
    }
  }

  //? Scroll container

  export enum ScrollOrientation {
    vertical = "vertical",
    horizontal = "horizontal"
  }

  export interface FormSpecScrollContainerDefinition extends FormSpecContainerDefinition {
    size: Vec2
    orientation: ScrollOrientation
    factor?: number
    name: string
  }

  export class FormSpecScollContainer extends FormSpecContainer {
    size: Vec2 = create(0,0)
    orientation: ScrollOrientation = ScrollOrientation.vertical
    factor: number = 0.1
    name: string = "placeHolder"
    constructor(definition: FormSpecScrollContainerDefinition) {
      super({
        position: definition.position,
        elements: definition.elements
      })
      this.size = definition.size
      this.orientation = definition.orientation
      this.factor = definition.factor || 0.1
      this.name = definition.name
    }
  }

  //? List

  export interface FormSpecList extends FormSpecElement {
    location: string
    listName: string
    position: Vec2
    size: Vec2
    startingIndex: number
  }

  //? This function will recurse.
  function processElements(accumulator: string, elementArray: FormSpecElement[]): string {
    // print(dump(elementArray))
    for (const element of elementArray) {
      if (element instanceof FormSpecContainer) {
        const pos = element.position
        accumulator += "container[" +  pos.x + "," + pos.y + "]\n"
        
        //* todo: recurse here.
        // accumulator = processElements(accumulator, element.elements)

        accumulator += "container_end[]\n"

      } else if (element instanceof FormSpecScollContainer) {
        const pos = element.position
        const size = element.size
        accumulator += "scroll_container[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" +
        element.name + ";" + element.orientation + ";" + element.factor + "]\n"

        //* todo: recurse here
        // accumulator = processElements(accumulator, element.elements)

        accumulator += "scroll_container_end[]\n"
      }
    }
    return accumulator
  }

  function generate(d: FormSpec) {
    //? figure out if newlines are necessary.
    //* note: components of formspecs are context sensitive.
    //* so this turns into a bunch of if-then checks in order.
    
    let accumulator = "formspec_version[7]\n"
    print("running")
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
    accumulator = processElements(accumulator, d.elements)
    print(accumulator)
  }

  generate(new FormSpec({
    size: create(8,9),
    elements: [
      // new FormSpecContainer({
      //   position: create(0,0),
      //   elements: [

      //   ]
      // })
    ]
  }))

  
}