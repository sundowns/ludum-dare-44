local world = Instance()

local stageManager = _systems.stageManager()

-- ADD SYSTEMS

world:addSystem(stageManager, "draw")
world:addSystem(stageManager, "update")

world:enableSystem(stageManager, "draw")

function world:enableUpdates()
    world:enableSystem(stageManager, "update")
end

function world:disableUpdates()
    world:disableSystem(stageManager, "update")
end

world:enableUpdates()

return world
