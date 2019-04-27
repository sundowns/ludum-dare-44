local PATH = (...):gsub("%.init$", "")

return {
    stageManager = require(PATH .. ".stageManager")
}
