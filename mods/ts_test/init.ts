module test {
  export function cool() {
    print("cool")
  }
}

{
  let yep = test
  minetest.register_globalstep((delta: number) => {
    print(delta)
  })
}