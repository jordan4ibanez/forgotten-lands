test = test or ({})
do
    function test.cool(self)
        print("cool")
    end
end
do
    local yep = test
    minetest.register_globalstep(function(delta)
        print(delta)
    end)
end
