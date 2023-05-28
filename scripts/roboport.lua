local flib_gui = require("__flib__/gui-lite")

local constants = require("__Krastorio2__/scripts/constants")
local util = require("__Krastorio2__/scripts/util")

-- GUI

--- @param player LuaPlayer
--- @param entity LuaEntity
local function update_gui(player, entity)
  local player_gui = global.roboport_guis[player.index]
  if not player_gui or not player_gui.valid then
    return
  end
  local mode = string.match(entity.name, "^.*%-(%w*)%-mode") or "normal"

  for _, button in pairs(player_gui.inner_frame.children) do
    if button.name == mode then
      button.state = true
    else
      button.state = false
    end
  end
end

--- @param entity LuaEntity
--- @param player LuaPlayer
--- @param to_mode string?
local function change_mode(entity, player, to_mode)
  local matched, _, base_name, suffix = string.find(entity.name, "^(.-)(%-%w-%-mode)$")
  if not matched then
    base_name = entity.name
    suffix = ""
  end

  local new_mode_data
  if to_mode then
    new_mode_data = constants.roboport_modes[to_mode]
  else
    new_mode_data = constants.roboport_modes[constants.next_roboport_mode[suffix]]
  end

  local new_name = base_name .. new_mode_data.suffix

  if not game.entity_prototypes[new_name] then
    util.flying_text_with_sound(player, { "message.kr-roboport-modes-not-supported" }, { position = entity.position })
    return
  end

  local energy = entity.energy
  local health = entity.health

  -- Find all players that have this roboport open
  -- This must be done before the roboport is swapped
  local guis_to_update = {}
  for player_index in pairs(global.roboport_guis) do
    local player = game.get_player(player_index) --[[@as LuaPlayer]]
    if player.opened_gui_type == defines.gui_type.entity then
      local opened = player.opened
      if opened and opened == entity then
        table.insert(guis_to_update, player)
      end
    end
  end

  local new_entity = entity.surface.create_entity({
    name = new_name,
    position = entity.position,
    force = entity.force,
    direction = entity.direction,
    fast_replace = true,
    raise_built = true,
    spill = false,
    create_build_effect_smoke = false,
  })

  if new_entity then
    new_entity.energy = energy
    new_entity.health = health
    new_entity.last_user = player

    util.change_mode_fx(new_entity, { "message.kr-" .. new_mode_data.text .. "-mode" }, new_mode_data.color)

    -- Re-open GUI for all players who had it open and update the radio buttons
    for _, player in pairs(guis_to_update) do
      player.opened = new_entity
      update_gui(player, new_entity)
    end
  end
end

--- @param e EventData.on_gui_checked_state_changed
local function on_mode_radio_button_checked(e)
  local player = game.get_player(e.player_index)
  if not player or player.opened_gui_type ~= defines.gui_type.entity then
    return
  end
  local entity = player.opened --[[@as LuaEntity]]
  if not entity.valid or entity.type ~= "roboport" then
    return
  end
  change_mode(entity, player, e.element.name)
end

--- @param mode string
local function radio_button(mode)
  return {
    type = "radiobutton",
    name = mode,
    caption = { "message.kr-" .. mode .. "-mode" },
    state = false,
    handler = { [defines.events.on_gui_checked_state_changed] = on_mode_radio_button_checked },
  }
end

--- @param player_index uint
local function destroy_gui(player_index)
  local player_gui = global.roboport_guis[player_index]
  if not player_gui then
    return
  end
  if player_gui.valid then
    player_gui.destroy()
  end
  global.roboport_guis[player_index] = nil
end

--- @param player LuaPlayer
local function refresh_gui(player)
  destroy_gui(player.index)

  _, global.roboport_guis[player.index] = flib_gui.add(player.gui.relative, {
    type = "frame",
    name = "kr_roboport_mode_window",
    caption = { "gui.kr-change-mode" },
    anchor = {
      gui = defines.relative_gui_type.roboport_gui,
      position = defines.relative_gui_position.right,
      names = global.roboport_has_variants_gui,
    },
    {
      type = "frame",
      name = "inner_frame",
      style = "inside_shallow_frame_with_padding",
      direction = "vertical",
      radio_button("normal"),
      radio_button("construction"),
      radio_button("logistic"),
    },
  })
end

local function find_variants()
  -- Find all compatible roboports
  local has_variants_gui = {}
  for _, entity in pairs(game.get_filtered_entity_prototypes({ { filter = "type", type = "roboport" } })) do
    local matched, _, base_name = string.find(entity.name, "^(.-)%-%w*%-mode")
    if matched then
      has_variants_gui[base_name] = true
      has_variants_gui[entity.name] = true
    end
  end

  -- Convert to a format usable by GuiAnchor
  local output = {}
  local i = 0
  for entity in pairs(has_variants_gui) do
    i = i + 1
    output[i] = entity
  end

  global.roboport_has_variants_gui = output
end

--- @param e EventData.on_gui_opened
local function on_gui_opened(e)
  local entity = e.entity
  if not entity or not entity.valid then
    return
  end
  local player = game.get_player(e.player_index)
  if not player then
    return
  end
  if entity.type == "roboport" then
    update_gui(player, entity)
  end
end

--- @param e EventData.on_player_created
local function on_player_created(e)
  local player = game.get_player(e.player_index)
  if player then
    refresh_gui(player)
  end
end

--- @param e EventData.on_player_removed
local function on_player_removed(e)
  destroy_gui(e.player_index)
end

--- @param e EventData.CustomInputEvent
local function on_change_roboport_mode_hotkey(e)
  local player = game.get_player(e.player_index)
  if not player then
    return
  end
  local selected = player.selected
  if selected and selected.valid and selected.type == "roboport" then
    change_mode(selected, player)
  end
end

local function on_configuration_changed()
  find_variants()
  for _, player in pairs(game.players) do
    refresh_gui(player)
  end
end

local function on_init()
  --- @type table<uint, LuaGuiElement>
  global.roboport_guis = {}
  on_configuration_changed()
end

local roboport = {}

roboport.on_init = on_init
roboport.on_configuration_changed = on_configuration_changed

roboport.events = {
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_player_created] = on_player_created,
  [defines.events.on_player_removed] = on_player_removed,
  ["kr-change-roboport-state"] = on_change_roboport_mode_hotkey,
}

flib_gui.add_handlers({ roboport_on_mode_radio_button_checked = on_mode_radio_button_checked })

return roboport
