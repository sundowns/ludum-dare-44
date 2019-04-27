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
    camera = require(PATH .. ".camera")
}
