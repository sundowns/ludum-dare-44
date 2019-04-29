defeat = {}
local splashScreen = nil
local MINIMUM_TIME = 0.5
local loadTimer = 0

function defeat:init()
    splashScreen = love.graphics.newImage("asset/lose.png")
end

function defeat:update(dt)
    loadTimer = loadTimer + dt
end

function defeat:draw()
    love.graphics.draw(
        splashScreen,
        0,
        0,
        0,
        love.graphics:getWidth() / splashScreen:getWidth(),
        love.graphics.getHeight() / splashScreen:getHeight()
    )
end

function defeat:keypressed(key)
    if key == "space" then
        if loadTimer > MINIMUM_TIME then
            love.event.quit("restart")
        end
    end
end
