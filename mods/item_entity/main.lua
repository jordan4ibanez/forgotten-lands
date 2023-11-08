local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local math = _tl_compat and _tl_compat.math or math; local string = _tl_compat and _tl_compat.string or string















local time_to_live = tonumber(minetest.settings:get("item_entity_ttl")) or 900
local gravity = tonumber(minetest.settings:get("movement_gravity")) or 9.81


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
}
entity.itemstring = ""
entity.moving_state = true
entity.physical_state = true

entity.age = 0

entity.force_out = nil
entity.force_out_start = nil

function entity:cool()

end

function entity:set_item(item)
   local stack = ItemStack(item or self.itemstring)
   self.itemstring = stack:to_string()
   if self.itemstring == "" then

      return
   end



   local itemname = stack:is_known() and stack:get_name() or "unknown"

   local max_count = stack:get_stack_max()
   local count = math.min(stack:get_count(), max_count)
   local size = 0.2 + 0.1 * (count / max_count) ^ (1 / 3)
   local def = minetest.registered_items[itemname]
   local glow = def and def.light_source and
   math.floor(def.light_source / 2 + 0.5)

   local size_bias = 1e-3 * math.random()
   local c = { -size, -size, -size, size, size, size }
   self.object:set_properties({
      is_visible = true,
      visual = "wielditem",
      textures = { itemname },
      visual_size = { x = size + size_bias, y = size + size_bias },
      collisionbox = c,
      automatic_rotate = math.pi * 0.5 * 0.2 / size,
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

























































































































































































































































minetest.register_entity(":__builtin:item", entity)
