love.filesystem.setRequirePath(love.filesystem.getRequirePath()..";lib/?.lua;lib/;")
DEBUG = false
CONSTANTS = nil
COMPONENTS = nil
ENTITIES = nil
SYSTEMS = nil

-- Libraries
ECS = nil
Component = nil
Entity = nil
Instance = nil
System = nil
Timer = nil
Camera = nil

function love.load()
end

function love.update(dt)
end

function love.draw()
end

function love.keypressed(key)
    if key == "f1" then
        DEBUG = not DEBUG
    elseif key == "escape" then
        love.event.quit()
    elseif key == "space" then
        love.event.quit('restart')
    end
end
