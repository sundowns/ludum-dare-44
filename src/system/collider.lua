local collider =
    System(
    {_components.collides, _components.transform, "ALL"},
    {_components.collides, _components.player_state, _components.transform, "PLAYER"},
    {
        _components.collides,
        _components.transform,
        _components.jump,
        _components.player_state,
        "JUMPER"
    },
    {_components.transform, _components.collectible, "COLLECTIBLES"}
)

function ignore_collectables_filter(item)
    if not item.collectible then
        return true
    end
end

function collider:init()
    self.collision_world = Bump.newWorld()
end

function collider:entityAdded(e)
    local position = e:get(_components.transform).pos
    if e:has(_components.collides) then
        local collides = e:get(_components.collides)
        self.collision_world:add(collides, position.x, position.y, collides.width, collides.height)
    elseif e:has(_components.collectible) then
        self.collision_world:add(
            e:get(_components.collectible),
            position.x + _constants.CELL_WIDTH * 0.2,
            position.y + _constants.CELL_HEIGHT * 0.2,
            _constants.CELL_WIDTH * 0.6,
            _constants.CELL_HEIGHT * 0.6
        )
    end
end

function collider:entityRemoved(e)
    if e:has(_components.collides) then
        self.collision_world:remove(e:get(_components.collides))
    elseif e:has(_components.collectible) then
        self.collision_world:remove(e:get(_components.collectible))
    end
end

function collider:update(dt)
    for i = 1, self.PLAYER.size do
        local e = self.PLAYER:get(i)
        local transform = e:get(_components.transform)
        local collides = e:get(_components.collides)

        local actualX, actualY, cols, len =
            self.collision_world:move(
            collides,
            transform.pos.x,
            transform.pos.y,
            function(item, other)
                if other.collectible then
                    return "cross"
                else
                    return "slide"
                end
            end
        )
        transform:setPosition(Vector(actualX, actualY))
    end

    for i = 1, self.COLLECTIBLES.size do
        local e = self.COLLECTIBLES:get(i)
        local transform = e:get(_components.transform)
        local collectible = e:get(_components.collectible)
        local actualX, actualY, cols, len =
            self.collision_world:check(
            collectible,
            transform.pos.x,
            transform.pos.y,
            function(item, other)
                return "cross"
            end
        )
        if len > 0 then
            self:getInstance():emit("upgradeHovered", collectible)
            if love.keyboard.isDown(_constants.UPGRADE_PICKUP_KEY) then
                self:getInstance():emit("acquireUpgrade", e)
            end
        end
    end

    for i = 1, self.JUMPER.size do
        local e = self.JUMPER:get(i)
        local jump = e:get(_components.jump)
        local transform = e:get(_components.transform)
        local collides = e:get(_components.collides)
        local state = e:get(_components.player_state).state
        if state.state == "jump" or state.state == "fall" then
            -- query to see if player is on the ground
            local items, len =
                self.collision_world:queryRect(
                transform.pos.x + collides.width * 0.035,
                transform.pos.y + collides.height,
                collides.width * 0.93,
                0.5,
                ignore_collectables_filter
            )
            if len > 0 then
                state:setState("default")
                _instances.world:emit("spriteStateUpdated", e, "default")
            else
                -- query to see if player has bumped their head
                local items2, len2 =
                    self.collision_world:queryRect(
                    transform.pos.x + collides.width * 0.2,
                    transform.pos.y - 5,
                    collides.width * 0.6,
                    1,
                    ignore_collectables_filter
                )
                if len2 > 0 then
                    jump:bump_head()
                end
            end
        elseif state.state == "walk" or state.state == "default" then
            -- query to see if player is on the ground
            local items, len =
                self.collision_world:queryRect(
                transform.pos.x + collides.width * 0.035,
                transform.pos.y + collides.height,
                collides.width * 0.93,
                0.5,
                ignore_collectables_filter
            )
            if len == 0 then
                state:setState("fall")
                _instances.world:emit("spriteStateUpdated", e, "fall")
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

return collider
