defeat = {}
local splashScreen = nil
local MINIMUM_TIME = 1
local loadTimer = 0

function defeat:init()
    -- splashScreen = love.graphics.newImage("asset/victory.png")
end

function defeat:update(dt)
    loadTimer = loadTimer + dt
end

function defeat:draw()
    -- love.graphics.draw(
    --     splashScreen,
    --     0,
    --     0,
    --     0,
    --     love.graphics:getWidth() / splashScreen:getWidth(),
    --     love.graphics.getHeight() / splashScreen:getHeight()
    -- )

    love.graphics.setColor(1, 0, 0)
    love.graphics.print("ur dead bruh (press escape to exit)", 100, 100)
end

function defeat:keypressed(key)
    if key == "escape" then
        if loadTimer > MINIMUM_TIME then
            love.event.quit()
        end
    elseif key == "space" then
        love.event.quit("restart")
    end
end
