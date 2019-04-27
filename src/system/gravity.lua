local gravity = System({_components.gravity, _components.transform})

function gravity:init()
end

function gravity:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local transform = e:get(_components.transform)
        local gravity = e:get(_components.gravity)

        -- TODO: only run below if the target is aerial
        transform.vel.y = transform.vel.y + (gravity.strength * dt)
        -- if e:has(_components.collides) then
        --     self:getInstance():emit("evaluateCollidable", e)
        -- end

        -- transform.vel.y = transform.vel.y + (gravity.strength * dt)
    end
end

return gravity
