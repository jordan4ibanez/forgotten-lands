namespace mob {

    const create3d = vector.create3d;

    /**
     * As per defined by lemente:
     * 
     * [motivation needed] — 5/12/24 at 6:06 PM
     * (Invisible) Mob idea: pre-recorded laughing track that gets more and more distorted the angrier it gets.
     * 
     * Possible options:
     * 
     * A generic sound on loop in which resets to a more distorted sound clip based on how damaged it is.
     * 
     * Can use the same size as a player.
     * 
     * Not sure if it should even physically attack. Maybe it could just drain your health.
     * 
     */

    class DeathKnell extends Mob {
        name = "death_knell";
        hp = 5;

        initial_properties: ObjectProperties = {
            // visual: EntityVisual.mesh,
            // mesh: "mobs_mc_pig.b3d",
            // textures: ["blank.png", "mobs_mc_pig.png", "mobs_mc_pig.png"],
            // visual_size: create3d(3, 3, 3)
        };

        on_step(delta: number, moveResult: MoveResult): void {
            print("Haha");
        }
    }

    utility.registerTSEntity(DeathKnell);
}