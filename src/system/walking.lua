local walking =
    System(
    {_components.walk, _components.transform, _components.collides, _components.player_state, _components.direction}
)

function walking:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local walk = e:get(_components.walk)
        local transform = e:get(_components.transform)
        local state = e:get(_components.player_state).state
        local direction = e:get(_components.direction)

        if state.state == "default" or state.state == "walk" then
            if love.keyboard.isDown(walk.keys.left) and not love.keyboard.isDown(walk.keys.right) then
                walk:move(-1)
                direction:set("left")
                if state.state == "default" then
                    state:setState("walk")
                    _instances.world:emit("spriteStateUpdated", e, "walk")
                    if walk.speed_multiplier > 1 then
                        _instances.world:emit("spriteStateUpdated", e, "run")
                    else
                        _instances.world:emit("spriteStateUpdated", e, "walk")
                    end
                end
            end
            if love.keyboard.isDown(walk.keys.right) and not love.keyboard.isDown(walk.keys.left) then
                walk:move(1)
                direction:set("right")
                if state.state == "default" then
                    state:setState("walk")
                    if walk.speed_multiplier > 1 then
                        _instances.world:emit("spriteStateUpdated", e, "run")
                    else
                        _instances.world:emit("spriteStateUpdated", e, "walk")
                    end
                end
            end

            if state.state == "walk" then
                transform:translate(walk.x_velocity * dt, 0)
                walk:applyFriction(dt)
                if walk.x_velocity == 0 then
                    state:setState("default")
                    _instances.world:emit("spriteStateUpdated", e, "default")
                end
            end
        end
    end
end

return walking
