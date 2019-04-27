local collider =
    System(
    {_components.collides, _components.transform, "ALL"},
    {
        _components.collides,
        _components.transform,
        _components.jump,
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
        if jump.is_jumping then
            -- query to see if player is on the ground
            local items, len =
                self.collision_world:queryRect(transform.pos.x, transform.pos.y + collides.height, collides.width, 10)
            if len > 0 then
                print("finished jumping")
                jump.is_jumping = false
            else
                -- query to see if player has bumped their head
                local items2, len2 =
                    self.collision_world:queryRect(transform.pos.x, transform.pos.y - 5, collides.width, 5)
                if len2 > 0 then
                    transform.velocity.y = 0
                else
                    -- query to see if player has bumped to the left or right
                    local items3, len3 =
                        self.collision_world:queryRect(transform.pos.x, transform.pos.y - 5, collides.width, 5)
                    local items4, len4 =
                        self.collision_world:queryRect(transform.pos.x, transform.pos.y - 5, collides.width, 5)
                    if len3 > 0 or len4 > 0 then
                        transform.velocity.y = 0
                    end
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
