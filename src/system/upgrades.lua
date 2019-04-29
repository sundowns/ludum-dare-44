local upgrades = System({_components.player_state, _components.health})

function upgrades:init()
    self.hovered_upgrade = nil
    self.show_too_expensive_warning = false
    self.too_expensive_text = love.graphics.newText(_fonts.WARNING, "Not enough hearts :(")
    self.tooltip_timer = Timer.new()
    self.heart_quad =
        love.graphics.newQuad(
        _constants.CELL_WIDTH,
        _constants.CELL_HEIGHT * 2.5,
        _constants.CELL_WIDTH / 2,
        _constants.CELL_HEIGHT / 2,
        assets.tileset:getDimensions()
    )

    self.health_flashing_timer = Timer.new()
    self.health_flashing_timer:every(
        _constants.HEART_LOSS_FLASH_INTERVAL,
        function()
            self.heart_is_flashing = not self.heart_is_flashing
        end
    )
    self.heart_is_flashing = false
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

            self:getInstance():emit("shake", 0.4, 1.5)

            if upgrade.health_cost > 0 then
                e:give(_components.hurt):apply()
                self.health_flashing_timer:after(
                    _constants.INVULNERABILITY_DURATION,
                    function()
                        e:remove(_components.hurt):apply()
                    end
                )
            end
        end

        health:reduce(upgrade.health_cost)
        if upgrade.type == "JUMP" then
            e:give(
                _components.jump,
                {
                    jump = "space"
                },
                false
            ):apply()
        elseif upgrade.type == "DOUBLE_JUMP" then
            if e:has(_components.jump) then
                e:remove(_components.jump):apply()
            end
            e:give(
                _components.jump,
                {
                    jump = "space"
                },
                true
            ):apply()
        elseif upgrade.type == "AIR_DASH" then
            e:give(
                _components.air_dash,
                {
                    dash = "lshift"
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
        elseif upgrade.type == "HEART" then
            local health = e:get(_components.health)
            health:reduce(-1) -- heal a heart lmao
        end
    end
    if powerup_was_consumed then
        powerup:destroy()
    end
end

function upgrades:upgradeHovered(upgrade)
    self.hovered_upgrade = upgrade
end

function upgrades:update(dt)
    self.tooltip_timer:update(dt)
    self.health_flashing_timer:update(dt)
end

function upgrades:draw_ui()
    if self.hovered_upgrade then
        love.graphics.setColor(_constants.COLOURS.ACQUIRE_UPGRADE)
        love.graphics.draw(
            self.hovered_upgrade.friendly_name,
            love.graphics.getWidth() / 2 - self.hovered_upgrade.friendly_name:getWidth() / 2,
            love.graphics.getHeight() / 3
        )
        love.graphics.setColor(1, 0, 0, 0.8)
        local buffer = 20
        for i = 1, self.hovered_upgrade.health_cost do
            love.graphics.draw(
                assets.tileset,
                self.heart_quad,
                love.graphics.getWidth() / 2 - ((_constants.CELL_WIDTH + buffer) * self.hovered_upgrade.health_cost) / 2 +
                    ((_constants.CELL_WIDTH + buffer) * (i - 1)),
                love.graphics.getHeight() / 3 + self.hovered_upgrade.friendly_name:getHeight() * 1.25,
                0,
                2,
                2
            )
        end

        Util.l.resetColour()
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
        love.graphics.push()
        love.graphics.scale(1.75, 1.75)

        self:handle_flashing(e)
        for i = 1, health.current do
            love.graphics.draw(assets.tileset, self.heart_quad, 16 + (i * 20), 16)
        end
        Util.l.resetColour()
        love.graphics.pop()
    end
end

function upgrades:handle_flashing(e)
    if e:has(_components.hurt) then
        if self.heart_is_flashing then
            love.graphics.setColor(1, 0, 0, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
    else
        love.graphics.setColor(1, 1, 1, 1)
    end
end

return upgrades
