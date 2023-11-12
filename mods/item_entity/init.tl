
-- ? This could be useful in the future.
-- function core.spawn_item(pos, item)
-- 	-- Take item in any format
-- 	local stack = ItemStack(item)
-- 	local obj = core.add_entity(pos, "__builtin:item")
-- 	-- Don't use obj if it couldn't be added to the map.
-- 	if obj then
-- 		obj:get_luaentity():set_item(stack:to_string())
-- 	end
-- 	return obj
-- end

-- If item_entity_ttl is not set, enity will have default life time
-- Setting it to -1 disables the feature

local time_to_live = tonumber(minetest.settings:get("item_entity_ttl")) or 900
local gravity = tonumber(minetest.settings:get("movement_gravity")) or 9.81


local record entity
  object: ObjectRef
  initial_properties: ObjectProperties
  itemstring: string
  moving_state: boolean
  physical_state: boolean
  age: number
  force_out: Vec3
  force_out_start: Vec3
  _collisionbox: CollisionBox
  dropped_by: string
  -- magnet components
  collected: boolean
end

entity.initial_properties = {
  hp_max = 1,
  physical = true,
  collide_with_objects = false,
  collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.3, 0.3},
  visual = "wielditem",
  visual_size = {x = 0.4, y = 0.4},
  textures = {""},
  is_visible = false,
  pointable = false
}
entity.itemstring = ""
entity.moving_state = true
entity.physical_state = true
-- Item expiry
entity.age = 0
-- Pushing item out of solid nodes
entity.force_out = nil
entity.force_out_start = nil
entity.collected = false

function entity:set_item(item: ItemStackObject | string)
  local stack = ItemStack(item or self.itemstring)
  self.itemstring = stack:to_string()
  if self.itemstring == "" then
    -- item not yet known
    return
  end

  -- Backwards compatibility: old clients use the texture
  -- to get the type of the item
  local itemname = stack:is_known() and stack:get_name() or "unknown"

  -- local max_count = stack:get_stack_max()
  -- local count = math.min(stack:get_count(), max_count)

  local size = 0.21 -- + 0.1 * (count / max_count) ^ (1 / 3)


  local def = minetest.registered_items[itemname]
  local glow = def and def.light_source and math.floor(def.light_source / 2 + 0.5)

  local size_bias = 1e-3 * math.random() -- small random bias to counter Z-fighting
  local c = {-size, -size, -size, size, size, size}
  self.object:set_properties({
    is_visible = true,
    visual = "wielditem",
    textures = {itemname},
    visual_size = {x = size + size_bias, y = size + size_bias},
    collisionbox = c,
    automatic_rotate = 1, -- * 0.5 * 0.2 / size,
    wield_item = self.itemstring,
    glow = glow,
    infotext = stack:get_description(),
  })

  -- cache for usage in on_step
  self._collisionbox = c
end

function entity:get_staticdata(): string
  return minetest.serialize({
    itemstring = self.itemstring,
    age = self.age,
    dropped_by = self.dropped_by
  })
end

function entity:on_activate(staticdata: string, dtime_s: number)
  if string.sub(staticdata, 1, string.len("return")) == "return" then
    local data = minetest.deserialize(staticdata)
    if data and type(data) == "table" then
      self.itemstring = data.itemstring as string
      self.age = (data.age as number or 0) + dtime_s
      self.dropped_by = data.dropped_by as string
    end
  else
    self.itemstring = staticdata
  end
  self.object:set_armor_groups({immortal = 1})
  self.object:set_velocity({x = 0, y = 2, z = 0})
  self.object:set_acceleration({x = 0, y = -gravity, z = 0})
  self._collisionbox = self.initial_properties.collisionbox
  self:set_item()
end


function entity:enable_physics()
  if self.physical_state then return end
  self.physical_state = true
  self.object:set_properties({physical = true})
  self.object:set_velocity({x=0, y=0, z=0})
  self.object:set_acceleration({x=0, y=-gravity, z=0})
end

function entity:disable_physics()
  if not self.physical_state then return end
  self.physical_state = false
  self.object:set_properties({physical = false})
  self.object:set_velocity({x=0, y=0, z=0})
  self.object:set_acceleration({x=0, y=0, z=0})
end

function entity:tick_age(delta: number): boolean
  self.age = self.age + delta
  if time_to_live > 0 and self.age > time_to_live then
    self.itemstring = ""
    self.object:remove()
    return true
  end
  return false
end

function entity:check_out_of_bounds(node: NodeTable | nil): boolean
  -- Delete in 'ignore' nodes
  if node and (node as NodeTable).name == "ignore" then
    self.itemstring = ""
    self.object:remove()
    return true
  end
  return false
end

function entity:slip_check(delta: number, def: NodeDefinition, node: NodeTable): boolean
  if not def then return false end
  local slippery = minetest.get_item_group(node.name, "slippery")
  local vel = self.object:get_velocity()
  if slippery ~= 0 and (math.abs(vel.x) > 0.1 or math.abs(vel.z) > 0.1) then
    -- Horizontal deceleration
    local factor = math.min(4 / (slippery + 4) * delta, 1)
    self.object:set_velocity({
      x = vel.x * (1 - factor),
      y = 0,
      z = vel.z * (1 - factor)
    })
    return true
  end
  return false
end

function entity:force_out_check(pos: Vec3): boolean
  if not self.force_out then return false end

  -- This code runs after the entity got a push from the is_stuck code.
  -- It makes sure the entity is entirely outside the solid node
  local c = self._collisionbox
  local s = self.force_out_start
  local f = self.force_out
  local ok = (f.x > 0 and pos.x + c[1] > s.x + 0.5) or
    (f.y > 0 and pos.y + c[2] > s.y + 0.5) or
    (f.z > 0 and pos.z + c[3] > s.z + 0.5) or
    (f.x < 0 and pos.x + c[4] < s.x - 0.5) or
    (f.z < 0 and pos.z + c[6] < s.z - 0.5)

  if not ok then return false end
  
  -- Item was successfully forced out
  self.force_out = nil
  self:enable_physics()
  return true
end

function entity:unstuck_self(pos: Vec3, is_stuck: boolean)
  if not is_stuck then return end

  local shootdir: Vec3

  local order = {
    {x=1, y=0, z=0}, {x=-1, y=0, z= 0},
    {x=0, y=0, z=1}, {x= 0, y=0, z=-1},
  }

  -- Check which one of the 4 sides is free
  for o = 1, #order do
    local cnode = minetest.get_node(vector.add(pos, order[o])).name
    local cdef = minetest.registered_nodes[cnode] or {}
    if cnode ~= "ignore" and cdef.walkable == false then
      shootdir = order[o]
      break
    end
  end

  -- If none of the 4 sides is free, check upwards
  if not shootdir then
    shootdir = {x=0, y=1, z=0}
    local cnode = minetest.get_node(vector.add(pos, shootdir)).name
    if cnode == "ignore" then
      shootdir = nil -- Do not push into ignore
    end
  end

  -- Everything failed, give up
  if not shootdir then return end

  -- Set new item moving speed accordingly
  local newv = vector.multiply(shootdir, 3)
  self:disable_physics()
  self.object:set_velocity(newv)

  self.force_out = newv
  self.force_out_start = vector.round(pos)
  return
end

-- A cached object pair.
local pos_a: Vec3 = vector.new()
local pos_b: Vec3 = vector.new()
local function distance_2d(vec_1: Vec3, vec_2: Vec3): number
  pos_a.x = vec_1.x
  pos_a.y = 0
  pos_a.z = vec_1.z
  pos_b.x = vec_2.x
  pos_b.y = 0
  pos_b.z = vec_2.z
  return vector.distance(pos_a, pos_b)
end

function entity:poll_players(pos: Vec3)
  if (self.collected) then return end
  if (not self.age) then return end
  if (self.age < 0.55) then return end

  --[[
    ! fixme: needs a cooldown before running this check again if it completely fails.
    ! fixme: check if the inventory has room for item.
  ]]
  
  local solved = false
  for _,player in ipairs(minetest.get_connected_players()) do
    if (solved) then goto continue end
    local player_pos  = player:get_pos()
    if (vector.distance(pos, player_pos) > 3) then goto continue end
    if (distance_2d(pos, player_pos) > 1.5) then goto continue end
    if (player_pos.y - pos.y > 0.05) then goto continue end
    player_pos.y = player_pos.y + 0.8

    -- Move to doesn't work consistently, so we have to combine the packets together into one motion.
    self:disable_physics()
    self.object:set_velocity(vector.multiply(vector.direction(pos, player_pos), 10))
    self.object:move_to(player_pos, true)
    solved = true
    self.age = 0
    self.collected = true

    -- Play the pickup sound at a random pitch.
    minetest.sound_play({
      name = "item_pickup"
    },{
      gain = 0.15,
      pitch = random_range(0.7, 1.0),
      object = player
    })
    ::continue::
  end
end

function entity:collection_cleanup(delta: number)
  self.age = self.age + delta
  if (self.age < 0.2) then return end
  self.object:remove()
end

function entity:on_step(dtime: number, moveresult: MoveResult)
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
    z = pos.z
  })

  if (self:check_out_of_bounds(node)) then return end

  -- Prevent assert when item_entity is attached
  if moveresult == nil and self.object:get_attach() then
    return
  end

  if self:force_out_check(pos) then return end
  
  -- Don't do anything
  if not self.physical_state then
    return 
  end

  if not moveresult.collides then
    -- future TODO: items should probably decelerate in air
    return
  end

  -- Push item out when stuck inside solid node
  local is_stuck = false
  local snode = minetest.get_node_or_nil(pos)
  if snode then
    local sdef = minetest.registered_nodes[(snode as NodeTable).name] or {}
    is_stuck = (sdef.walkable == nil or sdef.walkable == true)
      and (sdef.collision_box == nil or sdef.collision_box.type == "regular")
      and (sdef.node_box == nil or sdef.node_box.type == "regular")
    
    self:unstuck_self()
  end

  node = nil -- ground node we're colliding with
  if moveresult.touching_ground then
    for _, info in ipairs(moveresult.collisions) do
      if info.axis == "y" then
        node = minetest.get_node(info.node_pos)
        break
      end
    end
  end

  -- Slide on slippery nodes
  local def = node and minetest.registered_nodes[(node as NodeTable).name]
  local keep_movement = self:slip_check(dtime, def, node)

  
  if not keep_movement then
    self.object:set_velocity({x=0, y=0, z=0})
  end

  if self.moving_state == keep_movement then
    -- Do not update anything until the moving state changes
    return
  end
  self.moving_state = keep_movement
end

minetest.register_entity(":__builtin:item", entity)