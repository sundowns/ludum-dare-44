local PATH = (...):gsub("%.init$", "")

return {
    tile = require(PATH .. ".tile"),
    player = require(PATH .. ".player"),
    upgrade_jump = require(PATH .. ".upgrade_jump"),
    upgrade_speed = require(PATH .. ".upgrade_speed")
}
