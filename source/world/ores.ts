import { OreType } from "../utility/enums"

namespace world {
  // These are the minetest v7 ore types because I am lazy and unoriginal.

  //? Coal

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "coal_ore",
    wherein: "stone",
    clust_scarcity: 8 * 8 * 8,
    clust_num_ores: 8,
    clust_size: 3,
    y_max: 64,
    y_min: -127
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "coal_ore",
    wherein: "stone",
    clust_scarcity: 12 * 12 * 12,
    clust_num_ores: 30,
    clust_size: 5,
    y_max: -128,
    y_min: -31000,
  })

  //? Iron

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "iron_ore",
    wherein: "stone",
    clust_scarcity: 9 * 9 * 9,
    clust_num_ores: 12,
    clust_size: 3,
    y_max: 31000,
    y_min: 1025,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "iron_ore",
    wherein: "stone",
    clust_scarcity: 7 * 7 * 7,
    clust_num_ores: 5,
    clust_size: 3,
    y_max: -128,
    y_min: -255,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "iron_ore",
    wherein: "stone",
    clust_scarcity: 12 * 12 * 12,
    clust_num_ores: 29,
    clust_size: 5,
    y_max: -256,
    y_min: -31000,
  })

  //? Gold

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "gold_ore",
    wherein: "stone",
    clust_scarcity: 13 * 13 * 13,
    clust_num_ores: 5,
    clust_size: 3,
    y_max: 31000,
    y_min: 1025,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "gold_ore",
    wherein: "stone",
    clust_scarcity: 15 * 15 * 15,
    clust_num_ores: 3,
    clust_size: 2,
    y_max: -256,
    y_min: -511,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "gold_ore",
    wherein: "stone",
    clust_scarcity: 13 * 13 * 13,
    clust_num_ores: 5,
    clust_size: 3,
    y_max: -512,
    y_min: -31000,
  })

  //? Diamond

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "diamond_ore",
    wherein: "stone",
    clust_scarcity: 14 * 14 * 14,
    clust_num_ores: 5,
    clust_size: 3,
    y_max: 31000,
    y_min: 1025,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "diamond_ore",
    wherein: "stone",
    clust_scarcity: 18 * 18 * 18,
    clust_num_ores: 3,
    clust_size: 2,
    y_max: -512,
    y_min: -1023,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "diamond_ore",
    wherein: "stone",
    clust_scarcity: 14 * 14 * 14,
    clust_num_ores: 5,
    clust_size: 3,
    y_max: -1024,
    y_min: -31000,
  })

  //? Mese

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "mese_ore",
    wherein: "stone",
    clust_scarcity: 15 * 15 * 15,
    clust_num_ores: 4,
    clust_size: 3,
    y_max: 31000,
    y_min: 1025,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "mese_ore",
    wherein: "stone",
    clust_scarcity: 17 * 17 * 17,
    clust_num_ores: 4,
    clust_size: 3,
    y_max: -1024,
    y_min: -2047,
  })

  minetest.register_ore({
    ore_type: OreType.scatter,
    ore: "mese_ore",
    wherein: "stone",
    clust_scarcity: 15 * 15 * 15,
    clust_num_ores: 4,
    clust_size: 3,
    y_max: -2048,
    y_min: -31000,
  })

}