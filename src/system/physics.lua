local physics = System({_components.transform})

function physics:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local transform = e:get(_components.transform)

        transform.pos = transform.pos + transform.vel * dt
        if e:has(_components.collides) then
            self:getInstance():emit("evaluateCollidable", e)
        end
        -- self:getInstance():emit
    end
end

return physics
