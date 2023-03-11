local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local kr_icons_size = false

if settings.startup["kr-large-icons"].value then
  kr_icons_size = true
end

if settings.startup["kr-containers"].value then
  data:extend({
    {
      type = "container",
      name = "kr-medium-container",
      icon = "__Krastorio2Assets__/icons/entities/containers/medium-containers/medium-container.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-player", "player-creation", "not-rotatable" },
      minable = { mining_time = 0.5, result = "kr-medium-container" },
      max_health = 500,
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
      vehicle_impact_sound = sounds.generic_impact,
      opened_duration = logistic_chest_opened_duration,
      picture = {
        filename = "__Krastorio2Assets__/entities/containers/medium-containers/medium-container/medium-container.png",
        priority = "extra-high",
        width = 85,
        height = 85,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/containers/medium-containers/medium-container/hr-medium-container.png",
          priority = "extra-high",
          width = 340,
          height = 340,
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
