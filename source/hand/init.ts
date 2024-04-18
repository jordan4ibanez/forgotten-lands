namespace hand {

  const optionWrap = utility.optionWrap;
  type Option<T> = utility.Option<T>;
  let warning = utility.warning;


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
    let result: Option<InvRef> = optionWrap<InvRef>(player.get_inventory());
    switch (result.is_some()) {
      case true: {
        const inv = result.unwrap();
        inv.set_size("hand", 1);
        inv.set_stack("hand", 1, "hand");
        break;
      }
      case false: {
        warning("Player inventory disappeared when creating the 3D hand!");
      }
    }
  })
}