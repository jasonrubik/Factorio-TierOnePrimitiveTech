function RemoveRecipeEffectFromTechnology(technology, recipe)
	for i, effect in ipairs(technology.effects) do
		if effect.recipe == recipe then
			table.remove(technology.effects, i)
			break
		end
	end
end

function RemovePrerequisitesFromTechnology(technology, prerequisiteToRemove)
	for i, prerequisite in ipairs(technology.prerequisites) do
		if prerequisite == prerequisiteToRemove then
			table.remove(technology.prerequisites, i)
			break
		end
	end
end

function AddPrerequisitesToTechnology(technology, prerequisiteToAdd)
	table.insert(technology.prerequisites, prerequisiteToAdd)
end

function RemoveIngredientFromRecipe(recipe, ingredientToRemove)
	for i, ingredient in ipairs(recipe.ingredients) do
		if ingredient == ingredientToRemove then
			table.remove(recipe.ingredients, i)
			break
		end
	end
end



-- Disable/hide these technologies ALWAYS

data.raw.technology["advanced-material-processing"].hidden = true
data.raw.technology["automation-3"].hidden = true
data.raw.technology["effect-transmission"].hidden = true
data.raw.technology["electric-energy-distribution-1"].hidden = true
data.raw.technology["electric-energy-distribution-2"].hidden = true
data.raw.technology["fast-inserter"].hidden = true
data.raw.technology["logistic-robotics"].hidden = true
data.raw.technology["logistic-system"].hidden = true
data.raw.technology["logistics-2"].hidden = true
data.raw.technology["logistics-3"].hidden = true
data.raw.technology["nuclear-fuel-reprocessing"].hidden = true
data.raw.technology["nuclear-power"].hidden = true
data.raw.technology["stack-inserter"].hidden = true
data.raw.technology["uranium-processing"].hidden = true
data.raw.technology["uranium-ammo"].hidden = true
data.raw.technology["kovarex-enrichment-process"].hidden = true



-- Non-Disabled techs which depend on a disabled tech

RemovePrerequisitesFromTechnology(data.raw.technology["automobilism"], "logistics-2")
RemovePrerequisitesFromTechnology(data.raw.technology["railway"], "logistics-2")
RemovePrerequisitesFromTechnology(data.raw.technology["concrete"], "advanced-material-processing")
RemovePrerequisitesFromTechnology(data.raw.technology["electric-energy-accumulators"], "electric-energy-distribution-1")
RemovePrerequisitesFromTechnology(data.raw.technology["low-density-structure"], "advanced-material-processing")

RemovePrerequisitesFromTechnology(data.raw.technology["inserter-capacity-bonus-1"], "logistics-2")
RemovePrerequisitesFromTechnology(data.raw.technology["inserter-capacity-bonus-1"], "fast-inserter")
RemovePrerequisitesFromTechnology(data.raw.technology["inserter-capacity-bonus-1"], "stack-inserter")



-- Hide recipes from non-disabled techs.

data.raw.recipe["speed-module-3"].hidden = true
data.raw.recipe["productivity-module-2"].hidden = true
data.raw.recipe["productivity-module-3"].hidden = true
data.raw.recipe["steel-chest"].hidden = true

RemoveRecipeEffectFromTechnology(data.raw.technology["speed-module-3"], "speed-module-3")
RemoveRecipeEffectFromTechnology(data.raw.technology["productivity-module-2"], "productivity-module-2")
RemoveRecipeEffectFromTechnology(data.raw.technology["productivity-module-3"], "productivity-module-3")
RemoveRecipeEffectFromTechnology(data.raw.technology["steel-processing"], "steel-chest")

RemoveRecipeEffectFromTechnology(data.raw.technology["inserter-capacity-bonus-1"], "stack-inserter")



-- Disable/hide these recipes and/or technologies based on the Settings UI

if not settings.startup["TOPT-AllowLongHandedInserter"].value then
	data.raw.recipe["long-handed-inserter"].hidden = true
	RemoveRecipeEffectFromTechnology(data.raw.technology["automation"], "long-handed-inserter")
	data.raw.inserter["long-handed-inserter"].flags = { "hidden" }
end

if settings.startup["TOPT-UpdateSmallElectricPoleRecipe"].value then
	data.raw.recipe["small-electric-pole"].ingredients =
		{
			{"iron-stick", 2},
			{"copper-cable", 2}
		}
end

if not settings.startup["TOPT-AllowIronChestDefaultRecipe"].value then
	data.raw.recipe["iron-chest"].hidden = true
end

if not settings.startup["TOPT-AllowConstructionRobots"].value then
	data.raw.technology["construction-robotics"].hidden = true
	data.raw.recipe["construction-robot"].hidden = true
end

if not settings.startup["TOPT-AllowCoalLiquefaction"].value then
	data.raw.technology["coal-liquefaction"].hidden = true
	data.raw.recipe["coal-liquefaction"].hidden = true
end

if not settings.startup["TOPT-AllowArtillery"].value then
	data.raw.technology["artillery"].hidden = true
	data.raw.technology["artillery-shell-range-1"].hidden = true
	data.raw.technology["artillery-shell-speed-1"].hidden = true
	data.raw.recipe["artillery-turret"].hidden = true
	data.raw.recipe["artillery-wagon"].hidden = true
	data.raw.recipe["artillery-shell"].hidden = true
	data.raw.recipe["artillery-targeting-remote"].hidden = true
end

if not settings.startup["TOPT-AllowModularArmor"].value then
	data.raw.technology["modular-armor"].hidden = true
	data.raw.technology["power-armor"].hidden = true
	data.raw.technology["power-armor-mk2"].hidden = true
	data.raw.technology["effectivity-module"].hidden = true
	data.raw.technology["effectivity-module-2"].hidden = true
	data.raw.technology["fusion-reactor-equipment"].hidden = true
	data.raw.technology["solar-panel-equipment"].hidden = true
	data.raw.technology["energy-shield-equipment"].hidden = true
	data.raw.technology["energy-shield-mk2-equipment"].hidden = true
	data.raw.technology["discharge-defense-equipment"].hidden = true
	data.raw.technology["exoskeleton-equipment"].hidden = true
	data.raw.technology["belt-immunity-equipment"].hidden = true
	data.raw.technology["night-vision-equipment"].hidden = true
	data.raw.technology["battery-equipment"].hidden = true
	data.raw.technology["battery-mk2-equipment"].hidden = true
	data.raw.technology["personal-laser-defense-equipment"].hidden = true
	data.raw.technology["personal-roboport-equipment"].hidden = true
	data.raw.technology["personal-roboport-mk2-equipment"].hidden = true
	data.raw.recipe["modular-armor"].hidden = true
	data.raw.recipe["power-armor"].hidden = true
	data.raw.recipe["power-armor-mk2"].hidden = true
	data.raw.recipe["effectivity-module"].hidden = true
	data.raw.recipe["effectivity-module-2"].hidden = true
	data.raw.recipe["fusion-reactor-equipment"].hidden = true
	data.raw.recipe["solar-panel-equipment"].hidden = true
	data.raw.recipe["energy-shield-equipment"].hidden = true
	data.raw.recipe["energy-shield-mk2-equipment"].hidden = true
	data.raw.recipe["discharge-defense-equipment"].hidden = true
	data.raw.recipe["exoskeleton-equipment"].hidden = true
	data.raw.recipe["belt-immunity-equipment"].hidden = true
	data.raw.recipe["night-vision-equipment"].hidden = true
	data.raw.recipe["battery-equipment"].hidden = true
	data.raw.recipe["battery-mk2-equipment"].hidden = true
	data.raw.recipe["personal-laser-defense-equipment"].hidden = true
	data.raw.recipe["personal-roboport-equipment"].hidden = true
	data.raw.recipe["personal-roboport-mk2-equipment"].hidden = true
	
	RemoveRecipeEffectFromTechnology(data.raw.technology["speed-module-2"], "speed-module-2")
	data.raw.recipe["speed-module-2"].hidden = true
end

if not settings.startup["TOPT-AllowCombatRobots"].value then
	data.raw.technology["defender"].hidden = true
	data.raw.technology["distractor"].hidden = true
	data.raw.technology["destroyer"].hidden = true
	data.raw.recipe["defender-capsule"].hidden = true
	data.raw.recipe["distractor-capsule"].hidden = true
	data.raw.recipe["destroyer-capsule"].hidden = true
end

if not settings.startup["TOPT-AllowLaserTurrets"].value then
	data.raw.technology["laser"].hidden = true
	data.raw.technology["laser-turret"].hidden = true
	data.raw.technology["laser-shooting-speed-1"].hidden = true
	data.raw.technology["energy-weapons-damage-1"].hidden = true
	data.raw.technology["discharge-defense-equipment"].hidden = true
	data.raw.technology["personal-laser-defense-equipment"].hidden = true
	data.raw.recipe["laser-turret"].hidden = true
	data.raw.recipe["discharge-defense-equipment"].hidden = true
	data.raw.recipe["discharge-defense-remote"].hidden = true
	data.raw.recipe["personal-laser-defense-equipment"].hidden = true
end

if not settings.startup["TOPT-AllowSpidertron"].value then
	data.raw.technology["spidertron"].hidden = true
	data.raw.technology["effectivity-module-3"].hidden = true
	data.raw.recipe["spidertron"].hidden = true
	data.raw.recipe["effectivity-module-3"].hidden = true
end

if not settings.startup["TOPT-AllowRocketLauncher"].value then
	data.raw.technology["explosive-rocketry"].hidden = true  
	data.raw.technology["rocketry"].hidden = true
	data.raw.recipe["rocket"].hidden = true
	data.raw.recipe["rocket-launcher"].hidden = true
	data.raw.recipe["explosive-rocket"].hidden = true
end

if not settings.startup["TOPT-AllowAtomicBombs"].value then
	data.raw.technology["atomic-bomb"].hidden = true
	data.raw.recipe["atomic-bomb"].hidden = true
end



-- Update Technologies which depend on optionally disabled technologies due to settings

if not data.raw.technology["distractor"].hidden then
	if data.raw.technology["laser"].hidden then
		RemovePrerequisitesFromTechnology(data.raw.technology["distractor"], "laser")
	end
end

if not data.raw.technology["personal-laser-defense-equipment"].hidden then
	if data.raw.technology["laser"].hidden then
		RemovePrerequisitesFromTechnology(data.raw.technology["personal-laser-defense-equipment"], "laser-turret")
	end
end



-- Update recipes for items which depend on a disabled ingredient

if not settings.startup["TOPT-AllowIronChestDefaultRecipe"].value then
	data.raw.recipe["logistic-chest-storage"].ingredients =
		{
			{"wooden-chest", 1},
			{"electronic-circuit", 3},
			{"advanced-circuit", 1}
		}
	data.raw.recipe["logistic-chest-passive-provider"].ingredients =
		{
			{"wooden-chest", 1},
			{"electronic-circuit", 3},
			{"advanced-circuit", 1}
		}
	else
	data.raw.recipe["logistic-chest-storage"].ingredients =
		{
			{"iron-chest", 1},
			{"electronic-circuit", 3},
			{"advanced-circuit", 1}
		}
	data.raw.recipe["logistic-chest-passive-provider"].ingredients =
		{
			{"iron-chest", 1},
			{"electronic-circuit", 3},
			{"advanced-circuit", 1}
		}
end



-- Disable any placed electric furnaces but keep the item & recipe intact (For purple science)

local furnace_dummy = table.deepcopy(data.raw["furnace"]["electric-furnace"])
furnace_dummy.name = "electric-furnace-dummy"
furnace_dummy.energy_source = {type = "void"}
furnace_dummy.crafting_categories = {"smelting"}
furnace_dummy.minable = {mining_time = 0.5, result = "electric-furnace"}
furnace_dummy.localised_name = {"entity-name.electric-furnace"}
data:extend({furnace_dummy})

if data.raw.item["electric-furnace"] then
    data.raw.item["electric-furnace"].place_result = "electric-furnace-dummy"
end


	
-- Define Dummy entities for Solar Panels and Accumulators so that they can be toggled via settings (in control.lua)

-- Solar panel dummy
local solar_dummy = table.deepcopy(data.raw["solar-panel"]["solar-panel"])
solar_dummy.name = "solar-panel-dummy"
solar_dummy.production = "0.0001kW"
solar_dummy.minable = {mining_time = 0.5, result = "solar-panel"}
solar_dummy.localised_name = {"entity-name.solar-panel"}
data:extend({solar_dummy})

-- Accumulator dummy
local accumulator_dummy = table.deepcopy(data.raw["accumulator"]["accumulator"])
accumulator_dummy.name = "accumulator-dummy"
accumulator_dummy.energy_source = {
    type = "electric",
    buffer_capacity = "0.0001kJ",
    usage_priority = "tertiary",
    input_flow_limit = "0kW",
    output_flow_limit = "0kW"
}
accumulator_dummy.minable = {mining_time = 0.5, result = "accumulator"}
accumulator_dummy.localised_name = {"entity-name.accumulator"}
data:extend({accumulator_dummy})



-- Toggle fluid input on any newly placed Assembling Machine 1 based on setting

if settings.startup["TOPT-AllowFluidsInAssemblingMachine1"].value then
    data.raw["assembling-machine"]["assembling-machine-1"].fluid_boxes =
        table.deepcopy(data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes)
else
    data.raw["assembling-machine"]["assembling-machine-1"].fluid_boxes = nil
end



-- Restrict Assembling Machine 2 to only recipes with fluid ingredients

local fluid_categories = {}
for name, recipe in pairs(data.raw.recipe) do
    if recipe.ingredients then
        for _, ingredient in pairs(recipe.ingredients) do
            if ingredient.type == "fluid" then
                fluid_categories[recipe.category or "crafting"] = true
                break
            end
        end
    end
end

local allowed_categories = {}
for cat, _ in pairs(fluid_categories) do
    table.insert(allowed_categories, cat)
end

data.raw["assembling-machine"]["assembling-machine-2"].crafting_categories = allowed_categories



-- Hide items from planner UI

data.raw.item["centrifuge"].flags = { "hidden" }
data.raw.beacon["beacon"].flags = { "hidden" } 
data.raw.boiler["heat-exchanger"].flags = { "hidden" } 
data.raw.container["steel-chest"].flags = { "hidden" } 
data.raw.furnace["steel-furnace"].flags = { "hidden" } 
data.raw.furnace["electric-furnace"].flags = { "hidden" } 
data.raw.generator["steam-turbine"].flags = { "hidden" }
data.raw.item["heat-pipe"].flags = { "hidden" } 

data.raw.inserter["filter-inserter"].flags = { "hidden" } 
data.raw.inserter["stack-inserter"].flags = { "hidden" }
data.raw.inserter["stack-filter-inserter"].flags = { "hidden" }

data.raw.item["logistic-chest-requester"].flags = { "hidden" } 
data.raw.item["logistic-chest-active-provider"].flags = { "hidden" } 
data.raw.item["logistic-chest-buffer"].flags = { "hidden" } 

data.raw.item["logistic-robot"].flags = { "hidden" } 

data.raw.module["effectivity-module"].flags = { "hidden" } 
data.raw.module["effectivity-module-2"].flags = { "hidden" } 
data.raw.module["effectivity-module-3"].flags = { "hidden" } 
data.raw.module["productivity-module"].flags = { "hidden" } 
data.raw.module["productivity-module-2"].flags = { "hidden" }
data.raw.module["productivity-module-3"].flags = { "hidden" }
data.raw.module["speed-module"].flags = { "hidden" } 
data.raw.module["speed-module-2"].flags = { "hidden" } 
data.raw.module["speed-module-3"].flags = { "hidden" } 

data.raw.reactor["nuclear-reactor"].flags = { "hidden" }
 
--data.raw.splitter["fast-splitter"].flags = { "hidden" } 
--data.raw.splitter["express-splitter"].flags = { "hidden" } 

--data.raw.item["fast-transport-belt"].flags = { "hidden" } 
--data.raw.item["express-transport-belt"].flags = { "hidden" } 

--data.raw.item["fast-underground-belt"].flags = { "hidden" } 
--data.raw.item["express-underground-belt"].flags = { "hidden" } 
