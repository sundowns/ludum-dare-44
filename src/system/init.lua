local PATH = (...):gsub("%.init$", "")

return {
    collider = require(PATH .. ".collider"),
    gravity = require(PATH .. ".gravity"),
    stage_manager = require(PATH .. ".stage_manager"),
    sprite_renderer = require(PATH .. ".sprite_renderer"),
    walking = require(PATH .. ".walking"),
    jumping = require(PATH .. ".jumping"),
    gravity = require(PATH .. ".gravity"),
    physics = require(PATH .. ".physics"),
    camera = require(PATH .. ".camera"),
    state_manager = require(PATH .. ".state_manager"),
    upgrades = require(PATH .. ".upgrades"),
    damage = require(PATH .. ".damage"),
    levitation = require(PATH .. ".levitation"),
    patrol = require(PATH .. ".patrol"),
    air_dash = require(PATH .. ".air_dash")
}
