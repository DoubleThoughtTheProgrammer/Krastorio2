local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local kr_icons_size = false

if settings.startup["kr-large-icons"].value then
  kr_icons_size = true
end

if settings.startup["kr-containers"].value then
  data:extend({
    {
      type = "logistic-container",
      name = "kr-big-active-provider-container",
      icon = "__Krastorio2Assets__/icons/entities/containers/big-containers/big-active-provider-container.png",
      icon_size = 64,
      icon_mipmaps = 4,
      flags = { "placeable-player", "player-creation", "not-rotatable" },
      minable = { mining_time = 1, result = "kr-big-active-provider-container" },
      max_health = 1500,
      corpse = "kr-big-random-pipes-remnant",
      collision_box = { { -2.75, -2.75 }, { 2.75, 2.75 } },
      selection_box = { { -3, -3 }, { 3, 3 } },
      damaged_trigger_effect = hit_effects.entity(),
      resistances = {
        { type = "physical", percent = 50 },
        { type = "fire", percent = 75 },
        { type = "impact", percent = 75 },
      },
      fast_replaceable_group = "container",
      inventory_size = 500,
      scale_info_icons = kr_icons_size,
      logistic_mode = "active-provider",
      vehicle_impact_sound = sounds.generic_impact,
      opened_duration = logistic_chest_opened_duration,
      animation = {
        filename = "__Krastorio2Assets__/entities/containers/big-containers/big-active-provider-container/big-active-provider-container.png",
        priority = "extra-high",
        width = 213,
        height = 213,
        frame_count = 6,
        line_length = 2,
        scale = 1.2,
        hr_version = {
          filename = "__Krastorio2Assets__/entities/containers/big-containers/big-active-provider-container/hr-big-active-provider-container.png",
          priority = "extra-high",
          width = 512,
          height = 512,
          frame_count = 6,
          line_length = 3,
          scale = 0.5,
        },
      },
      water_reflection = {
        pictures = {
          filename = "__Krastorio2Assets__/entities/containers/big-containers/big-container-reflection.png",
          priority = "extra-high",
          width = 60,
          height = 50,
          shift = util.by_pixel(0, 40),
          variation_count = 1,
          scale = 5,
        },
        rotate = false,
        orientation_to_variation = false,
      },
      circuit_wire_connection_point = circuit_connector_definitions["kr-big-container"].points,
      circuit_connector_sprites = circuit_connector_definitions["kr-big-container"].sprites,
      circuit_wire_max_distance = 20,
      open_sound = sounds.machine_open,
      close_sound = sounds.machine_close,
    },
  })
end
