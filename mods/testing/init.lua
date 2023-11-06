minetest.register_globalstep(function(delta)
   local random = PcgRandom(delta * 1000000)


   local noiseParameters = {
      offset = 1,
      scale = 1,
      spread = { x = 1000, y = 1000, z = 1000 },
      octaves = 10,
      persistence = 3,
      lacunarity = 2,
   }

   local perlin = PerlinNoise(noiseParameters)

   local noisey = perlin:get_2d({ x = random:next(0, 100), y = random:next(0, 100) })


   local noiseMappy = PerlinNoiseMap(noiseParameters, { x = 100, y = 100, z = 100 })

   local ray = Raycast({ x = 0, y = 0, z = 0 }, { x = 10, y = 10, z = 10 })


   while true do
      local gotten = ray:next()
      if (gotten == nil) then break end
      print(dump(gotten))
   end




end)
