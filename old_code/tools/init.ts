namespace tools {

    // The max level that groups can go up to at the moment.
    export const CURRENT_MAX_LEVEL = 5;

    // Yoinked from MineClone2. But smallerized.
    export const wieldScale = vector.create3d(1.5, 1.5, 1);

    /**
     * Generates a node tool_groups array.
     * @param table Holds the ToolType and min tool level to drop an item.
     */
    export function generateDropRequirements(table: { [id: string]: number; }): string[] {
        let temp: string[] = [];
        for (const [toolType, minLevel] of Object.entries(table)) {
            for (let i = minLevel; i <= CURRENT_MAX_LEVEL; i++) {
                temp.push(toolType + "_" + i);
            }
        }
        return temp;
    }

    /**
     * Generates a tool group dictionary.
     * @param table The ToolType max level in which it can drop items from the tool group.
     */
    export function generateToolDropGroups(table: { [id: string]: number; }): { [id: string]: number; } {
        let temp: { [id: string]: number; } = {};
        for (const [toolType, maxLevel] of Object.entries(table)) {
            for (let i = 1; i <= maxLevel; i++) {
                temp[toolType + "_" + i] = 1;
            }
        }
        return temp;
    }

    utility.loadFiles(["hand", "pickaxe", "shovel", "axe", "sword", "shears", "groupify"]);
}