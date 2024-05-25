namespace sounds {

  export function grass(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "grass_step", gain: 1.0 };
    spec.dig = spec.dig || { name: "grass_dig", gain: 1.5 };
    spec.dug = spec.dug || { name: "grass_dug", gain: 0.8 };
    spec.placed = spec.placed || { name: "grass_dug", gain: 0.5 };
    return spec;
  }

  export function dirt(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "dirt_step", gain: 0.3 };
    spec.dig = spec.dig || { name: "dirt_dig", gain: 0.6 };
    spec.dug = spec.dug || { name: "dirt_dug", gain: 0.9 };
    spec.placed = spec.placed || { name: "dirt_dug", gain: 0.6 };
    return spec;
  }

  export function wood(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "wood_step", gain: 0.35 };
    spec.dig = spec.dig || { name: "wood_dig", gain: 0.7 };
    spec.dug = spec.dug || { name: "wood_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "wood_dug", gain: 0.6 };
    return spec;
  }

  export function gravel(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "dirt_step", gain: 0.3 };
    spec.dig = spec.dig || { name: "dirt_dig", gain: 0.6 };
    spec.dug = spec.dug || { name: "gravel_dug", gain: 0.9 };
    spec.placed = spec.placed || { name: "dirt_dug", gain: 0.6 };
    return spec;
  }

  export function stone(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "stone_step", gain: 0.25 };
    spec.dig = spec.dig || { name: "stone_dig", gain: 0.75 };
    spec.dug = spec.dug || { name: "stone_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "stone_dug", gain: 0.8 };
    return spec;
  }

  export function sand(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "sand_step", gain: 0.5 };
    spec.dig = spec.dig || { name: "sand_dig", gain: 0.9 };
    spec.dug = spec.dug || { name: "sand_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "sand_dug", gain: 0.8 };
    return spec;
  }

  export function plant(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "dirt_step", gain: 0.5 };
    spec.dig = spec.dig || { name: "sand_dig", gain: 0.9 };
    spec.dug = spec.dug || { name: "dirt_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "dirt_dug", gain: 0.8 };
    return spec;
  }

  export function glass(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "glass_step", gain: 0.4 };
    spec.dig = spec.dig || { name: "glass_dig", gain: 0.75 };
    spec.dug = spec.dug || { name: "glass_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "glass_step", gain: 0.8 };
    return spec;
  }

  export function wool(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {};
    }
    spec.footstep = spec.footstep || { name: "wool_step", gain: 0.4 };
    spec.dig = spec.dig || { name: "wool_dig", gain: 0.75 };
    spec.dug = spec.dug || { name: "wool_dug", gain: 1.0 };
    spec.placed = spec.placed || { name: "wool_dug", gain: 0.8 };
    return spec;
  }
}
