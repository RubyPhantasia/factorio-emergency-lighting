local helper = require("helper")
local constants = require("constants")

local function copy_lamp_item(new_lamp_name)
    local new_lamp_item = helper.copy_prototype("item", "small-lamp")
    new_lamp_item.name = new_lamp_name
    new_lamp_item.place_result = new_lamp_name
    return new_lamp_item
end

local function set_bounding_boxes(prototype)
    prototype.collision_box = {{-0.4, -0.4}, {0.4, 0.4}}
    prototype.collision_mask = {"object-layer", "water-tile"}
    prototype.selection_box = {{-0.5, -0.5}, {0.5, 0.5}}
    return prototype
end

-- Prototypes
-- Electric Emergency Lamp
-- Entity
local emergency_lamp_electric = table.deepcopy(data.raw["lamp"]["small-lamp"])
emergency_lamp_electric.name = constants.electric_emergency_lamp_name
emergency_lamp_electric.light.color = {r=1.0, g=0.1, b=0.1}
emergency_lamp_electric.light.intensity = 0.3
emergency_lamp_electric.light.size = 6
-- emergency_lamp_electric.always_on = true
emergency_lamp_electric.energy_source.buffer_capacity = "60kJ"
emergency_lamp_electric.energy_source.render_no_power_icon = false
emergency_lamp_electric.energy_source.render_no_network_icon = true
-- emergency_lamp_electric.energy_source.usage_priority = "tertiary"
emergency_lamp_electric.energy_source.drain = "50W"
emergency_lamp_electric.circuit_wire_connection_point = nil
emergency_lamp_electric.darkness_for_all_lamps_off = 0.2
emergency_lamp_electric.darkness_for_all_lamps_on = 0.3
emergency_lamp_electric.fast_replaceable_group = constants.emergency_lamp_fast_replaceable_group
emergency_lamp_electric.next_upgrade = constants.rtg_emergency_lamp_name
set_bounding_boxes(emergency_lamp_electric)

-- Item
local emergency_lamp_electric_item = helper.copy_prototype("item", "small-lamp")
emergency_lamp_electric_item.name = constants.electric_emergency_lamp_name
emergency_lamp_electric_item.place_result = constants.electric_emergency_lamp_name

-- Recipe
local emergency_lamp_electric_recipe = helper.copy_prototype("recipe", "small-lamp")
emergency_lamp_electric_recipe.name = constants.electric_emergency_lamp_name
emergency_lamp_electric_recipe.result = constants.electric_emergency_lamp_name
emergency_lamp_electric_recipe.result_count = 10
emergency_lamp_electric_recipe.energy_required = 4.0
emergency_lamp_electric.minable.result=constants.electric_emergency_lamp_name
-- emergency_lamp_electric_recipe.show_amount_in_title = 10 -- FIXME Is this necessary?

-- Technology (Research)
local optics_research = data.raw["technology"]["optics"]
local electric_emergency_lamp_recipe_unlock = table.deepcopy(optics_research.effects[1])
electric_emergency_lamp_recipe_unlock.recipe = constants.electric_emergency_lamp_name
table.insert(optics_research.effects, electric_emergency_lamp_recipe_unlock)

-- TODO: Add fast_replace group and other parameters

-- RTG-based Emergency Lamp
-- Entity
local emergency_lamp_rtg = table.deepcopy(data.raw["lamp"]["small-lamp"])
emergency_lamp_rtg.name = constants.rtg_emergency_lamp_name
emergency_lamp_rtg.light.color = {r=1.0, g=0.15, b=0.15}
emergency_lamp_rtg.light.intensity = 0.35
emergency_lamp_rtg.light.size = 7

emergency_lamp_rtg.energy_source = {
    type="void",
    render_no_power_icon=false,
    render_no_network_icon=false
}

emergency_lamp_rtg.circuit_wire_connection_point = nil
emergency_lamp_rtg.darkness_for_all_lamps_off = 0.2
emergency_lamp_rtg.darkness_for_all_lamps_on = 0.3
emergency_lamp_rtg.fast_replaceable_group = constants.emergency_lamp_fast_replaceable_group
emergency_lamp_rtg.minable.result = constants.rtg_emergency_lamp_name
set_bounding_boxes(emergency_lamp_rtg)

-- Item
local emergency_lamp_rtg_item = copy_lamp_item(constants.rtg_emergency_lamp_name)

-- Recipe
local emergency_lamp_rtg_recipe = helper.copy_prototype("recipe", "engine-unit")
emergency_lamp_rtg_recipe.name = constants.rtg_emergency_lamp_name
emergency_lamp_rtg_recipe.ingredients = {
    {type="item", name="uranium-235", amount=1},
    {type="item", name="steel-plate", amount=10},
    {type="item", name="electronic-circuit", amount=20}
}
emergency_lamp_rtg_recipe.result = constants.rtg_emergency_lamp_name
emergency_lamp_rtg_recipe.result_count = 50
emergency_lamp_rtg_recipe.energy_required = 20.0

-- Technology (Research)
local emergency_lamp_rtg_technology = helper.copy_prototype("technology", "nuclear-fuel-reprocessing")
emergency_lamp_rtg_technology.effects = {
    {type="unlock-recipe", recipe=constants.rtg_emergency_lamp_name}
}
emergency_lamp_rtg_technology.name = constants.rtg_emergency_lamp_name
emergency_lamp_rtg_technology.icons = optics_research.icons
emergency_lamp_rtg_technology.icon = optics_research.icon
emergency_lamp_rtg_technology.name = constants.rtg_emergency_lamp_name

-- TODO: Add various parameters

-- Burner Emergency Lamp
-- Entity
local emergency_lamp_burner = {
    name = constants.burner_emergency_lamp_name,
    type = "burner-generator",
    energy_source = {
        type = "electric",
        buffer_capacity = "1kJ",
        usage_priority = "tertiary",
        output_flow_limit = "0kW",
        drain = "500W",
    },
    burner = {
        type = "burner",
        fuel_inventory_size = 1,
        light_flicker = {
            minimum_intensity = 0.1,
            maximum_intensity = 0.25,
            minimum_light_size = 1,
            light_intensity_to_size_coefficient = 5/0.25,
            color = {r=1.0, g=0.35, b=0.1}
        },
        effectivity = 1.0,
        -- fuel_category = constants.burner_emergency_lamp_fuel_category,
        fuel_category = "chemical",
        emissions_per_minute = 1.0, -- FIXME Figure out a good value
        render_no_power_icon = false,
        render_no_network_icon = false
    },
    max_power_output = "1W",
    max_health = 20,
    repair_speed_modifier = 0.0,
    collision_box = {{-0.4, -0.4}, {0.4, 0.4}},
    collision_mask = {"object-layer", "water-tile"},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    minable = {
        mining_time = 0.5,
        result = constants.burner_emergency_lamp_name,
    },
    build_sound = data.raw["lamp"]["small-lamp"].build_sound,
    mined_sound = data.raw["lamp"]["small-lamp"].mined_sound,
    mining_sound = data.raw["lamp"]["small-lamp"].mining_sound,
    rotated_sound = data.raw["lamp"]["small-lamp"].rotated_sound,
    vehicle_impact_sound = data.raw["lamp"]["small-lamp"].vehicle_impact_sound,
    open_sound = data.raw["lamp"]["small-lamp"].open_sound,
    close_sound = data.raw["lamp"]["small-lamp"].close_sound,
    fast_replaceable_group = constants.emergency_lamp_fast_replaceable_group,
    next_upgrade = constants.electric_emergency_lamp_name,
    placeable_by = {
        item = constants.burner_emergency_lamp_name,
        count = 1
    },
    -- Don't think I need to define map_color or related properties.
}

-- Item
local emergency_lamp_burner_item = copy_lamp_item(constants.burner_emergency_lamp_name)

-- Recipe
local emergency_lamp_burner_recipe = helper.copy_prototype("recipe", "small-lamp")
emergency_lamp_burner_recipe.name = constants.burner_emergency_lamp_name
emergency_lamp_burner_recipe.ingredients = {
    {type="item", name="coal", amount=2},
    {type="item", name="iron-plate", amount=5}
}
emergency_lamp_burner_recipe.result = constants.burner_emergency_lamp_name
emergency_lamp_burner_recipe.result_count = 10
emergency_lamp_burner_recipe.energy_required = 2.0
emergency_lamp_burner_recipe.enabled = true

-- TODO: Add fuel (coal shards?), fuel recipe

-- Burner Emergency Lamp Fuel Category

-- Add everything to the game.
data:extend{emergency_lamp_burner, emergency_lamp_electric, emergency_lamp_rtg}
-- data:extend{emergency_lamp_burner_item, emergency_lamp_electric_item, emergency_lamp_rtg_item}
data:extend{emergency_lamp_burner_item, emergency_lamp_electric_item, emergency_lamp_rtg_item}
data:extend{emergency_lamp_burner_recipe, emergency_lamp_electric_recipe, emergency_lamp_rtg_recipe}
data:extend{emergency_lamp_rtg_technology}

--[[
    * To get a flickering electric light, could create a burner/fluid generator entity in the same location as the light,
    with an appropriate flickering light.
    * Would like for these lamps to degrade as they are active, and eventually burn out.
    * Want these lamps to only turn on if the lights go out - at least for the electric and rtg versions.
]]