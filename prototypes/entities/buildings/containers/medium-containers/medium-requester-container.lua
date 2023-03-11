local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local kr_icons_size = false

if krastorio.general.getSafeSettingValue("kr-large-icons") then
  kr_icons_size = true
end

if krastorio.general.getSafeSettingValue("kr-containers") then
  data:extend({
    {
      type = "logistic-container",
      name = "kr-medium-requester-container",
      icon = "__Krastorio2Assets__/icons/entities/containers/medium-containers/medium-requester-container.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-player", "player-creation", "not-rotatable" },
      minable = { mining_time = 0.5, result = "kr-medium-requester-container" },
      max_health = 500,
      -- max_logistic_slots = 18,
      corpse = "big-remnants",
      collision_box = { { -0.8, -0.8 }, { 0.8, 0.8 } },
      selection_box = { { -1, -1 }, { 1, 1 } },
      damaged_trigger_effect = hit_effects.entity(),
      resistances = {
        { type = "physical", percent = 30 },
        { type = "fire", percent = 50 },
        { type = "impact", percent = 50 },
      },
      fast_replaceable_group = "container",
      inventory_size = 120,
      scale_info_icons = kr_icons_size,
      logistic_mode = "requester",
      vehicle_impact_sound = sounds.generic_impact,
      opened_duration = logistic_chest_opened_duration,
      animation = {
        filename = "__Krastorio2Assets__/entities/containers/medium-containers/medium-requester-container/medium-requester-container.png",
        priority = "extra-high",
        width = 85,
        height = 85,
        frame_count = 6,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/containers/medium-containers/medium-requester-container/hr-medium-requester-container.png",
          priority = "extra-high",
          width = 340,
          height = 340,
          frame_count = 6,
          line_length = 3,
          scale = 0.25,
        },
      },
      circuit_wire_connection_point = circuit_connector_definitions["chest"].points,
      circuit_connector_sprites = circuit_connector_definitions["chest"].sprites,
      circuit_wire_max_distance = default_circuit_wire_max_distance,
      open_sound = sounds.machine_open,
      close_sound = sounds.machine_close,
    },
  })
end
