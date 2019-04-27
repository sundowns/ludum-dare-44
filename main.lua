love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";lib/?.lua;lib/;")
_debug = false
_constants = nil
_components = nil
_entities = nil
_instances = nil
_systems = nil

-- Libraries
ECS = nil
Component = nil
Entity = nil
Instance = nil
System = nil
Timer = nil
Camera = nil

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    _constants = require("src.constants")
    Util = require("lib.util")
    assets = require("lib.cargo").init("asset")
    STI = require("lib.sti")
    ECS =
        require("lib.concord").init(
        {
            useEvents = false
        }
    )
    Component = require("lib.concord.component")
    Entity = require("lib.concord.entity")
    Instance = require("lib.concord.instance")
    System = require("lib.concord.system")
    Vector = require("lib.vector")
    Timer = require("lib.timer")

    _components = require("src.component")
    _entities = require("src.entity")
    _systems = require("src.system")
    _instances = require("src.instance")
end

function love.update(dt)
    _instances.world:emit("update", dt)
    Timer.update(dt)
end

function love.draw()
    _instances.world:emit("draw")
    local x, y = 10, 60
    function bump(y, delta)
        return y + delta
    end
    love.graphics.print("[CONTROLS]", x, y)
    y = bump(y, 40)
    love.graphics.print("[w] [up]:        Up", x, y)
    y = bump(y, 25)
    love.graphics.print("[s] [down]:   Down", x, y)
    y = bump(y, 25)
    love.graphics.print("[a] [left]:      Left", x, y)
    y = bump(y, 25)
    love.graphics.print("[d] [right]:    Right", x, y)
end

function love.keyreleased(key)
    _instances.world:emit("keyreleased", key)
end

function love.keypressed(key)
    if key == "f1" then
        _debug = not _debug
    elseif key == "escape" then
        love.event.quit()
    elseif key == "space" then
        love.event.quit("restart")
    end
    _instances.world:emit("keypressed", key)
end
