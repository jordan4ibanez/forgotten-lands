namespace Tools {

  // The max level that groups can go up to at the moment.
  export const CURRENT_MAX_LEVEL = 5

  export enum ToolType {
    Pickaxe = "pickaxe",
    Shovel = "shovel",
    Axe = "axe",
    Hoe = "hoe",
    Shears = "shears"
  }

  /**
   * Generates a node tool_groups array.
   * @param table Holds the ToolType and min tool level to drop an item.
   */
  export function generateDropRequirements(table: {[id: string] : number}): string[] {
    let temp: string[] = []
    for (const [toolType, minLevel] of Object.entries(table)) {
      for (let i = minLevel; i <= CURRENT_MAX_LEVEL; i++) {
        temp.push(toolType + "_" + i)
      }
    }
    return temp
  }

  /**
   * Generates a tool group dictionary.
   * @param table The ToolType max level in which it can drop items from the tool group.
   */
  function generateToolDropGroups(table: {[id: string] : number}): {[id: string] : number} {
    let temp: {[id: string] : number} = {}
    for (const [toolType, maxLevel] of Object.entries(table)) {
      for (let i = 1; i <= maxLevel; i++) {
        temp[toolType + "_" + i] = 1
      }
    }
    return temp
  }

  generateToolDropGroups({
    [ToolType.Pickaxe]: 3
  })

  minetest.register_tool(":pickaxe", {
    inventory_image: "default_tool_stonepick.png",
    tool_capabilities: {
      full_punch_interval: 0.5,
      max_drop_level: 1,
      groupcaps: {
        stone: {
          times: {
            1: 1.0
          },
          maxlevel: 1,
          maxdrop: 0
        }
      }
    },
    groups: generateToolDropGroups({
      [ToolType.Pickaxe]: 2
    })
  })
}