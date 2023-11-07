
--! Remember to put in \n
println(
  "Loading sounds.\n",
  "Credits:\n"
)

--[[

! - fixme: sand's dig texture doesn't match the rest, look into this.
! - fixme: wood is too hollow!

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
]]

global sounds: GameSoundDispatcher = {}

function sounds.grass_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "grass_step", gain = 0.5}
  spec.dig =      spec.dig      or {name = "grass_dig", gain = 0.5}
  spec.dug =      spec.dug      or {name = "grass_dug", gain = 0.8}
  spec.place =    spec.place    or {name = "grass_dug", gain = 0.5}
  return spec
end

function sounds.dirt_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "dirt_step", gain = 0.3}
  spec.dig =      spec.dig      or {name = "dirt_dig", gain = 0.6}
  spec.dug =      spec.dug      or {name = "dirt_dug", gain = 0.9}
  spec.place =    spec.place    or {name = "dirt_dug", gain = 0.6}
  return spec
end


function sounds.wood_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "wood_step", gain = 0.5}
  spec.dig =      spec.dig      or {name = "wood_dig", gain = 0.7}
  spec.dug =      spec.dug      or {name = "wood_dug", gain = 1.0}
  spec.place =    spec.place    or {name = "wood_dug", gain = 0.6}
  return spec
end

function sounds.gravel_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "dirt_step", gain = 0.3}
  spec.dig =      spec.dig      or {name = "dirt_dig", gain = 0.6}
  spec.dug =      spec.dug      or {name = "gravel_dug", gain = 0.9}
  spec.place =    spec.place    or {name = "dirt_dug", gain = 0.6}
  return spec
end

function sounds.stone_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "stone_step", gain = 0.4}
  spec.dig =      spec.dig      or {name = "stone_dig", gain = 0.75}
  spec.dug =      spec.dug      or {name = "stone_dug", gain = 1.0}
  spec.place =    spec.place    or {name = "stone_dug", gain = 0.8}
  return spec
end

function sounds.sand_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "sand_step", gain = 0.5}
  spec.dig =      spec.dig      or {name = "sand_dig", gain = 0.9}
  spec.dug =      spec.dug      or {name = "sand_dug", gain = 1.0}
  spec.place =    spec.place    or {name = "sand_dug", gain = 0.8}
  return spec
end

function sounds.plant_sounds(spec: NodeSoundSpec): NodeSoundSpec
  if (spec == nil) then
    spec = {}
  end
  spec.footstep = spec.footstep or {name = "dirt_step", gain = 0.5}
  spec.dig =      spec.dig      or {name = "sand_dig", gain = 0.9}
  spec.dug =      spec.dug      or {name = "dirt_dug", gain = 1.0}
  spec.place =    spec.place    or {name = "grass_dug", gain = 0.8}
  return spec
end

global function get_game_sounds():GameSoundDispatcher return sounds end 