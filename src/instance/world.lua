local world = Instance()

local stage_manager = _systems.stage_manager()
local sprite_renderer = _systems.sprite_renderer()
local collider = _systems.collider()
local walking = _systems.walking()

-- ADD SYSTEMS

world:addSystem(stage_manager, "draw")
world:addSystem(stage_manager, "update")
world:addSystem(stage_manager, "stageLoaded")

-- world:addSystem(sprite_renderer, "draw")
-- world:addSystem(sprite_renderer, "update")
-- world:addSystem(sprite_renderer, "spriteStateUpdated")

world:addSystem(collider, "draw")
world:addSystem(collider, "update")

world:addSystem(walking, "update")
world:addSystem(walking, "draw")

-- ENABLE SYSTEMS

world:enableSystem(stage_manager, "draw")
world:enableSystem(stage_manager, "stageLoaded")

world:enableSystem(collider, "draw")

world:enableSystem(walking, "draw")

function world:enableUpdates()
    world:enableSystem(stage_manager, "update")
    world:enableSystem(collider, "update")
    world:enableSystem(walking, "update")
end

function world:disableUpdates()
    world:disableSystem(stage_manager, "update")
end

world:enableUpdates()

return world
