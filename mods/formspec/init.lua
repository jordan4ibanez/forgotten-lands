formSpec = formSpec or ({})
do
    local create = vector.create2d
    local function generate(d)
        local accumulator = "formspec_version[7]\n"
        if d.size then
            local ____temp_0
            if d.fixedSize then
                ____temp_0 = true
            else
                ____temp_0 = false
            end
            local fixed = ____temp_0
            local size = d.size
            accumulator = accumulator .. ((((("size[" .. tostring(size.x)) .. ",") .. tostring(size.y)) .. ",") .. tostring(fixed)) .. "]\n"
        end
        print(accumulator)
    end
    generate({size = create(8, 9)})
end
