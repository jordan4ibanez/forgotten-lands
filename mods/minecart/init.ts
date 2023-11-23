namespace minecart {
  const fakeRef = utility.fakeRef

  class MinecartEntity implements LuaEntity {
    name = "minecart"
    object = fakeRef()
    initial_properties = {
      mesh: "minecart.b3d",
      textures: ["default_dirt.png"]
    }
  }

  minetest.registerTSEntity(MinecartEntity)
}