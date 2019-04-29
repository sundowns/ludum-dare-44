victory = {}
local splashScreen = nil
local MINIMUM_TIME = 1
local loadTimer = 0

function victory:init()
    -- splashScreen = love.graphics.newImage("asset/victory.png")
end

function victory:update(dt)
    loadTimer = loadTimer + dt
end

function victory:draw()
    -- love.graphics.draw(
    --     splashScreen,
    --     0,
    --     0,
    --     0,
    --     love.graphics:getWidth() / splashScreen:getWidth(),
    --     love.graphics.getHeight() / splashScreen:getHeight()
    -- )

    love.graphics.setColor(0, 1, 0)
    love.graphics.print("u win (press escape to exit)", 100, 100)
end

function victory:keypressed(key)
    if key == "escape" then
        if loadTimer > MINIMUM_TIME then
            love.event.quit()
        end
    end
end
