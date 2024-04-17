namespace hand {
  utility.registerNode("hand", {
    tiles: ["character.png"],
    visual_scale: 1,
    wield_scale: vector.create3d(1, 1, 1),
    paramtype: utility.ParamType1.light,
    


  })

  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {
    // print(`hello, ${player.get_player_name()}!`)

  });
}