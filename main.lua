function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 0)
    GamestateManager = require("lib.gamestate")
    require("title")
    require("game")
    love.window.setIcon(love.image.newImageData("asset/icon.png"))
    GamestateManager.registerEvents()
    GamestateManager.switch(title)
end

function love.update(dt)
end

function love.draw()
end
