victory = {}
local splashScreen = nil
local MINIMUM_TIME = 0.5
local loadTimer = 0

function victory:init()
    splashScreen = love.graphics.newImage("asset/win.png")
end

function victory:update(dt)
    loadTimer = loadTimer + dt
end

function victory:draw()
    love.graphics.draw(
        splashScreen,
        0,
        0,
        0,
        love.graphics:getWidth() / splashScreen:getWidth(),
        love.graphics.getHeight() / splashScreen:getHeight()
    )
end

function victory:keypressed(key)
    if key == "space" then
        if loadTimer > MINIMUM_TIME then
            love.event.quit("restart")
        end
    end
end
