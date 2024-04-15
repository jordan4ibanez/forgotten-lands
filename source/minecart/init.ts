namespace minecart {
  const fakeRef = utility.fakeRef

  class MinecartEntity implements LuaEntity {
    name = "minecart"
    object = fakeRef()
    initial_properties = {
      visual: EntityVisual.mesh,
      // Reference: carts_cart.b3d
      mesh: "minecart.b3d",
      textures: ["minecart.png"]
    }
  }

  minetest.registerTSEntity(MinecartEntity)
}