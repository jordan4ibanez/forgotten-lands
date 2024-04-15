namespace sounds {

  export function grass(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "grass_step", gain: 1.0}
    spec.dig =      spec.dig      || {name: "grass_dig", gain: 1.5}
    spec.dug =      spec.dug      || {name: "grass_dug", gain: 0.8}
    spec.place =    spec.place    || {name: "grass_dug", gain: 0.5}
    return spec
  }

  export function dirt(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "dirt_step", gain: 0.3}
    spec.dig =      spec.dig      || {name: "dirt_dig", gain: 0.6}
    spec.dug =      spec.dug      || {name: "dirt_dug", gain: 0.9}
    spec.place =    spec.place    || {name: "dirt_dug", gain: 0.6}
    return spec
  }

  export function wood(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "wood_step", gain: 0.35}
    spec.dig =      spec.dig      || {name: "wood_dig", gain: 0.7}
    spec.dug =      spec.dug      || {name: "wood_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "wood_dug", gain: 0.6}
    return spec
  }

  export function gravel(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "dirt_step", gain: 0.3}
    spec.dig =      spec.dig      || {name: "dirt_dig", gain: 0.6}
    spec.dug =      spec.dug      || {name: "gravel_dug", gain: 0.9}
    spec.place =    spec.place    || {name: "dirt_dug", gain: 0.6}
    return spec
  }

  export function stone(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "stone_step", gain: 0.25}
    spec.dig =      spec.dig      || {name: "stone_dig", gain: 0.75}
    spec.dug =      spec.dug      || {name: "stone_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "stone_dug", gain: 0.8}
    return spec
  }

  export function sand(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "sand_step", gain: 0.5}
    spec.dig =      spec.dig      || {name: "sand_dig", gain: 0.9}
    spec.dug =      spec.dug      || {name: "sand_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "sand_dug", gain: 0.8}
    return spec
  }

  export function plant(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "dirt_step", gain: 0.5}
    spec.dig =      spec.dig      || {name: "sand_dig", gain: 0.9}
    spec.dug =      spec.dug      || {name: "dirt_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "dirt_dug", gain: 0.8}
    return spec
  }

  export function glass(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "glass_step", gain: 0.4}
    spec.dig =      spec.dig      || {name: "glass_dig", gain: 0.75}
    spec.dug =      spec.dug      || {name: "glass_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "glass_step", gain: 0.8}
    return spec
  }

  export function wool(spec?: NodeSoundSpec): NodeSoundSpec {
    if (spec == null) {
      spec = {}
    }
    spec.footstep = spec.footstep || {name: "wool_step", gain: 0.4}
    spec.dig =      spec.dig      || {name: "wool_dig", gain: 0.75}
    spec.dug =      spec.dug      || {name: "wool_dug", gain: 1.0}
    spec.place =    spec.place    || {name: "wool_dug", gain: 0.8}
    return spec
  }

  //! Remember to put in \n
  print(
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",  
  "| Sounds loaded.                                                          |\n",
  "| Credits:                                                                |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| grass                                                                   |\n",
  "| - step                                                                  |\n",
  "| (1-6) - https://freesound.org/people/RavenWolfProds/sounds/503659/ CC0  |\n",
  "| - dig                                                                   |\n",
  "| (1-4) - https://freesound.org/people/drowsyprincess/sounds/463854/ CC0  |\n",
  "| - dug/place                                                             |\n",
  "| (1-5) - https://freesound.org/people/Adielees9/sounds/331167/ CC0       |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| dirt                                                                    |\n",
  "| - step                                                                  |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/543806/ CC0       |\n",
  "| - dig                                                                   |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0       |\n",
  "| - dug                                                                   |\n",
  "| (1-5) - https://freesound.org/people/Joao_Janz/sounds/571954/ CC0       |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| stone                                                                   |\n",
  "| - step                                                                  |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
  "| - dig                                                                   |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
  "| - dug                                                                   |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0       |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| gravel                                                                  |\n",
  "| - dug                                                                   |\n",
  "| (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0       |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| sand                                                                    |\n",
  "| - dug                                                                   |\n",
  "| (1-6) - https://freesound.org/people/Rach_Capache/sounds/366431/        |\n",
  "| CC BY 3.0 NONCOMMERCIAL                                                 |\n",
  "| - dig                                                                   |\n",
  "| (1-6) - https://freesound.org/people/savataivanov/sounds/384082/ CC0    |\n",
  "| - step                                                                  |\n",
  "| (1-6) - https://freesound.org/people/pan14/sounds/388289/ CC0           |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| wood                                                                    |\n",
  "| - step                                                                  |\n",
  "| (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0 |\n",
  "| - dig                                                                   |\n",
  "| (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0 |\n", 
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n",
  "| glass                                                                   |\n",
  "| - dug                                                                   |\n",
  "| 1 - https://freesound.org/people/awholenewlife1/sounds/422240/ CC0      |\n",
  "| 2 - https://freesound.org/people/RoganMcDougald/sounds/260434/          |\n",
  "| CC BY 3.0                                                               |\n",
  "| 3 - https://freesound.org/people/Tomlija/sounds/97669/ CC BY 3.0        |\n",
  "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n"
  )
}

/*

  item_pickup - https://freesound.org/people/Vilkas_Sound/sounds/463393/ CC BY 4.0
  
  ! - fixme: sand's dig texture doesn't match the rest, look into this.
  ---- old but still usable
  "snow_step(1-6): https://freesound.org/people/crunchymaniac/sounds/696281/ CC0",
  "wool_step(1-6): https://freesound.org/people/Adielees9/sounds/331167/ CC0",
  
  "snow_dig(1-2): https://freesound.org/people/Nox_Sound/sounds/555307/ CC0",
  "snow_dig3: https://freesound.org/people/OwlStorm/sounds/320144/ CC0",
  "snow_dig4: https://freesound.org/people/martian/sounds/19291/ CC0",
  
  ----- 
  
  wool
  - dig
  (1-6) - https://freesound.org/people/DeolandredeJager/sounds/542959/ CC BY 3.0
  - step
  (1-6) - https://freesound.org/people/DeolandredeJager/sounds/542959/ CC BY 3.0
  - dug
  (1-6) - https://freesound.org/people/DeolandredeJager/sounds/542959/ CC BY 3.0
  
  
  
  ! ^ -- HAVEN'T BEEN ADDED TO CREDITS YET
  
  grass
  - step
  (1-6) - https://freesound.org/people/RavenWolfProds/sounds/503659/ CC0
  - dig
  (1-4) - https://freesound.org/people/drowsyprincess/sounds/463854/ CC0
  - dug/place
  (1-5) - https://freesound.org/people/Adielees9/sounds/331167/ CC0
  
  dirt
  - step
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/543806/ CC0
  - dig
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0
  - dug
  (1-5) - https://freesound.org/people/Joao_Janz/sounds/571954/ CC0
  
  stone
  - step
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0
  - dig
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0
  - dug
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/558472/ CC0
  
  gravel
  - dug
  (1-6) - https://freesound.org/people/Nox_Sound/sounds/564893/ CC0
  
  sand
  - dug
  (1-6) - https://freesound.org/people/Rach_Capache/sounds/366431/ CC BY 3.0 NONCOMMERCIAL
  - dig
  (1-6) - https://freesound.org/people/savataivanov/sounds/384082/ CC0
  - step
  (1-6) - https://freesound.org/people/pan14/sounds/388289/ CC0
  
  wood
  - step 
  (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0
  - dig
  (1-6) - https://freesound.org/people/ralph.whitehead/sounds/565714/ CC0
  
  glass
  - dug
  1 - https://freesound.org/people/awholenewlife1/sounds/422240/ CC0
  2 - https://freesound.org/people/RoganMcDougald/sounds/260434/ CC BY 3.0
  3 - https://freesound.org/people/Tomlija/sounds/97669/ CC BY 3.0
  */