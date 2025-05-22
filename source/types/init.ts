namespace types {
	export enum ToolType {
		Pickaxe = "pickaxe",
		Shovel = "shovel",
		Axe = "axe",
		Hoe = "hoe",
		Sword = "sword",
		Shears = "shears",
	}

	export enum BlockType {
		break_instant = "break_instant",
		soil = "soil",
		wood = "wood",
		leaf = "leaf",
		stone = "stone",
		metal = "metal",
		glass = "glass",
		wool = "wool",
		planks = "planks",
		tree = "tree",
		sand = "sand",
		lava_cooling = "lava_cooling",
		liquid = "liquid",
		water = "water",
		attached_node = "attached_node",
	}

	// This one is quite useful for crafting recipes.
	export enum CraftingBlockType {
		soil = "group:soil",
		wood = "group:wood",
		leaf = "group:leaf",
		stone = "group:stone",
		metal = "group:metal",
		glass = "group:glass",
		wool = "group:wool",
		planks = "group:planks",
		tree = "group:tree",
		sand = "group:sand",
	}

	export enum DamageGroup {
		flesh = "flesh",
		metal = "metal",
		bone = "bone",
	}

	export enum CraftRecipeType {
		shapeless = "shapeless",
		toolrepair = "toolrepair",
		cooking = "cooking",
		fuel = "fuel",
	}

	export enum EntityVisual {
		cube = "cube",
		sprite = "sprite",
		upright_sprite = "upright_sprite",
		mesh = "mesh",
		wielditem = "wielditem",
		item = "item",
	}

	/** Typescript Luaentity. :) */
	export abstract class Entity implements LuaEntity {
		// Name is required.
		abstract name: string;
		object: ObjectRef = utility.fakeRef();

		// Abstract members.
		initial_properties?: ObjectProperties | undefined;
		on_activate?(staticData: string, delta: number): void;
		on_deactivate?(removal: boolean): void;
		on_step?(delta: number, moveResult: MoveResult): void;
		on_punch?(
			puncher: ObjectRef,
			timeFromLastPunch: number,
			toolCapabilities: ToolCapabilities,
			dir: Vec3,
			damage: number
		): void;
		on_death?(killer: ObjectRef): void;
		on_rightclick?(clicker: ObjectRef): void;
		on_attach_child?(child: ObjectRef): void;
		on_detach_child?(child: ObjectRef): void;
		on_detach?(parent: ObjectRef): void;
		get_staticdata?(): string;
	}
}
