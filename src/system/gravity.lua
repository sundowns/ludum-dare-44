local gravity = System({_components.gravity, _components.transform})

function gravity:init()
end

function gravity:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local transform = e:get(_components.transform)
        local gravity = e:get(_components.gravity)

        transform.pos.y = transform.pos.y + (gravity.strength * dt)
    end
end

return gravity
