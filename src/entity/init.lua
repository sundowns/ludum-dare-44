local PATH = (...):gsub("%.init$", "")

return {
    tile = require(PATH .. ".tile"),
    player = require(PATH .. ".player"),
    upgrade_jump = require(PATH .. ".upgrade_jump"),
    upgrade_speed = require(PATH .. ".upgrade_speed"),
    upgrade_double_jump = require(PATH .. ".upgrade_double_jump"),
    goal = require(PATH .. ".goal"),
    hazard = require(PATH .. ".hazard"),
    moving_hazard = require(PATH .. ".moving_hazard"),
    moving_tile = require(PATH .. ".moving_tile"),
    heart = require(PATH .. ".heart"),
    upgrade_air_dash = require(PATH .. ".upgrade_air_dash")
}
