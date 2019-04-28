local PATH = (...):gsub("%.init$", "")

return {
    collides = require(PATH .. ".collides"),
    sprite = require(PATH .. ".sprite"),
    transform = require(PATH .. ".transform"),
    walk = require(PATH .. ".walk"),
    gravity = require(PATH .. ".gravity"),
    jump = require(PATH .. ".jump"),
    camera = require(PATH .. ".camera"),
    player_state = require(PATH .. ".player_state"),
    air_control = require(PATH .. ".air_control"),
    collectible = require(PATH .. ".collectible"),
    health = require(PATH .. ".health")
}
