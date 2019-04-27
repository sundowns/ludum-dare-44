local PATH = (...):gsub("%.init$", "")

return {
    collider = require(PATH .. ".collider"),
    stage_manager = require(PATH .. ".stage_manager"),
    sprite_renderer = require(PATH .. ".sprite_renderer"),
    walking = require(PATH .. ".walking")
}
