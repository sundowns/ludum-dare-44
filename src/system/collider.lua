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
    {_components.transform, _components.collectible, "COLLECTIBLES"},
    {_components.transform, _components.damage, "HAZARDS"}
)

function ignore_non_rigid_bodies_filter(item)
    if not item.collectible and not item.hazard then
        return true
    end
end

function only_hazards_filter(item)
    if item.hazard then
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
    elseif e:has(_components.damage) then
        local damage = e:get(_components.damage)
        self.collision_world:add(damage, position.x, position.y, damage.width, damage.height)
    end
end

function collider:entityRemoved(e)
    if e:has(_components.collides) then
        self.collision_world:remove(e:get(_components.collides))
    elseif e:has(_components.collectible) then
        self.collision_world:remove(e:get(_components.collectible))
    elseif e:has(_components.damage) then
        self.collision_world:remove(e:get(_components.damage))
    end
end

function collider:update(dt)
    for i = 1, self.PLAYER.size do
        local e = self.PLAYER:get(i)
        local transform = e:get(_components.transform)
        local collides = e:get(_components.collides)

        -- evaluate rigid collisions
        local actualX, actualY, cols, len =
            self.collision_world:move(
            collides,
            transform.pos.x,
            transform.pos.y,
            function(item, other)
                if other.collectible or other.hazard then
                    return "cross"
                else
                    return "slide"
                end
            end
        )
        transform:setPosition(Vector(actualX, actualY))

        -- check for collision with hazards
        local items, len =
            self.collision_world:queryRect(
            transform.pos.x,
            transform.pos.y,
            collides.width,
            collides.height,
            only_hazards_filter
        )

        if len > 0 then
            local damage = items[len]
            -- TODO: have the player take damage (& evaluate death)
            -- TODO: give player temp invulnerability
            self:getInstance():emit("playerTouchedHazard", damage.value)
        end
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
            for i = 1, len do
                local collision = cols[i]
                if collision.other.is_player then
                    if e:has(_components.goal) then
                        print("u win!!") -- TODO: trigger a proper victory state
                    else
                        self:getInstance():emit("upgradeHovered", collectible)
                        if love.keyboard.isDown(_constants.UPGRADE_PICKUP_KEY) then
                            self:getInstance():emit("acquireUpgrade", e)
                        end
                    end
                end
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
                0.05,
                ignore_non_rigid_bodies_filter
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
                    0.05,
                    ignore_non_rigid_bodies_filter
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
                0.05,
                ignore_non_rigid_bodies_filter
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

function collider:updateHitbox(e)
    if e:has(_components.damage) then
        -- dont care about the result, update will handle that
        local transform = e:get(_components.transform)
        self.collision_world:move(
            e:get(_components.damage),
            transform.pos.x,
            transform.pos.y,
            function(item, other)
                return "cross" -- no collision resolution thnx
            end
        )
    elseif e:has(_components.collides) then
        local transform = e:get(_components.transform)
        self.collision_world:move(
            e:get(_components.collides),
            transform.pos.x,
            transform.pos.y,
            function(item, other)
                return "cross" -- no collision resolution thnx
            end
        )
    end
end

return collider
