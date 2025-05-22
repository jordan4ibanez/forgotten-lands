namespace main {
	// local
	// minetest,vector,table,pairs,type,math
	// =
	// minetest,vector,table,pairs,type,math

	//
	// Falling entity rewrite.
	//

	// local param_translation = {
	// 	[0] = 0,
	// 	[3] = math.pi/2,
	// 	[2] = math.pi,
	// 	[1] = math.pi*1.5,
	// }

	class FallingNode extends types.Entity {
		override name: string = ":__builtin:falling_node";
		initial_properties = {
			visual: EntityVisual.wielditem,
			visual_size: { x: 0.667, y: 0.667 },
			textures: [],
			physical: true,
			is_visible: false,
			collide_with_objects: false,
			collisionbox: [-0.5, -0.5, -0.5, 0.5, 0.5, 0.5],
		};

		node: MapNode = { name: "", prob: 3, param2: 0, force_place: false };
		// itemstring: string = ""
		// node: string = "";
		meta: MetaData | null = null;
		floats: boolean = false;

		set_node(node: MapNode, meta: MetaRef | MetaData): void {
			node.param2 = node.param2 || 0;

			this.node = node;

			meta = meta || {};

			if (type((meta as MetaRef).to_table) == "function") {
				const attempt = (meta as MetaRef).to_table();
				if (attempt) {
					meta = attempt;
				}
			}

			// This was transformed in the previous statement, I think?
			meta = meta as MetaData;

			for (let [_, list] of pairs(meta.inventory || {})) {
				for (let [i, stack] of pairs(list)) {
					if (type(stack) == "userdata") {
						list[i as number] = (
							stack as ItemStackObject
						).to_string();
					}
				}
			}

			const def: NodeDefinition | null = core.registered_nodes[node.name];

			if (!def) {
				// Don't allow unknown nodes to fall.
				core.log(
					LogLevel.error,
					"Unknown falling node removed at " +
						core.pos_to_string(this.object.get_pos())
				);
				this.object.remove();
				return;
			}

			this.meta = meta;

			// Cache whether we're supposed to float on water.
			this.floats = core.get_item_group(node.name, "float") != 0;

			// -- Save liquidtype for falling water
			// self.liquidtype = def.liquidtype

			// -- Set up entity visuals
			// -- For compatibility with older clients we continue to use "item" visual
			// -- for simple situations.
			// local drawtypes = {normal=true, glasslike=true, allfaces=true, nodebox=true}
			// local p2types = {none=true, facedir=true, ["4dir"]=true}
			// if drawtypes[def.drawtype] and p2types[def.paramtype2] and def.use_texture_alpha ~= "blend" then
			// 	-- Calculate size of falling node
			// 	local s = vector.zero()
			// 	s.x = (def.visual_scale or 1) * 0.667
			// 	s.y = s.x
			// 	s.z = s.x
			// 	-- Compensate for wield_scale
			// 	if def.wield_scale then
			// 		s.x = s.x / def.wield_scale.x
			// 		s.y = s.y / def.wield_scale.y
			// 		s.z = s.z / def.wield_scale.z
			// 	end
			// 	self.object:set_properties({
			// 		is_visible = true,
			// 		visual = "item",
			// 		wield_item = node.name,
			// 		visual_size = s,
			// 		glow = def.light_source,
			// 	})
			// 	-- Rotate as needed
			// 	if def.paramtype2 == "facedir" then
			// 		local fdir = node.param2 % 32 % 24
			// 		local euler = facedir_to_euler[fdir + 1]
			// 		if euler then
			// 			self.object:set_rotation(euler)
			// 		end
			// 	elseif def.paramtype2 == "4dir" then
			// 		local fdir = node.param2 % 4
			// 		local euler = facedir_to_euler[fdir + 1]
			// 		if euler then
			// 			self.object:set_rotation(euler)
			// 		end
			// 	end
			// elseif def.drawtype ~= "airlike" then
			// 	self.object:set_properties({
			// 		is_visible = true,
			// 		node = node,
			// 		glow = def.light_source,
			// 	})
			// end

			// -- Set collision box (certain nodeboxes only for now)
			// local nb_types = {fixed=true, leveled=true, connected=true}
			// if def.drawtype == "nodebox" and def.node_box and
			// 	nb_types[def.node_box.type] and def.node_box.fixed then
			// 	local box = table.copy(def.node_box.fixed)
			// 	if type(box[1]) == "table" then
			// 		box = #box == 1 and box[1] or nil -- We can only use a single box
			// 	end
			// 	if box then
			// 		if def.paramtype2 == "leveled" and (self.node.level or 0) > 0 then
			// 			box[5] = -0.5 + self.node.level / 64
			// 		end
			// 		self.object:set_properties({
			// 			collisionbox = box
			// 		})
			// 	end
			// end
		}

		// get_staticdata = function(self)
		// 	local ds = {
		// 		node = self.node,
		// 		meta = self.meta,
		// 	}
		// 	return minetest.serialize(ds)
		// end,
		// on_activate(staticdata: string) {
		// 	this.object.set_armor_groups({ immortal: 1 });
		// 	const ds: { [id: string | number | symbol]: any } =
		// 		core.deserialize(staticdata);

		// 	if (ds && ds.node) {
		// 		this.set_node(ds.node, ds.meta);
		// 	} else if (ds) {
		// 		this.set_node(ds);
		// 	} else if (staticdata !== "") {
		// 		this.set_node({ name: staticdata });
		// 	}
		// }
		// on_step = function(self, dtime)
		// 	-- Set gravity
		// 	local acceleration = self.object:get_acceleration()
		// 	if not vector.equals(acceleration, {x = 0, y = -10, z = 0}) then
		// 		self.object:set_acceleration({x = 0, y = -10, z = 0})
		// 	end
		// 	-- Turn to actual node when colliding with ground, or continue to move
		// 	local pos = self.object:get_pos()
		// 	-- Position of bottom center point
		// 	local bcp = {x = pos.x, y = pos.y - 0.7, z = pos.z}
		// 	-- 'bcn' is nil for unloaded nodes
		// 	local bcn = minetest.get_node_or_nil(bcp)
		// 	-- Delete on contact with ignore at world edges
		// 	if bcn and bcn.name == "ignore" then
		// 		self.object:remove()
		// 		return
		// 	end
		// 	local bcd = bcn and minetest.registered_nodes[bcn.name]
		// 	if bcn and
		// 			(not bcd or bcd.walkable or
		// 			(minetest.get_item_group(self.node.name, "float") ~= 0 and
		// 			bcd.liquidtype ~= "none")) then
		// 		if bcd and bcd.leveled and
		// 				bcn.name == self.node.name then
		// 			local addlevel = self.node.level
		// 			if not addlevel or addlevel <= 0 then
		// 				addlevel = bcd.leveled
		// 			end
		// 			if minetest.add_node_level(bcp, addlevel) == 0 then
		// 				self.object:remove()
		// 				return
		// 			end
		// 		elseif bcd and bcd.buildable_to and
		// 				(minetest.get_item_group(self.node.name, "float") == 0 or
		// 				bcd.liquidtype == "none") then
		// 			minetest.remove_node(bcp)
		// 			return
		// 		end
		// 		local np = {x = bcp.x, y = bcp.y + 1, z = bcp.z}
		// 		-- Check what's here
		// 		local n2 = minetest.get_node(np)
		// 		local nd = minetest.registered_nodes[n2.name]
		// 		-- If it's not air or liquid, remove node and replace it with
		// 		-- it's drops
		// 		if n2.name ~= "air" and (not nd or nd.liquidtype == "none") then
		// 			local drops = minetest.get_node_drops(self.node.name, "")
		// 			if drops and table.getn(drops) > 0 then
		// 				for _,droppy in pairs(drops) do
		// 					minetest.throw_item(np,droppy)
		// 				end
		// 			else
		// 				minetest.throw_item(np,self.node)
		// 			end
		// 			self.object:remove()
		// 			return
		// 		end
		// 		-- Create node and remove entity
		// 		local def = minetest.registered_nodes[self.node.name]
		// 		if def then
		// 			minetest.add_node(np, self.node)
		// 			if self.meta then
		// 				local meta = minetest.get_meta(np)
		// 				meta:from_table(self.meta)
		// 			end
		// 			if def.sounds and def.sounds.fall then
		// 				minetest.sound_play(def.sounds.fall, {pos = np}, true)
		// 			end
		// 		end
		// 		self.object:remove()
		// 		minetest.check_for_falling(np)
		// 		return
		// 	end
		// 	local vel = self.object:get_velocity()
		// 	if vector.equals(vel, {x = 0, y = 0, z = 0}) then
		// 		local npos = self.object:get_pos()
		// 		self.object:set_pos(vector.round(npos))
		// 	end
		// end
		// })
	}

	utility.registerTSEntity(FallingNode);

	core.register_on_joinplayer((player: ObjectRef) => {
		core.add_item(player.get_pos(), "main:paper");
	});
}
