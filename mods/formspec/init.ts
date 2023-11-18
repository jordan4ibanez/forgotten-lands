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
    elements: Element[]
  }

  export class FormSpec {
    size?: Vec2
    fixedSize?: boolean
    position?: Vec2
    anchor?: Vec2
    padding?: Vec2
    disablePrepend?: boolean
    elements: Element[] = []

    constructor(definition: FormsSpecDefinition) {
      this.size = definition.size
      this.fixedSize = definition.fixedSize
      this.position = definition.position
      this.anchor = definition.anchor
      this.padding = definition.padding
      this.disablePrepend = definition.disablePrepend
      this.elements = definition.elements
    }

    attachElement(newElement: Element): FormSpec {
      this.elements.push(newElement)
      return this
    }
  }

  //? Element prototype.

  interface Element {

  }

  //? Container

  export interface ContainerDefinition {
    position: Vec2
    elements: Element[]
  }

  export class Container implements Element {
    position: Vec2 = create(0,0)
    elements: Element[] = []
    constructor(definition: ContainerDefinition) {
      this.position = definition.position,
      this.elements = definition.elements
    }
    attachElement(newElement: Element): Container {
      this.elements.push(newElement)
      return this
    }
  }

  //? Scroll container

  export enum ScrollOrientation {
    vertical = "vertical",
    horizontal = "horizontal"
  }

  export interface ScrollContainerDefinition extends ContainerDefinition {
    size: Vec2
    orientation: ScrollOrientation
    factor?: number
    name: string
  }

  export class ScrollContainer extends Container {
    size: Vec2 = create(0,0)
    orientation: ScrollOrientation = ScrollOrientation.vertical
    factor: number = 0.1
    name: string = "placeHolder"
    constructor(definition: ScrollContainerDefinition) {
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

  export interface ListDefinition {
    location: string,
    listName: string,
    position: Vec2
    size: Vec2,
    startingIndex: number
  }

  export class List implements Element {
    location: string = ""
    listName: string = ""
    position: Vec2 = create(0,0)
    size: Vec2 = create(0,0)
    startingIndex: number = 0
    constructor(definition: ListDefinition) {
      this.location = definition.location
      this.listName = definition.listName
      this.position = definition.position
      this.size = definition.size
      this.startingIndex = definition.startingIndex
    }
  }

  //? ListRing

  export interface ListRingDefinition {
    location: string
    listName: string
  }

  export class ListRing implements Element {
    location: string = ""
    listName: string = ""
    constructor(definition: ListRingDefinition) {
      this.location = definition.location
      this.listName = definition.listName
    }
  }

  //? ListColors

  export interface ListColorsDefinition {
    slotBGNormal: string
    slotBGHover: string
    slotBorder?: string
    toolTipBGColor?: string
    toolTipFontColor?: string
  }

  export class ListColors implements Element {
    slotBGNormal: string = ""
    slotBGHover: string = ""
    slotBorder?: string
    toolTipBGColor?: string
    toolTipFontColor?: string
  }

  //? ElementToolTip

  export interface ElementToolTipDefinition {
    guiElementName: string
    text: string
    //! Note: This is optional in spec but I don't feel like it at the moment.
    bgColor: string
    fontColor: string
  }

  export class ElementToolTip implements Element {
    guiElementName: string = ""
    text: string = ""
    //! Note: This is optional in spec but I don't feel like it at the moment.
    bgColor: string = ""
    fontColor: string = ""
    constructor(definition: ElementToolTipDefinition) {
      this.guiElementName = definition.guiElementName
      this.text = definition.text
      this.bgColor = definition.bgColor
      this.fontColor = definition.fontColor
    }
  }

  //? AreaToolTip

  export interface AreaToolTipDefinition {
    position: Vec2
    size: Vec2
    text: string
    bgColor: string
    fontColor: string
  }

  export class AreaToolTip implements Element {
    position: Vec2 = create(0,0)
    size: Vec2 = create(0,0)
    text: string = ""
    bgColor: string = ""
    fontColor: string = ""
    constructor(definition: AreaToolTipDefinition) {
      this.position = definition.position
      this.size = definition.size
      this.text = definition.text
      this.bgColor = definition.bgColor
      this.fontColor = definition.fontColor
    }
  }

  //? Image

  export interface ImageDefinition {
    position: Vec2
    size: Vec2
    texture: string
    middle?: string
  }

  export class Image implements Element {
    position: Vec2 = create(0,0)
    size: Vec2 = create(0,0)
    texture: string = ""
    middle?: string
    constructor(definition: ImageDefinition) {
      this.position = definition.position
      this.size = definition.size
      this.texture = definition.texture
      this.middle = definition.middle
    }
  }

  //? AnimatedImage

  export interface AnimatedImageDefinition extends ImageDefinition {
    name: string
    frameCount: number
    frameDuration: number
    frameStart: number
  }

  export class AnimatedImage extends Image {
    name: string = ""
    frameCount: number = 0
    frameDuration: number = 0
    frameStart: number = 0
    constructor(definition: AnimatedImageDefinition) {
      super(definition)
      this.name = definition.name
      this.frameCount = definition.frameCount
      this.frameDuration = definition.frameDuration
      this.frameStart = definition.frameStart
    }
  }
  
  //? Model

  export interface ModelDefinition {
    position: Vec2
    size: Vec2
    name: string
    mesh: string
    //! fixme: Make this an array! Or maybe it can be both string | string[]
    textures: string
    rotation: Vec2
    continuous: boolean
    mouseControl: boolean
    frameLoopRange: Vec2
    animationSpeed: number
  }

  export class Model implements Element {
    position: Vec2 = create(0,0)
    size: Vec2 = create(0,0)
    name: string = ""
    mesh: string = ""
    //! fixme: Make this an array! Or maybe it can be both string | string[]
    textures: string = ""
    rotation: Vec2 = create(0,0)
    continuous: boolean = true
    mouseControl: boolean = true
    frameLoopRange: Vec2 = create(0,0)
    animationSpeed: number = 1
    constructor(definition: ModelDefinition) {
      this.position = definition.position
      this.size = definition. size
      this.name = definition.name
      this.mesh = definition.mesh
      this.textures = definition.textures
      this.rotation = definition.rotation
      this.continuous = definition.continuous
      this.mouseControl = definition.mouseControl
      this.frameLoopRange = definition.frameLoopRange
      this.animationSpeed = definition.animationSpeed
    }
  }


  // ? Functional impelementation

  //* This function will recurse.
  function processElements(accumulator: string, elementArray: Element[]): string {
    // print(dump(elementArray))
    for (const element of elementArray) {

      if (element instanceof Container) {

        const pos = element.position
        accumulator += "container[" +  pos.x + "," + pos.y + "]\n"
        
        //* todo: recurse here.
        // accumulator = processElements(accumulator, element.elements)

        accumulator += "container_end[]\n"

      } else if (element instanceof ScrollContainer) {

        const pos = element.position
        const size = element.size
        accumulator += "scroll_container[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" +
        element.name + ";" + element.orientation + ";" + element.factor + "]\n"

        //* todo: recurse here
        // accumulator = processElements(accumulator, element.elements)

        accumulator += "scroll_container_end[]\n"

      } else if (element instanceof List) {

        const location = element.location
        const listName = element.listName
        const pos = element.position
        const size = element.size
        const startingIndex = element.startingIndex

        accumulator += "list[" + location + ";" + listName + ";" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" + startingIndex + "]\n"

      } else if (element instanceof ListRing) {

        // listring[<inventory location>;<list name>]
        const location = element.location
        const listName = element.listName

        accumulator += "listring[" + location + ";" + listName + "]\n"

      } else if (element instanceof ListColors) {

        //* This is 3 different API implementations in one, so it's using an assembly pattern.
        const slotBGNormal = element.slotBGNormal
        const slotBGHover = element.slotBGHover
        accumulator += "listcolors[" + slotBGNormal + ";" + slotBGHover
        
        // Next definition
        const slotBorder = element.slotBorder
        if (slotBorder) {
          accumulator += ";" + slotBorder

          // Next definition
          const toolTipBGColor = element.toolTipBGColor
          const toolTipFontColor = element.toolTipFontColor

          if (toolTipBGColor && toolTipFontColor) {
            accumulator += ";" + toolTipBGColor + ";" + toolTipFontColor
          }
        }

        // Now finish the sandwich.
        accumulator += "]\n"

      } else if (element instanceof ElementToolTip) {

        const guiElementName = element.guiElementName
        const text = element.text
        const bgColor = element.bgColor
        const fontColor = element.fontColor

        accumulator += "tooltip[" + guiElementName + ";" + text + ";" + bgColor + ";" + fontColor + "]\n"

      } else if (element instanceof AreaToolTip) {
        
        const pos = element.position
        const size = element.size
        const text = element.text
        const bgcolor = element.bgColor
        const fontcolor = element.fontColor

        accumulator += "tooltip[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" + text + ";" + bgcolor + ";" + fontcolor + "]\n"

      } else if (element instanceof Image) {

        const pos = element.position
        const size = element.size
        const texture = element.texture
        const middle = element.middle

        accumulator += "image[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" + texture

        if (middle) {
          accumulator += ";" + middle
        }

        accumulator += "]\n"

      } else if (element instanceof AnimatedImage) {

        //animated_image[<X>,<Y>;<W>,<H>;<name>;<texture name>;<frame count>;<frame duration>;<frame start>;<middle>]

        const pos = element.position
        const size = element.size
        const texture = element.texture
        const name = element.name
        const frameCount = element.frameCount
        const frameDuration = element.frameDuration
        const frameStart = element.frameStart
        const middle = element.middle

        accumulator += "animated_image[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" + 
        name + ";" + texture + ";" + frameCount + ";" + frameDuration + ";" + frameStart

        if (middle) {
          accumulator += ";" + middle
        }

        accumulator += "]\n"

      } else if (element instanceof Model) {
        const pos = element.position
        const size = element.size
        const name = element.name
        const mesh = element.mesh
        const textures = element.textures
        const rotation = element.rotation
        const continuous = element.continuous
        const mouseControl = element.mouseControl
        const frameLoopRange = element.frameLoopRange
        const animationSpeed = element.animationSpeed
        
        accumulator += "model[" + pos.x + "," + pos.y + ";" + size.x + "," + size.y + ";" +
        name + ";" + mesh + ";" + textures + ";" + rotation.x + "," + rotation.y + ";" +
        continuous + ";" + mouseControl + ";" + frameLoopRange.x + "," + frameLoopRange.y + ";" +
        animationSpeed + "]\n"
      }


    }

    
    return accumulator
  }

  export function generate(d: FormSpec): string {
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
    accumulator = processElements(accumulator, d.elements)
    
    return accumulator
  }


  
}