minetest.register_globalstep(function(delta: number)
  local random: PcgRandomObject = PcgRandom(delta * 1000000)
  print(random:next(0, 100))
end)