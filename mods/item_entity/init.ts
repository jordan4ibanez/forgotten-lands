{
  const println = utility.println;
  const fakeObjectRef = utility.fakeObjectRef;

  let nextID = 0
  function idGenerator(): number {
    const gotten = nextID
    nextID++
    return gotten
  }
  const velocityWorker = vector.create(0,0,0)

  // forgot I was in ts lol
  function clamp(min: number, max: number, input: number): number {
    if (input < min) {
      return min
    } else if (input > max) {
      return max
    }
    return input
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
      for (const player of minetest.get_connected_players()) {
        print(player.get_player_name())
        const playerPos = player.get_pos()
        const pos = this.object.get_pos()
        const normalized = vector.direction(playerPos, pos)
        const maxSpeed = 100
        const goalDistance = 10
        const snappiness = 1000
        const distance = clamp(0, maxSpeed, (goalDistance - vector.distance(pos, playerPos)) * snappiness)

        const velocity = vector.multiply(normalized, distance)
        this.object.set_velocity(velocity)

        if (math.random() > 0.995) {
          print("see ya")
          this.object.remove()
        } else {
          print("not this time! " + math.random())
        }
      }
    }
  }

  minetest.register_entity(":test", new ItemEntity())
}

/*
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
      }*/