local walking = System({_components.walk, _components.transform, _components.collides})

function walking:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local walk = e:get(_components.walk)
        local transform = e:get(_components.transform)
        Util.t.print(transform.pos)
        -- TODO: need to check if the player is actually grounded. If not, don't apply any of the below (and reset velocity to 0)

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

return walking
