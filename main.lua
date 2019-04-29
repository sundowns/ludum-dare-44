love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";lib/?.lua;lib/;")
_debug = true
_constants = nil
_components = nil
_entities = nil
_instances = nil
_systems = nil
_fonts = {}

-- Libraries
ECS = nil
Component = nil
Entity = nil
Instance = nil
System = nil
Timer = nil
Camera = nil
Bump = nil
Util = nil
anim8 = nil

function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 0)
    _constants = require("src.constants")
    Util = require("lib.util")
    assets = require("lib.cargo").init("asset")
    anim8 = require("lib.anim8")
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
    Bump = require("lib.bump")
    Camera = require("lib.camera")
    Behavior = require("lib.behavior")

    _fonts = {
        ["COLLECTIBLES"] = assets.all_business(36),
        ["WARNING"] = assets.all_business(48)
    }

    _components = require("src.component")
    _entities = require("src.entity")
    _systems = require("src.system")
    _instances = require("src.instance")

    _instances.world:emit("stageLoaded", "resource/test2.lua")
end

function love.update(dt)
    _instances.world:emit("update", dt)
    Timer.update(dt)
end

function love.draw()
    _instances.world:emit("attach")
    _instances.world:emit("draw")
    _instances.world:emit("detach")
    _instances.world:emit("draw_ui")
end

function love.keyreleased(key)
    _instances.world:emit("keyreleased", key)
end

function love.keypressed(key)
    if key == "f1" then
        _debug = not _debug
    elseif key == "escape" then
        love.event.quit()
    elseif key == "return" then
        love.event.quit("restart")
    end
    _instances.world:emit("keypressed", key)
end
