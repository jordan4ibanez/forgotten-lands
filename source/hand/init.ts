namespace hand {
  utility.registerNode("hand", {
    tiles: ["character.png"],
    visual_scale: 1,
    wield_scale: vector.create3d(1, 1, 1),
    paramtype: ParamType1.light,
    drawtype: Drawtype.mesh,
    mesh: "hand.b3d"
  })

  minetest.register_on_joinplayer((player: ObjectRef, _: string) => {

    // If the player's inventory disappears, uh oh.
    utility.optionWrap<InvRef>(player.get_inventory())
      .someFunction((inv: InvRef) => {
        inv.set_size("hand", 1);
        inv.set_stack("hand", 1, "hand");
      })
      .noneFunction(() => {
        utility.warning("Player inventory disappeared when creating the 3D hand!");
      })
  });
}