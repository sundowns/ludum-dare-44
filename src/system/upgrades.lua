local upgrades = System({_components.player_state, _components.health})

function upgrades:init()
    self.hovered_upgrade = nil
    self.show_too_expensive_warning = false
    self.too_expensive_text = love.graphics.newText(_fonts.WARNING, "Not enough hearts </3")
    self.tooltip_timer = Timer.new()
end

function upgrades:acquireUpgrade(powerup)
    local upgrade = powerup:get(_components.collectible)

    local powerup_was_consumed = false

    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local health = e:get(_components.health)
        if upgrade.health_cost >= health.current then
            self.show_too_expensive_warning = true
            self.tooltip_timer:clear()
            self.tooltip_timer:after(
                2,
                function()
                    self.show_too_expensive_warning = false
                end
            )
            break
        else
            powerup_was_consumed = true
        end

        health:reduce(upgrade.health_cost)
        if upgrade.type == "JUMP" then
            e:give(
                _components.jump,
                {
                    jump = "space"
                }
            ):apply()
        elseif upgrade.type == "SPEED" then
            e:remove(_components.walk):remove(_components.air_control):apply()

            e:give(
                _components.walk,
                {
                    left = "a",
                    right = "d"
                },
                _constants.UPGRADE_SPEED_GROUND_MULTIPLIER
            ):give(
                _components.air_control,
                {
                    left = "a",
                    right = "d"
                },
                _constants.UPGRADE_SPEED_AIR_MULTIPLIER
            ):apply()
        end
    end
    if powerup_was_consumed then
        -- self.tooltip_timer:clear() -- TODO: possibly this ey
        powerup:destroy()
    end
end

function upgrades:upgradeHovered(upgrade)
    self.hovered_upgrade = upgrade
end

function upgrades:update(dt)
    self.tooltip_timer:update(dt)
end

function upgrades:draw_ui()
    if self.hovered_upgrade then
        love.graphics.setColor(_constants.COLOURS.ACQUIRE_UPGRADE)
        love.graphics.draw(
            self.hovered_upgrade.friendly_name,
            love.graphics.getWidth() / 2 - self.hovered_upgrade.friendly_name:getWidth() / 2,
            love.graphics.getHeight() / 3
        )
        self.hovered_upgrade = nil
    end

    if self.show_too_expensive_warning then
        love.graphics.setColor(_constants.COLOURS.WARNING)
        love.graphics.draw(
            self.too_expensive_text,
            love.graphics.getWidth() / 2 - self.too_expensive_text:getWidth() / 2,
            love.graphics.getHeight() / 4
        )
    end

    Util.l.resetColour()

    -- not sure if upgrade should be the one showing this but EH
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local health = e:get(_components.health)
        for i = 1, health.current do
            -- TODO: replace with pretty hearts or something
            love.graphics.print(i, 20 + (i * 20), 20)
        end
    end
end

return upgrades
