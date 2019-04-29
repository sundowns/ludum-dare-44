title = {}
local splashScreen = nil
local MINIMUM_TITLE_TIME = 1
local loadTimer = 0

local anim8 = require("lib.anim8")
local kitty_img = nil
local kitty_animation = nil
local kitty_scale = 4

function title:init()
    splashScreen = love.graphics.newImage("asset/titlescreen_nocontrols.png")
    kitty_img = love.graphics.newImage("asset/player.png")
    local g = anim8.newGrid(32, 32, kitty_img:getWidth(), kitty_img:getHeight())
    kitty_animation = anim8.newAnimation(g("1-6", 1), 0.125)
end

function title:enter(previous, task, data)
end

function title:leave()
end

function title:update(dt)
    loadTimer = loadTimer + dt
    kitty_animation:update(dt)
end

function title:draw()
    love.graphics.draw(
        splashScreen,
        0,
        0,
        0,
        love.graphics:getWidth() / splashScreen:getWidth(),
        love.graphics.getHeight() / splashScreen:getHeight()
    )
    kitty_animation:draw(
        kitty_img,
        love.graphics.getWidth() / 2 - (12 * kitty_scale),
        love.graphics.getHeight() / 4,
        0,
        kitty_scale,
        kitty_scale
    )
end

function title:keypressed(key)
    if key ~= "escape" then
        if loadTimer > MINIMUM_TITLE_TIME then
            loadGame()
        end
    else
        love.event.quit()
    end
end

function loadGame()
    -- Load assets here
    GamestateManager.switch(game)
end
