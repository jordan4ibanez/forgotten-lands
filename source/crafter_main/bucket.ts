/*
BEFORE YOU ASK WHY ARE YOU DOING THIS!

It works better and doesn't block digging with a bucket through water.

https://youtu.be/j0cq27qqnE8
*/
namespace main {

    function bucket_raycast(player: ObjectRef): PointedThing | null {
        const pos: Vec3 = player.get_pos();
        const eyeHeight = player.get_properties().eye_height;
        if (!eyeHeight) {
            throw new Error("How did a player's eye height become null?");
        }
        pos.y = pos.y + eyeHeight;
        let lookDir: Vec3 = player.get_look_dir();
        lookDir = vector.multiply(lookDir, 4);
        const pos2: Vec3 = vector.add(pos, lookDir);

        const ray: RaycastObject = core.raycast(pos, pos2, false, true);

        for (const pointedThing of ray) {

            if (pointedThing !== null) {
                return pointedThing;
            }
        }
        return null;
    }

    // Item definitions.
    // fixme: Why aren't we using functions?!

    core.register_craftitem("main:bucket", {
        description: "Bucket",
        inventory_image: "bucket.png",
        stack_max: 1,
        // wield_image = "bucket.png",
        // liquids_pointable = true,
        on_place: (itemstack: ItemStackObject, placer: ObjectRef, _: PointedThing) => {
            const pointedThing: PointedThing | null = bucket_raycast(placer);

            if (!pointedThing) {
                return;
            }

            const posUnder: Vec3 = pointedThing.under;

            const nodeName: string = core.get_node(posUnder).name;

            if (nodeName === "main:water") {
                itemstack.replace(ItemStack("main:bucket_water"));
                core.remove_node(posUnder);
                return (itemstack);
            } else if (nodeName === "main:lava" || nodeName === "nether:lava") {
                itemstack.replace(ItemStack("main:bucket_lava"));
                core.remove_node(posUnder);
                return (itemstack);
            }
        },

        on_secondary_use: (itemstack: ItemStackObject, user: ObjectRef, _: PointedThing) => {
            const pointedThing: PointedThing | null = bucket_raycast(user);
            if (!pointedThing) {
                return;
            }
            const posUnder: Vec3 = pointedThing.under;

            const nodeName: string = core.get_node(posUnder).name;

            if (nodeName === "main:water") {
                itemstack.replace(ItemStack("main:bucket_water"));
                core.remove_node(posUnder);
                return itemstack;
            } else if (nodeName === "main:lava" || nodeName === "nether:lava") {
                itemstack.replace(ItemStack("main:bucket_lava"));
                core.remove_node(posUnder);
                return itemstack;
            }
        },
    });


    core.register_craftitem("main:bucket_water", {
        description: "Bucket of Water",
        inventory_image: "bucket_water.png",
        stack_max: 1,
        // liquids_pointable = false,
        on_place: (itemstack: ItemStackObject, placer: ObjectRef, _: PointedThing) => {
            const pos: PointedThing | null = bucket_raycast(placer);

            if (!pos) {
                return;
            }

            const posUnder: Vec3 = pos.under;
            const posAbove: Vec3 = pos.above;

            const nodeUnder: string = core.get_node(posUnder).name;
            const nodeAbove: string = core.get_node(posAbove).name;

            const buildableUnder: boolean = (core.registered_nodes[nodeUnder].buildable_to === true);
            const buildableAbove: boolean = (core.registered_nodes[nodeAbove].buildable_to === true);

            // Set it to water.
            if (buildableUnder === true) {
                core.set_node(posUnder, { name: "main:water" });
                itemstack.replace(ItemStack("main:bucket"));
                return itemstack;
            } else if (buildableAbove) {
                core.set_node(posAbove, { name: "main:water" });
                itemstack.replace(ItemStack("main:bucket"));
                return itemstack;
            }
        },
        on_secondary_use: (itemstack: ItemStackObject, user: ObjectRef, pointed_thing) => {
            const pos: PointedThing | null = bucket_raycast(user);

            if (!pos) {
                return;
            }

            const posUnder: Vec3 = pos.under;
            const posAbove: Vec3 = pos.above;

            const nodeUnder: string = core.get_node(posUnder).name;
            const nodeAbove: string = core.get_node(posAbove).name;

            const buildableUnder: boolean = (core.registered_nodes[nodeUnder].buildable_to === true);
            const buildableAbove: boolean = (core.registered_nodes[nodeAbove].buildable_to === true);

            // Set it to water.
            if (buildableUnder === true) {
                core.add_node(posUnder, { name: "main:water" });
                itemstack.replace(ItemStack("main:bucket"));
                return itemstack;
            } else if (buildableAbove) {
                core.add_node(posAbove, { name: "main:water" });
                itemstack.replace(ItemStack("main:bucket"));
                return itemstack;
            }
        },
    });


    // minetest.register_craftitem("main:bucket_lava", {
    // 	description = "Bucket of Lava",
    // 	inventory_image = "bucket_lava.png",
    // 	stack_max = 1,
    // 	--liquids_pointable = false,
    // 	on_place = function(itemstack, placer, pointed_thing)
    // 		if pointed_thing.under and minetest.get_node(pointed_thing.under).name == "tnt:tnt" then
    // 			minetest.remove_node(pointed_thing.under)
    // 			tnt(pointed_thing.under,7)
    // 			itemstack:replace(ItemStack("main:bucket"))
    // 			return(itemstack)
    // 		end

    // 		local pos = bucket_raycast(placer)

    // 		if not pos then
    // 			return
    // 		end

    // 		local pos_under = pos.under
    // 		local pos_above = pos.above

    // 		local node_under = minetest.get_node(pos_under).name
    // 		local node_above = minetest.get_node(pos_above).name

    // 		local buildable_under = (minetest.registered_nodes[node_under].buildable_to == true)
    // 		local buildable_above = (minetest.registered_nodes[node_above].buildable_to == true)

    // 		--set it to lava
    // 		if buildable_under == true then
    // 			if pos_under.y < 20000 then
    // 				if pos_under.y > -10033 then
    // 					minetest.add_node(pos_under,{name="main:lava"})
    // 				else
    // 					minetest.add_node(pos_under,{name="nether:lava"})
    // 				end
    // 				itemstack:replace(ItemStack("main:bucket"))
    // 				return(itemstack)
    // 			end
    // 		elseif buildable_above then
    // 			if pos_above.y < 20000 then
    // 				if pos_above.y > -10033 then
    // 					minetest.add_node(pos_above,{name="main:lava"})
    // 				else
    // 					minetest.add_node(pos_above,{name="nether:lava"})
    // 				end
    // 				itemstack:replace(ItemStack("main:bucket"))
    // 				return(itemstack)
    // 			end
    // 		end
    // 	end,
    // 	on_secondary_use = function(itemstack, user, pointed_thing)
    // 		local pos = bucket_raycast(user)

    // 		if not pos then
    // 			return
    // 		end

    // 		local pos_under = pos.under
    // 		local pos_above = pos.above

    // 		local node_under = minetest.get_node(pos_under).name
    // 		local node_above = minetest.get_node(pos_above).name

    // 		local buildable_under = (minetest.registered_nodes[node_under].buildable_to == true)
    // 		local buildable_above = (minetest.registered_nodes[node_above].buildable_to == true)

    // 		--set it to lava
    // 		if buildable_under == true then
    // 			if pos_under.y < 20000 then
    // 				if pos_under.y > -10033 then
    // 					minetest.add_node(pos_under,{name="main:lava"})
    // 				else
    // 					minetest.add_node(pos_under,{name="nether:lava"})
    // 				end
    // 				itemstack:replace(ItemStack("main:bucket"))
    // 				return(itemstack)
    // 			end
    // 		elseif buildable_above then
    // 			if pos_above.y < 20000 then
    // 				if pos_above.y > -10033 then
    // 					minetest.add_node(pos_above,{name="main:lava"})
    // 				else
    // 					minetest.add_node(pos_above,{name="nether:lava"})
    // 				end
    // 				itemstack:replace(ItemStack("main:bucket"))
    // 				return(itemstack)
    // 			end
    // 		end
    // 	end,
    // })
}