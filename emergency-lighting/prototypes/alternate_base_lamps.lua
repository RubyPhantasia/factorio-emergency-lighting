local helper = require("helper")

-- Alternately:
local emergency_lamp = helper.copy_prototype("accumulator", "accumulator")
log(serpent.block(emergency_lamp))
-- Need to define discharge_light.
emergency_lamp.discharge_light.color = {r=1.0, g=0.1, b=0.1}
emergency_lamp.discharge_light.intensity = 0.3
emergency_lamp.discharge_light.size = 6
emergency_lamp.discharge_light.minimum_darkness = 0.2
emergency_lamp.charge_light = nil
emergency_lamp.charge_animation = nil

emergency_lamp.energy_source.buffer_capacity = "60Kj"
emergency_lamp.energy_source.output_flow_limit = "0W"
emergency_lamp.energy_source.drain = "50W"
emergency_lamp.energy_source.render_no_power_icon = false
emergency_lamp.energy_source.render_no_network_icon = true