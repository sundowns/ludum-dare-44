function love.load()
    love.graphics.setDefaultFilter("nearest", "nearest", 0)
    GamestateManager = require("lib.gamestate")
    require("title")
    require("game")
    require("victory")
    require("defeat")
    love.window.setIcon(love.image.newImageData("asset/icon.png"))
    GamestateManager.registerEvents()
    GamestateManager.switch(game) -- TODO: make title
end

function love.update(dt)
end

function love.draw()
end
