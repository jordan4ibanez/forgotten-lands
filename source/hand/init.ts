namespace hand {
  utility.registerNode("hand", {
    // This texture is horrifying and I love it.
    tiles: ["character.png"],
    visual_scale: 1,
    wield_scale: new Vec3(1, 1, 1),

  })

  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {

  });
}