local world = Instance()

local stage_manager = _systems.stage_manager()
local sprite_renderer = _systems.sprite_renderer()
local collider = _systems.collider()
local walking = _systems.walking()
local gravity = _systems.gravity()
local jumping = _systems.jumping()
local physics = _systems.physics()
local camera = _systems.camera()
local state_manager = _systems.state_manager()

-- ADD SYSTEMS

world:addSystem(stage_manager, "draw")
world:addSystem(stage_manager, "update")
world:addSystem(stage_manager, "stageLoaded")

-- world:addSystem(sprite_renderer, "draw")
-- world:addSystem(sprite_renderer, "update")
-- world:addSystem(sprite_renderer, "spriteStateUpdated")

world:addSystem(collider, "draw")
world:addSystem(collider, "update")
world:addSystem(collider, "evaluateCollidable")

world:addSystem(walking, "update")

world:addSystem(gravity, "update")

world:addSystem(jumping, "update")

world:addSystem(physics, "update")

world:addSystem(camera, "update")
world:addSystem(camera, "attach")
world:addSystem(camera, "detach")

world:addSystem(state_manager, "update")

-- ENABLE SYSTEMS

world:enableSystem(stage_manager, "stageLoaded")

world:enableSystem(collider, "draw")
world:enableSystem(collider, "evaluateCollidable")

world:enableSystem(camera, "attach")
world:enableSystem(camera, "detach")

function world:enableUpdates()
    world:enableSystem(stage_manager, "update")
    world:enableSystem(collider, "update")
    world:enableSystem(walking, "update")
    world:enableSystem(gravity, "update")
    world:enableSystem(jumping, "update")
    world:enableSystem(physics, "update")
    world:enableSystem(camera, "update")
    world:enableSystem(state_manager, "update")
end

function world:disableUpdates()
    world:disableSystem(stage_manager, "update")
    world:disableSystem(collider, "update")
    world:disableSystem(walking, "update")
    world:disableSystem(gravity, "update")
    world:disableSystem(jumping, "update")
    world:disableSystem(physics, "update")
    world:disableSystem(camera, "update")
    world:disableSystem(state_manager, "update")
end

world:enableUpdates()

return world
