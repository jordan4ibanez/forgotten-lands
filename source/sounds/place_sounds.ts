namespace sounds {

  // Server runs the place sound so they actually play normally.
  minetest.register_on_placenode(function (pos: Vec3, node: NodeTable) {
    print(dump(pos));

    const name = node.name;

    print(name);
  });
}