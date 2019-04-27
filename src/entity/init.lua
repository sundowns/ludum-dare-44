local PATH = (...):gsub("%.init$", "")

return {
    tile = require(PATH .. ".tile")
}
