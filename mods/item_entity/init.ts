{
  const println = utility.println;
  const fakeObjectRef = utility.fakeObjectRef;

  let nextID = 0
  function idGenerator(): number {
    const gotten = nextID
    nextID++
    return gotten
  }

  class ItemEntity implements LuaEntity {
    name = ""
    object = fakeObjectRef()
    timer = 0
    cool = 5
    id = -1

    on_activate(staticData: string, delta: number): void {
      // throw new Error("Method not implemented.");
      this.id = idGenerator()
      print(this.cool)
      this.cool += 1
    }

    on_step(delta: number, moveResult: MoveResult): void {
      this.timer += delta
      if (this.timer > 2) {
        print("id: " + this.id + " | cool: " + this.cool)
        this.cool += math.random()
        this.timer = 0
        print(this.name)
        print("---------")
        if (math.random() > 0.7) {
          this.object.remove()
          this.on_step = function(delta: number) {
            this.timer += delta
            if (this.timer > 2) {
              print("I don't feel like it anymore | id:" + this.id)
              
              this.timer = 0
            }
          }
        }
      }
    }
  }

  minetest.register_entity(":test", new ItemEntity())
}