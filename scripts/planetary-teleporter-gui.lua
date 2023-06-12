local flib_gui = require("__flib__/gui-lite")
local flib_math = require("__flib__/math")

--- @class PlanetaryTeleporterGui
--- @field elems table<string, LuaGuiElement>
--- @field entity LuaEntity
--- @field player LuaPlayer
--- @field search_open boolean
--- @field search_query string

--- @param player LuaPlayer
--- @param from LuaEntity
--- @param to LuaEntity
local function teleport_player(player, from, to)
  from.energy = 0
  to.energy = 0
  local position = to.position
  position.y = position.y + 1.1
  player.teleport(position, to.surface)
  from.surface.play_sound({
    path = "kr-planetary-teleporter-effect-sound",
    volume_modifier = 0.8,
    position = from.position,
  })
  to.surface.play_sound({
    path = "kr-planetary-teleporter-effect-sound",
    position = to.position,
    volume_modifier = 1,
  })
end

--- @param self PlanetaryTeleporterGui
local function filter_destinations(self)
  local search_query = self.search_query
  for _, frame in pairs(self.elems.destinations_table.children) do
    if search_query == "" then
      frame.visible = true
      goto continue
    end
    local unit_number = tonumber(frame.name) --[[@as uint]]
    local data = global.planetary_teleporter[unit_number]
    if not data then
      frame.destroy()
      goto continue
    end
    if data.name and string.find(string.lower(data.name), search_query, nil, true) then
      frame.visible = true
    else
      frame.visible = false
    end
    ::continue::
  end
end

--- @param self PlanetaryTeleporterGui
--- @param by_click boolean
local function toggle_search(self, by_click)
  local search_button = self.elems.search_button
  if not by_click then
    search_button.toggled = not search_button.toggled
  end
  self.search_open = search_button.toggled
  search_button.sprite = self.search_open and "utility/search_black" or "utility/search_white"

  local search_textfield = self.elems.search_textfield
  search_textfield.visible = self.search_open
  if self.search_open then
    search_textfield.focus()
    search_textfield.select_all()
  else
    self.search_query = ""
  end

  filter_destinations(self)
end

--- @param e EventData.on_gui_closed|EventData.on_gui_click
local function on_window_closed(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if not self then
    return
  end
  if self.search_open then
    toggle_search(self, false)
    self.player.opened = self.elems.kr_planetary_teleporter_window
    return
  end
  local window = self.elems.kr_planetary_teleporter_window
  if window.valid then
    window.destroy()
    if self.player.opened == window then
      self.player.opened = nil
    end
  end
  global.planetary_teleporter_gui[e.player_index] = nil
end

--- @param e EventData.on_gui_text_changed
local function on_search_textfield_text_changed(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if not self then
    return
  end
  self.search_query = e.element.text
  filter_destinations(self)
end

--- @param e EventData.on_gui_click|EventData.CustomInputEvent
local function on_search_button_clicked(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if not self then
    return
  end
  toggle_search(self, true)
end

--- @param e EventData.on_gui_click
local function on_rename_button_clicked(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if not self or not self.elems.kr_planetary_teleporter_window.valid then
    return
  end
  local data = global.planetary_teleporter[self.entity.unit_number]
  local textfield = self.elems.name_textfield
  local label = self.elems.name_label
  if textfield.visible then
    label.visible = true
    textfield.visible = false
  else
    label.visible = false
    textfield.text = data.name or ""
    textfield.visible = true
    textfield.select_all()
    textfield.focus()
  end
end

--- @param e EventData.on_gui_confirmed
local function on_name_textfield_confirmed(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if not self or not self.elems.kr_planetary_teleporter_window.valid then
    return
  end
  local data = global.planetary_teleporter[
    self.entity.unit_number --[[@as uint]]
  ]
  local text = e.element.text
  if #text > 0 then
    data.name = e.element.text
  else
    data.name = nil
  end
  on_rename_button_clicked(e --[[@as EventData.on_gui_click]])
end

--- @type table<defines.entity_status, { sprite: SpritePath, label: LocalisedString }>
local status_sprites = {
  [defines.entity_status.charging] = { label = { "entity-status.charging" }, sprite = "utility/status_yellow" },
  [defines.entity_status.fully_charged] = {
    label = { "entity-status.fully-charged" },
    sprite = "utility/status_working",
  },
  [defines.entity_status.no_power] = { label = { "entity-status.no-power" }, sprite = "utility/status_not_working" },
  [defines.entity_status.normal] = { label = { "entity-status.normal" }, sprite = "utility/status_working" },
}

--- @param self PlanetaryTeleporterGui
local function update_gui(self)
  local buffer_capacity = self.entity.prototype.electric_energy_source_prototype.buffer_capacity
  local status = self.entity.status
  local status_properties = status_sprites[status] or {}
  self.elems.status_icon.sprite = status_properties.sprite
  self.elems.status_label.caption = status_properties.label

  local charge = self.entity.energy / buffer_capacity
  self.elems.charge_progressbar.value = charge
  self.elems.charge_progressbar.caption = { "format-percent", flib_math.round(charge * 100) }

  local data = global.planetary_teleporter[self.entity.unit_number]
  self.elems.name_label.caption = data.name or { "gui.kr-planetary-teleporter-unnamed" }

  for _, frame in pairs(self.elems.destinations_table.children) do
    local unit_number = tonumber(frame.name) --[[@as uint]]
    local data = global.planetary_teleporter[unit_number]
    if not data then
      goto continue
    end
    local entity = data.entities.base
    local charge = entity.energy / buffer_capacity
    local fully_charged = flib_math.round(charge, 0.1) == 1
    local minimap = frame.minimap_frame.minimap --[[@as LuaGuiElement]]
    minimap.progressbar.value = charge
    minimap.progressbar.visible = not fully_charged
    minimap.minimap_button.enabled = fully_charged
    minimap.minimap_button.tooltip = fully_charged and { "gui.kr-planetary-teleporter-teleport" }
      or { "format-percent", flib_math.round(charge * 100) }
    ::continue::
  end
end

local function on_tick()
  for _, gui in pairs(global.planetary_teleporter_gui) do
    update_gui(gui)
  end
end

--- @param e EventData.on_gui_opened
local function on_gui_opened(e)
  local entity = e.entity
  if not entity or not entity.valid or entity.name ~= "kr-planetary-teleporter" then
    return
  end

  local player = game.get_player(e.player_index)
  if not player then
    return
  end

  local destination_buttons = {}
  for unit_number, data in pairs(global.planetary_teleporter) do
    if unit_number == entity.unit_number or data.force ~= entity.force or data.surface ~= entity.surface then
      goto continue
    end
    destination_buttons[#destination_buttons + 1] = {
      type = "frame",
      name = unit_number,
      style = "train_with_minimap_frame",
      direction = "vertical",
      {
        type = "frame",
        name = "minimap_frame",
        style = "deep_frame_in_shallow_frame",
        {
          type = "minimap",
          name = "minimap",
          style = "kr_planetary_teleporter_destination_minimap",
          position = data.entities.base.position,
          { type = "button", name = "minimap_button", style = "kr_planetary_teleporter_destination_minimap_button" },
          {
            type = "progressbar",
            name = "progressbar",
            style = "kr_planetary_teleporter_destination_charge_bar",
            ignored_by_interaction = true,
          },
          {
            type = "label",
            style = "kr_planetary_teleporter_destination_label",
            style_mods = { top_margin = 8, right_margin = 8 },
            caption = data.name or { "gui.kr-planetary-teleporter-unnamed" },
            ignored_by_interaction = true,
          },
        },
      },
    }
    ::continue::
  end

  local elems = flib_gui.add(player.gui.screen, {
    type = "frame",
    name = "kr_planetary_teleporter_window",
    direction = "vertical",
    elem_mods = { auto_center = true },
    handler = { [defines.events.on_gui_closed] = on_window_closed },
    {
      type = "flow",
      style = "flib_titlebar_flow",
      drag_target = "kr_planetary_teleporter_window",
      {
        type = "label",
        style = "frame_title",
        caption = { "entity-name.kr-planetary-teleporter" },
        ignored_by_interaction = true,
      },
      { type = "empty-widget", style = "flib_titlebar_drag_handle", ignored_by_interaction = true },
      {
        type = "textfield",
        name = "search_textfield",
        style = "flib_titlebar_search_textfield",
        visible = false,
        handler = { [defines.events.on_gui_text_changed] = on_search_textfield_text_changed },
      },
      {
        type = "sprite-button",
        name = "search_button",
        style = "frame_action_button",
        sprite = "utility/search_white",
        hovered_sprite = "utility/search_black",
        clicked_sprite = "utility/search_black",
        tooltip = { "gui.flib-search-instruction" },
        auto_toggle = true,
        handler = { [defines.events.on_gui_click] = on_search_button_clicked },
      },
      {
        type = "sprite-button",
        style = "frame_action_button",
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black",
        tooltip = { "gui.close-instruction" },
        handler = { [defines.events.on_gui_click] = on_window_closed },
      },
    },
    {
      type = "flow",
      style_mods = { horizontal_spacing = 12 },
      {
        type = "frame",
        style = "inside_shallow_frame",
        direction = "vertical",
        {
          type = "frame",
          style = "subheader_frame",
          style_mods = { width = 424 },
          {
            type = "label",
            name = "name_label",
            style = "subheader_caption_label",
            style_mods = { horizontally_squashable = true },
          },
          {
            type = "textfield",
            name = "name_textfield",
            visible = false,
            handler = { [defines.events.on_gui_confirmed] = on_name_textfield_confirmed },
          },
          {
            type = "sprite-button",
            style = "mini_button_aligned_to_text_vertically_when_centered",
            sprite = "utility/rename_icon_small_black",
            handler = { [defines.events.on_gui_click] = on_rename_button_clicked },
          },
        },
        {
          type = "flow",
          style_mods = { padding = 12, vertical_spacing = 8 },
          direction = "vertical",
          {
            type = "flow",
            style = "status_flow",
            style_mods = { vertical_align = "center" },
            { type = "sprite", name = "status_icon", style = "flib_indicator" },
            { type = "label", name = "status_label" },
          },
          {
            type = "frame",
            style = "deep_frame_in_shallow_frame",
            { type = "entity-preview", style = "wide_entity_button", elem_mods = { entity = entity } },
          },
          {
            type = "progressbar",
            name = "charge_progressbar",
            style = "production_progressbar",
            style_mods = { horizontally_stretchable = true },
            caption = "foo",
            value = 0.2,
          },
          { type = "empty-widget", style = "vertical_lines_slots_filler" },
        },
      },
      {
        type = "frame",
        style = "inside_deep_frame",
        direction = "vertical",
        {
          type = "frame",
          style = "subheader_frame",
          {
            type = "label",
            style = "subheader_caption_label",
            caption = { "gui.kr-planetary-teleporter-destinations" },
          },
          { type = "empty-widget", style = "flib_horizontal_pusher" },
        },
        {
          type = "scroll-pane",
          style = "kr_planetary_teleporter_destinations_scroll_pane",
          vertical_scroll_policy = "auto-and-reserve-space",
          {
            type = "table",
            name = "destinations_table",
            style = "slot_table",
            column_count = 3,
            children = destination_buttons,
          },
        },
      },
    },
  })

  player.opened = elems.kr_planetary_teleporter_window

  --- @type PlanetaryTeleporterGui
  global.planetary_teleporter_gui[e.player_index] = {
    elems = elems,
    entity = entity,
    player = player,
    search_open = false,
    search_query = "",
  }
end

--- @param e EventData.CustomInputEvent
local function on_focus_search(e)
  local self = global.planetary_teleporter_gui[e.player_index]
  if self then
    toggle_search(self, false)
  end
end

local function on_init()
  --- @type table<uint, PlanetaryTeleporterGui>
  global.planetary_teleporter_gui = {}
end

local planetary_teleporter_gui = {}

planetary_teleporter_gui.on_init = on_init

planetary_teleporter_gui.events = {
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_tick] = on_tick,
  ["kr-linked-focus-search"] = on_focus_search,
}

flib_gui.add_handlers({
  planetary_teleporter_on_name_textfield_confirmed = on_name_textfield_confirmed,
  planetary_teleporter_on_rename_button_clicked = on_rename_button_clicked,
  planetary_teleporter_on_search_button_clicked = on_search_button_clicked,
  planetary_teleporter_on_search_textfield_text_changed = on_search_textfield_text_changed,
  planetary_teleporter_on_window_closed = on_window_closed,
})

return planetary_teleporter_gui
