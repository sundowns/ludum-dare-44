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
    health = require(PATH .. ".health"),
    direction = require(PATH .. ".direction"),
    goal = require(PATH .. ".goal"),
    damage = require(PATH .. ".damage"),
    invulnerability = require(PATH .. ".invulnerability"),
    levitating = require(PATH .. ".levitating"),
    patrolling = require(PATH .. ".patrolling"),
    hurt = require(PATH .. ".hurt"),
    air_dash = require(PATH .. ".air_dash")
}
