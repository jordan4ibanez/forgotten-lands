local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local math = _tl_compat and _tl_compat.math or math; local pairs = _tl_compat and _tl_compat.pairs or pairs; local string = _tl_compat and _tl_compat.string or string; local table = _tl_compat and _tl_compat.table or table; local time_to_live = tonumber(minetest.settings:get("item_entity_ttl")) or 900
local gravity = tonumber(minetest.settings:get("movement_gravity")) or 9.81

local MagnetQueue = {}



MagnetQueue.players = {}
MagnetQueue.deletionQueue = {}

minetest.register_on_joinplayer(function(player)
   local name = player:get_player_name()
   MagnetQueue.players[name] = 0
end)
minetest.register_on_leaveplayer(function(player)
   local name = player:get_player_name()
   MagnetQueue.players[name] = nil
end)
local function add_magnet_pop(player)
   local name = player:get_player_name()
   MagnetQueue.players[name] = MagnetQueue.players[name] + 1
end

minetest.register_globalstep(function()
   for name, remaining in pairs(MagnetQueue.players) do
      if (remaining <= 0) then goto continue end
      local player = minetest.get_player_by_name(name)
      if (not player) then
         table.insert(MagnetQueue.deletionQueue, name)
         goto continue
      end


      minetest.sound_play({
         name = "item_pickup",
      }, {
         gain = 0.15,
         pitch = random_range(0.7, 1.0),
         object = player,
      })

      MagnetQueue.players[name] = remaining - 1
      ::continue::
   end

   if (#MagnetQueue.deletionQueue > 0) then
      for _, name in ipairs(MagnetQueue.deletionQueue) do
         MagnetQueue.players[name] = nil
      end
      MagnetQueue.deletionQueue = {}
   end
end)



local entity = {}














entity.initial_properties = {
   hp_max = 1,
   physical = true,
   collide_with_objects = false,
   collisionbox = { -0.3, -0.3, -0.3, 0.3, 0.3, 0.3 },
   visual = "wielditem",
   visual_size = { x = 0.4, y = 0.4 },
   textures = { "" },
   is_visible = false,
   pointable = false,
}
entity.itemstring = ""
entity.moving_state = true
entity.physical_state = true

entity.age = 0

entity.force_out = nil
entity.force_out_start = nil
entity.collected = false

function entity:set_item(item)
   local stack = ItemStack(item or self.itemstring)
   self.itemstring = stack:to_string()
   if self.itemstring == "" then

      return
   end



   local itemname = stack:is_known() and stack:get_name() or "unknown"




   local size = 0.21


   local def = minetest.registered_items[itemname]
   local glow = def and def.light_source and math.floor(def.light_source / 2 + 0.5)

   local size_bias = 1e-3 * math.random()
   local c = { -size, -size, -size, size, size, size }
   self.object:set_properties({
      is_visible = true,
      visual = "wielditem",
      textures = { itemname },
      visual_size = { x = size + size_bias, y = size + size_bias },
      collisionbox = c,
      automatic_rotate = 1,
      wield_item = self.itemstring,
      glow = glow,
      infotext = stack:get_description(),
   })


   self._collisionbox = c
end

function entity:get_staticdata()
   return minetest.serialize({
      itemstring = self.itemstring,
      age = self.age,
      dropped_by = self.dropped_by,
   })
end

function entity:on_activate(staticdata, dtime_s)
   if string.sub(staticdata, 1, string.len("return")) == "return" then
      local data = minetest.deserialize(staticdata)
      if data and type(data) == "table" then
         self.itemstring = data.itemstring
         self.age = (data.age or 0) + dtime_s
         self.dropped_by = data.dropped_by
      end
   else
      self.itemstring = staticdata
   end
   self.object:set_armor_groups({ immortal = 1 })
   self.object:set_velocity({ x = 0, y = 2, z = 0 })
   self.object:set_acceleration({ x = 0, y = -gravity, z = 0 })
   self._collisionbox = self.initial_properties.collisionbox
   self:set_item()
end


function entity:enable_physics()
   if self.physical_state then return end
   self.physical_state = true
   self.object:set_properties({ physical = true })
   self.object:set_velocity({ x = 0, y = 0, z = 0 })
   self.object:set_acceleration({ x = 0, y = -gravity, z = 0 })
end

function entity:disable_physics()
   if not self.physical_state then return end
   self.physical_state = false
   self.object:set_properties({ physical = false })
   self.object:set_velocity({ x = 0, y = 0, z = 0 })
   self.object:set_acceleration({ x = 0, y = 0, z = 0 })
end

function entity:tick_age(delta)
   self.age = self.age + delta
   if time_to_live > 0 and self.age > time_to_live then
      self.itemstring = ""
      self.object:remove()
      return true
   end
   return false
end

function entity:check_out_of_bounds(node)

   if node and (node).name == "ignore" then
      self.itemstring = ""
      self.object:remove()
      return true
   end
   return false
end

function entity:slip_check(delta, def, node)
   if not def then return false end
   local slippery = minetest.get_item_group(node.name, "slippery")
   local vel = self.object:get_velocity()
   if slippery ~= 0 and (math.abs(vel.x) > 0.1 or math.abs(vel.z) > 0.1) then

      local factor = math.min(4 / (slippery + 4) * delta, 1)
      self.object:set_velocity({
         x = vel.x * (1 - factor),
         y = 0,
         z = vel.z * (1 - factor),
      })
      return true
   end
   return false
end

function entity:force_out_check(pos)
   if not self.force_out then return false end



   local c = self._collisionbox
   local s = self.force_out_start
   local f = self.force_out
   local ok = (f.x > 0 and pos.x + c[1] > s.x + 0.5) or
   (f.y > 0 and pos.y + c[2] > s.y + 0.5) or
   (f.z > 0 and pos.z + c[3] > s.z + 0.5) or
   (f.x < 0 and pos.x + c[4] < s.x - 0.5) or
   (f.z < 0 and pos.z + c[6] < s.z - 0.5)

   if not ok then return false end


   self.force_out = nil
   self:enable_physics()
   return true
end

function entity:unstuck_self(pos, is_stuck)
   if not is_stuck then return end

   local shootdir

   local order = {
      { x = 1, y = 0, z = 0 }, { x = -1, y = 0, z = 0 },
      { x = 0, y = 0, z = 1 }, { x = 0, y = 0, z = -1 },
   }


   for o = 1, #order do
      local cnode = minetest.get_node(vector.add(pos, order[o])).name
      local cdef = minetest.registered_nodes[cnode] or {}
      if cnode ~= "ignore" and cdef.walkable == false then
         shootdir = order[o]
         break
      end
   end


   if not shootdir then
      shootdir = { x = 0, y = 1, z = 0 }
      local cnode = minetest.get_node(vector.add(pos, shootdir)).name
      if cnode == "ignore" then
         shootdir = nil
      end
   end


   if not shootdir then return end


   local newv = vector.multiply(shootdir, 3)
   self:disable_physics()
   self.object:set_velocity(newv)

   self.force_out = newv
   self.force_out_start = vector.round(pos)
   return
end


local pos_a = vector.new()
local pos_b = vector.new()
local function distance_2d(vec_1, vec_2)
   pos_a.x = vec_1.x
   pos_a.y = 0
   pos_a.z = vec_1.z
   pos_b.x = vec_2.x
   pos_b.y = 0
   pos_b.z = vec_2.z
   return vector.distance(pos_a, pos_b)
end

function entity:poll_players(pos)
   if (self.collected) then return end
   if (not self.age) then return end
   if (self.age < 1.5) then return end

   local solved = false
   for _, player in ipairs(minetest.get_connected_players()) do
      if (solved) then goto continue end
      local player_pos = player:get_pos()
      if (vector.distance(pos, player_pos) > 3) then goto continue end
      if (distance_2d(pos, player_pos) > 1.5) then goto continue end
      if (player_pos.y - pos.y > 0.05) then goto continue end
      local inv = player:get_inventory()
      if (not inv) then goto continue end
      if (not inv:room_for_item("main", self.itemstring)) then return end
      inv:add_item("main", self.itemstring)


      player_pos.y = player_pos.y + 0.8
      self:disable_physics()
      self.object:set_velocity(vector.multiply(vector.direction(pos, player_pos), 10))
      self.object:move_to(player_pos, true)
      solved = true
      self.age = 0
      self.collected = true
      add_magnet_pop(player)

      ::continue::
   end
end

function entity:collection_cleanup(delta)
   self.age = self.age + delta
   if (self.age < 0.2) then return end
   self.object:remove()
end

function entity:on_step(dtime, moveresult)
   if (self.collected) then
      self:collection_cleanup(dtime)
      return
   end

   local pos = self.object:get_pos()

   self:poll_players(pos)

   if (self:tick_age(dtime)) then return end

   local node = minetest.get_node_or_nil({
      x = pos.x,
      y = pos.y + self._collisionbox[2] - 0.05,
      z = pos.z,
   })

   if (self:check_out_of_bounds(node)) then return end


   if moveresult == nil and self.object:get_attach() then
      return
   end

   if self:force_out_check(pos) then return end


   if not self.physical_state then
      return
   end

   if not moveresult.collides then

      return
   end


   local is_stuck = false
   local snode = minetest.get_node_or_nil(pos)
   if snode then
      local sdef = minetest.registered_nodes[(snode).name] or {}
      is_stuck = (sdef.walkable == nil or sdef.walkable == true) and
      (sdef.collision_box == nil or sdef.collision_box.type == "regular") and
      (sdef.node_box == nil or sdef.node_box.type == "regular")

      self:unstuck_self()
   end

   node = nil
   if moveresult.touching_ground then
      for _, info in ipairs(moveresult.collisions) do
         if info.axis == "y" then
            node = minetest.get_node(info.node_pos)
            break
         end
      end
   end


   local def = node and minetest.registered_nodes[(node).name]
   local keep_movement = self:slip_check(dtime, def, node)


   if not keep_movement then
      self.object:set_velocity({ x = 0, y = 0, z = 0 })
   end

   if self.moving_state == keep_movement then

      return
   end
   self.moving_state = keep_movement
end

minetest.register_entity(":__builtin:item", entity)
