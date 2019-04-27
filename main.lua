love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";lib/?.lua;lib/;")
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
    love.graphics.setDefaultFilter("nearest", "nearest", 1)
    CONSTANTS = require("src.constants")
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

    COMPONENTS = require("src.component")
    ENTITIES = require("src.entity")
    SYSTEMS = require("src.system")
    INSTANCES = require("src.instance")
end

function love.update(dt)
    INSTANCES.world:emit("update", dt)
    Timer.update(dt)
end

function love.draw()
    INSTANCES.world:emit("draw")
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
    INSTANCES.world:emit("keyreleased", key)
end

function love.keypressed(key)
    if key == "f1" then
        DEBUG = not DEBUG
    elseif key == "escape" then
        love.event.quit()
    elseif key == "space" then
        love.event.quit("restart")
    end
    INSTANCES.world:emit("keypressed", key)
end
