local jumping = System({_components.jump, _components.transform})

function jumping:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local jump = e:get(_components.jump)
        local transform = e:get(_components.transform)

        if love.keyboard.isDown(jump.keys.jump) and not jump.is_jumping then
            transform.vel.y = -1 * jump.jump_velocity
            jump.is_jumping = true
        end
    end
end

return jumping
