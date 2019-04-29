local damage =
    System({_components.player_state, _components.health}, {_components.invulnerability, "invulnerabilities"})

function damage:playerTouchedHazard(damage)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        if not e:has(_components.invulnerability) then
            local health = e:get(_components.health)

            self:getInstance():emit("shake", 0.6, 1.5)
            health.current = health.current - damage
            if health.current < 1 then
                GamestateManager.switch(defeat)
            end

            e:give(_components.invulnerability):give(_components.hurt):apply()
            local invulnerability = e:get(_components.invulnerability)
            invulnerability.timer:after(
                invulnerability.duration,
                function()
                    e:remove(_components.invulnerability):remove(_components.hurt):apply()
                end
            )
        end
    end
end

function damage:update(dt)
    for i = 1, self.invulnerabilities.size do
        self.invulnerabilities:get(i):get(_components.invulnerability).timer:update(dt)
    end
end

return damage
