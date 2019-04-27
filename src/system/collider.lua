local collider = System({_components.collides, _components.transform})

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

return collider
