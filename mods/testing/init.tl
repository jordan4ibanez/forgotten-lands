minetest.register_globalstep(function(delta: number)
  local random: PcgRandomObject = PcgRandom(delta * 1000000)


  local noiseParameters: NoiseParams = {
    offset = 1,
    scale = 1,
    spread = {x = 1000, y = 1000, z = 1000},
    octaves = 10,
    persistence = 3,
    lacunarity = 2
  }
  -- print(random:next(0, 150))
  local perlin: PerlinNoiseObject = PerlinNoise(noiseParameters)

  local noisey: number = perlin:get_2d({x = random:next(0, 100), y = random:next(0, 100)})
  -- print(noisey)

  local noiseMappy: PerlinNoiseMapObject = PerlinNoiseMap(noiseParameters, {x = 100, y = 100, z = 100})

  local ray: RaycastObject = Raycast({x=0,y=0,z=0}, {x=10,y=10,z=10})

  -- Can't find a better way to make this work
  while true do
    local gotten: PointedThing | nil = ray:next()
    if (gotten == nil) then break end
    print(dump(gotten))
  end

  -- for pointed_thing in blah:next() do
  --   print(dump(pointed_thing))
  -- end
end)