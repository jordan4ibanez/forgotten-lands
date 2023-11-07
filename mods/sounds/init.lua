

println(
"Loading sounds.\n",
"Credits:\n")
























































sounds = {}

function sounds.grass_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "grass_step", gain = 0.5 }
   spec.dig = spec.dig or { name = "grass_dig", gain = 1.5 }
   spec.dug = spec.dug or { name = "grass_dug", gain = 0.8 }
   spec.place = spec.place or { name = "grass_dug", gain = 0.5 }
   return spec
end

function sounds.dirt_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "dirt_step", gain = 0.3 }
   spec.dig = spec.dig or { name = "dirt_dig", gain = 0.6 }
   spec.dug = spec.dug or { name = "dirt_dug", gain = 0.9 }
   spec.place = spec.place or { name = "dirt_dug", gain = 0.6 }
   return spec
end


function sounds.wood_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "wood_step", gain = 0.5 }
   spec.dig = spec.dig or { name = "wood_dig", gain = 0.7 }
   spec.dug = spec.dug or { name = "wood_dug", gain = 1.0 }
   spec.place = spec.place or { name = "wood_dug", gain = 0.6 }
   return spec
end

function sounds.gravel_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "dirt_step", gain = 0.3 }
   spec.dig = spec.dig or { name = "dirt_dig", gain = 0.6 }
   spec.dug = spec.dug or { name = "gravel_dug", gain = 0.9 }
   spec.place = spec.place or { name = "dirt_dug", gain = 0.6 }
   return spec
end

function sounds.stone_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "stone_step", gain = 0.4 }
   spec.dig = spec.dig or { name = "stone_dig", gain = 0.75 }
   spec.dug = spec.dug or { name = "stone_dug", gain = 1.0 }
   spec.place = spec.place or { name = "stone_dug", gain = 0.8 }
   return spec
end

function sounds.sand_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "sand_step", gain = 0.5 }
   spec.dig = spec.dig or { name = "sand_dig", gain = 0.9 }
   spec.dug = spec.dug or { name = "sand_dug", gain = 1.0 }
   spec.place = spec.place or { name = "sand_dug", gain = 0.8 }
   return spec
end

function sounds.plant_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "dirt_step", gain = 0.5 }
   spec.dig = spec.dig or { name = "sand_dig", gain = 0.9 }
   spec.dug = spec.dug or { name = "dirt_dug", gain = 1.0 }
   spec.place = spec.place or { name = "dirt_dug", gain = 0.8 }
   return spec
end

function sounds.glass_sounds(spec)
   if (spec == nil) then
      spec = {}
   end
   spec.footstep = spec.footstep or { name = "glass_step", gain = 0.4 }
   spec.dig = spec.dig or { name = "glass_dig", gain = 0.75 }
   spec.dug = spec.dug or { name = "glass_dug", gain = 1.0 }
   spec.place = spec.place or { name = "glass_step", gain = 0.8 }
   return spec
end

function get_game_sounds() return sounds end
