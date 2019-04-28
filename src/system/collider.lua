local collider =
    System(
    {_components.collides, _components.transform, "ALL"},
    {
        _components.collides,
        _components.transform,
        _components.jump,
        _components.player_state,
        "JUMPER"
    }
)

function collider:init()
    self.collision_world = Bump.newWorld()
end

function collider:entityAdded(e)
    local collides = e:get(_components.collides)
    local position = e:get(_components.transform).pos
    self.collision_world:add(collides, position.x, position.y, collides.width, collides.height)
end

function collider:entityRemoved(e)
    self.collision_world:remove(e:get(_components.collides))
end

function collider:update(dt)
    for i = 1, self.ALL.size do
        local e = self.ALL:get(i)
        local transform = e:get(_components.transform)
        local collides = e:get(_components.collides)

        local actualX, actualY, cols, len = self.collision_world:move(collides, transform.pos.x, transform.pos.y)
        transform:setPosition(Vector(actualX, actualY))
    end

    for i = 1, self.JUMPER.size do
        local e = self.JUMPER:get(i)
        local jump = e:get(_components.jump)
        local transform = e:get(_components.transform)
        local collides = e:get(_components.collides)
        local state = e:get(_components.player_state).state
        if state.state == "jump" then
            -- query to see if player is on the ground
            local items, len =
                self.collision_world:queryRect(
                transform.pos.x + collides.width * 0.025,
                transform.pos.y + collides.height,
                collides.width * 0.95,
                1
            )
            if len > 0 then
                state:setState("default")
            else
                -- query to see if player has bumped their head
                local items2, len2 =
                    self.collision_world:queryRect(
                    transform.pos.x + collides.width * 0.2,
                    transform.pos.y - 5,
                    collides.width * 0.6,
                    1
                )
                if len2 > 0 then
                    jump:bump_head()
                end
            end
        end
    end
end

function collider:draw()
    if _debug then
        love.graphics.setColor(1, 0, 0)
        love.graphics.setLineWidth(1)
        local items, len = self.collision_world:getItems()
        for i = #items, 1, -1 do
            love.graphics.rectangle("line", self.collision_world:getRect(items[i]))
        end
        Util.l.resetColour()
    end
end

function collider:evaluateCollidable(entity)
    -- transform:setPosition(Vector(actualX, actualY))
    local transform = entity:get(_components.transform)
    local collides = entity:get(_components.collides)
    local actualX, actualY, cols, len = self.collision_world:move(collides, transform.pos.x, transform.pos.y)
end

return collider
