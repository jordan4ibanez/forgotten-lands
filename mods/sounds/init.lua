Sounds = Sounds or ({})
do
    function Sounds.grass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "grass_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "grass_dig", gain = 1.5})
        spec.dug = spec.dug or ({name = "grass_dug", gain = 0.8})
        spec.place = spec.place or ({name = "grass_dug", gain = 0.5})
        return spec
    end
    function Sounds.dirt(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 0.9})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function Sounds.wood(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wood_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "wood_dig", gain = 0.7})
        spec.dug = spec.dug or ({name = "wood_dug", gain = 1})
        spec.place = spec.place or ({name = "wood_dug", gain = 0.6})
        return spec
    end
    function Sounds.gravel(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.3})
        spec.dig = spec.dig or ({name = "dirt_dig", gain = 0.6})
        spec.dug = spec.dug or ({name = "gravel_dug", gain = 0.9})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.6})
        return spec
    end
    function Sounds.stone(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "stone_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "stone_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "stone_dug", gain = 1})
        spec.place = spec.place or ({name = "stone_dug", gain = 0.8})
        return spec
    end
    function Sounds.sand(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "sand_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "sand_dug", gain = 1})
        spec.place = spec.place or ({name = "sand_dug", gain = 0.8})
        return spec
    end
    function Sounds.plant(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "dirt_step", gain = 0.5})
        spec.dig = spec.dig or ({name = "sand_dig", gain = 0.9})
        spec.dug = spec.dug or ({name = "dirt_dug", gain = 1})
        spec.place = spec.place or ({name = "dirt_dug", gain = 0.8})
        return spec
    end
    function Sounds.glass(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "glass_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "glass_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "glass_dug", gain = 1})
        spec.place = spec.place or ({name = "glass_step", gain = 0.8})
        return spec
    end
    function Sounds.wool(spec)
        if spec == nil then
            spec = {}
        end
        spec.footstep = spec.footstep or ({name = "wool_step", gain = 0.4})
        spec.dig = spec.dig or ({name = "wool_dig", gain = 0.75})
        spec.dug = spec.dug or ({name = "wool_dug", gain = 1})
        spec.place = spec.place or ({name = "wool_dug", gain = 0.8})
        return spec
    end
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
end
