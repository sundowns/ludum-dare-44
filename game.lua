game = {}

love.filesystem.setRequirePath(love.filesystem.getRequirePath() .. ";lib/?.lua;lib/;")
_debug = false
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

function game:init()
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

    _instances.world:emit("stageLoaded", "resource/realdeal.lua")
end

function game:update(dt)
    _instances.world:emit("update", dt)
    Timer.update(dt)
end

function game:draw()
    _instances.world:emit("attach")
    _instances.world:emit("draw")
    _instances.world:emit("detach")
    _instances.world:emit("draw_ui")
end

function game:keyreleased(key)
    _instances.world:emit("keyreleased", key)
end

function game:keypressed(key)
    if key == "f1" then -- TODO: REMOVE!!
        _debug = not _debug
    end
    _instances.world:emit("keypressed", key)
end
