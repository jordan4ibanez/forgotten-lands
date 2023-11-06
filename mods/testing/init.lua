minetest.register_globalstep(function(delta)
   local random = PcgRandom(delta * 1000000)
   print(random:next(0, 150))
end)
