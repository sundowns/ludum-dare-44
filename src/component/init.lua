local PATH = (...):gsub("%.init$", "")

return {
    collides = require(PATH .. ".collides"),
    sprite = require(PATH .. ".sprite"),
    transform = require(PATH .. ".transform")
}
