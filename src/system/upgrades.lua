local upgrades = System({_components.player_state})

function upgrades:init()
    self.hovered_upgrade_text = nil
end

function upgrades:upgradeAcquired(type)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        if type == "JUMP" then
            e:give(
                _components.jump,
                {
                    jump = "space"
                }
            ):apply()
        elseif type == "SPEED" then
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
end

function upgrades:upgradeHovered(friendly_name)
    self.hovered_upgrade_text = friendly_name
end

function upgrades:update(dt)
end

function upgrades:draw_ui()
    if self.hovered_upgrade_text then
        love.graphics.draw(
            self.hovered_upgrade_text,
            love.graphics.getWidth() / 2 - self.hovered_upgrade_text:getWidth() / 2,
            love.graphics.getHeight() / 3
        )
        self.hovered_upgrade_text = nil
    end
end

return upgrades
