local patrol = System({_components.patrolling, _components.transform})

function patrol:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local patrolling = e:get(_components.patrolling)
        local position = e:get(_components.transform).pos

        if patrolling.moving_to == "ORIGIN" then
            position.x = position.x + (patrolling.origin.x - patrolling.destination.x) * patrolling.speed * dt
            position.y = position.y + (patrolling.origin.y - patrolling.destination.y) * patrolling.speed * dt

            if
                Util.m.withinVariance(position.x, patrolling.origin.x, 1) and
                    Util.m.withinVariance(position.y, patrolling.origin.y, 1)
             then
                patrolling:target("DESTINATION")
            end
        elseif patrolling.moving_to == "DESTINATION" then
            position.x = position.x + (patrolling.destination.x - patrolling.origin.x) * patrolling.speed * dt
            position.y = position.y + (patrolling.destination.y - patrolling.origin.y) * patrolling.speed * dt

            if
                Util.m.withinVariance(position.x, patrolling.destination.x, 1) and
                    Util.m.withinVariance(position.y, patrolling.destination.y, 1)
             then
                patrolling:target("ORIGIN")
            end
        end

        if e:has(_components.damage) or e:has(_components.collides) then
            self:getInstance():emit("updateHitbox", e)
        end
    end
end

return patrol
