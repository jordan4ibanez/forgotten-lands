minetest.register_globalstep(function(delta: number)
  local random: PcgRandomObject = PcgRandom(delta * 1000000)
  -- print(random:next(0, 150))
  local perlin: PerlinNoiseObject = PerlinNoise({
    offset = 1,
    scale = 1,
    spread = {x = 1000, y = 1000, z = 1000},
    octaves = 10,
    persistence = 3,
    lacunarity = 2
  })

  local noisey = perlin:get_2d({x = random:next(0, 100), y = random:next(0, 100)})
  print(noisey)
end)