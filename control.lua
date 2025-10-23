
-- Utility functions for checking setting states
local function solar_disabled()
    return not (settings.global["TOPT-AllowSolarEnergyProduction"] and settings.global["TOPT-AllowSolarEnergyProduction"].value)
end

local function accumulator_disabled()
    return not (settings.global["TOPT-AllowAccumulatorEnergyStorage"] and settings.global["TOPT-AllowAccumulatorEnergyStorage"].value)
end

-- Always prevent placement of electric furnaces
script.on_event(defines.events.on_built_entity, function(event)
    local entity = event.created_entity or event.entity
    if not (entity and entity.valid) then return end

    if entity.name == "electric-furnace" then
        entity.surface.create_entity{
            name = "flying-text",
            position = entity.position,
            text = {"", "[Electric furnace placement blocked]"},
            color = {r=1, g=0.3, b=0.3}
        }
        entity.destroy()
        return
    end
end)

-- Also catch robot placement for furnaces
script.on_event(defines.events.on_robot_built_entity, function(event)
    script.raise_event(defines.events.on_built_entity, event)
end)

-- Function to update all solar panels and accumulators based on current settings
local function update_energy_entities()
    for _, surface in pairs(game.surfaces) do
        for _, solar in pairs(surface.find_entities_filtered{name = "solar-panel"}) do
            local enabled = not solar_disabled()
            solar.active = enabled
            if not enabled then
                surface.create_entity{
                    name = "flying-text",
                    position = {solar.position.x, solar.position.y - 0.5},
                    text = {"", "[Solar panel disabled]"},
                    color = {r=1, g=0.8, b=0.2}
                }
            end
        end
        for _, acc in pairs(surface.find_entities_filtered{name = "accumulator"}) do
            local enabled = not accumulator_disabled()
            acc.active = enabled
            if not enabled then
                surface.create_entity{
                    name = "flying-text",
                    position = {acc.position.x, acc.position.y - 0.5},
                    text = {"", "[Accumulator disabled]"},
                    color = {r=0.6, g=0.9, b=1}
                }
            end
        end
    end
end


-- On setting change, apply new behavior immediately
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
    local name = event.setting
    if name == "TOPT-AllowSolarEnergyProduction" or name == "TOPT-AllowAccumulatorEnergyStorage" then
        update_energy_entities()
        game.print("[TOPT] Energy production settings updated.")
    end
end)

-- When a chunk is loaded or player joins, ensure correct active states
local function enforce_states()
    update_energy_entities()
end

script.on_event(defines.events.on_chunk_generated, enforce_states)
script.on_event(defines.events.on_player_joined_game, enforce_states)
script.on_init(enforce_states)
script.on_configuration_changed(enforce_states)



-- Long-handed inserter runtime control

local function inserter_disabled()
	return not (settings.startup["TOPT-AllowLongHandedInserter"] and settings.startup["TOPT-AllowLongHandedInserter"].value)
end

-- Prevent new placement when disabled
script.on_event(defines.events.on_built_entity, function(event)
	local entity = event.created_entity or event.entity
	if not (entity and entity.valid) then return end

	if entity.name == "long-handed-inserter" and inserter_disabled() then
		entity.surface.create_entity{
			name = "flying-text",
			position = entity.position,
			text = {"", "[Long-handed inserters disabled]"},
			color = {r=1, g=0.3, b=0.3}
		}
		entity.destroy()
	end
end)

-- Mirror this for construction robots
script.on_event(defines.events.on_robot_built_entity, function(event)
	script.raise_event(defines.events.on_built_entity, event)
end)

-- Refund components for removed long-handed inserters
local function refund_long_inserters(player)
	local inv = player.get_main_inventory()
	if not inv then return end

	local removed_count = inv.remove{name="long-handed-inserter", count=inv.get_item_count("long-handed-inserter")}
	if removed_count > 0 then
		-- Adjust these ingredients if your mod overrides the recipe
		local refund_items = {
			{name="iron-plate", count=removed_count},
			{name="iron-gear-wheel", count=removed_count},
			{name="inserter", count=removed_count}
		}
		for _, item in pairs(refund_items) do
			local inserted = inv.insert(item)
			if inserted < item.count then
				-- Drop extras on the ground if inventory is full
				player.surface.spill_item_stack(player.position, {name=item.name, count=item.count - inserted}, true)
			end
		end
		player.print("[TOPT] Refunded " .. removed_count .. " long-handed inserters as components.")
	end
end

-- Integrate cleanup into availability update
local function update_inserter_availability()
	for _, player in pairs(game.connected_players) do
		local force = player.force
		if inserter_disabled() then
			force.recipes["long-handed-inserter"].enabled = false
			refund_long_inserters(player)
			player.print("[TOPT] Long-handed inserters are now disabled.")
		else
			force.recipes["long-handed-inserter"].enabled = true
			player.print("[TOPT] Long-handed inserters are now enabled.")
		end
	end
end


-- Apply when setting changes
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event)
	if event.setting == "TOPT-AllowLongHandedInserter" then
		update_inserter_availability()
	end
end)

-- Apply on init/load/configuration change
script.on_init(update_inserter_availability)
script.on_configuration_changed(update_inserter_availability)
script.on_event(defines.events.on_player_joined_game, update_inserter_availability)