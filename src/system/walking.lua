local walking = System({_components.walk, _components.transform, _components.collides, _components.player_state})

function walking:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local walk = e:get(_components.walk)
        local transform = e:get(_components.transform)
        local state = e:get(_components.player_state).state

        if state.state == "default" then
            if love.keyboard.isDown(walk.keys.left) and not love.keyboard.isDown(walk.keys.right) then
                walk:move(-1)
            end
            if love.keyboard.isDown(walk.keys.right) and not love.keyboard.isDown(walk.keys.left) then
                walk:move(1)
            end

            transform:translate(walk.x_velocity * dt, 0)
            walk:applyFriction(dt)
        end
    end
end

return walking
