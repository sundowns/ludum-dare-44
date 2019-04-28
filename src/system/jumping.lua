local jumping =
    System(
    {_components.jump, _components.transform, _components.player_state, "JUMPERS"},
    {
        _components.air_control,
        _components.transform,
        _components.player_state,
        "AIR_CONTROLLED"
    }
)

function jumping:update(dt)
    for i = 1, self.JUMPERS.size do
        local e = self.JUMPERS:get(i)
        local jump = e:get(_components.jump)
        local transform = e:get(_components.transform)
        local behavior = e:get(_components.player_state).state

        if behavior.state == "jump" or behavior.state == "faling" then
            jump.jump_duration = jump.jump_duration + dt
        end

        if love.keyboard.isDown(jump.keys.jump) and (behavior.state == "default" or behavior.state == "walk") then
            transform.pos.y = transform.pos.y - 5

            jump:jump()
            behavior:setState("jump")

            local walk = e:get(_components.walk)
            if walk then
                walk.x_velocity = 0
            end
        elseif
            jump.can_double_jump and (behavior.state == "falling" or behavior.state == "jump") and
                not jump.has_double_jumped and
                love.keyboard.isDown(jump.keys.jump)
         then
            if
                behavior.state == "falling" or
                    (behavior.state == "jump" and jump.jump_duration > jump.minimum_jump_duration_for_double_jump)
             then
                jump:double_jump()
                behavior:setState("jump")
            end
        end

        if behavior.state == "jump" then
            jump:decay(dt)
            if jump.velocity < jump.falling_trigger_velocity then
                behavior:setState("falling")
            end

            transform.pos.y = transform.pos.y - jump.velocity * dt
        end
    end

    for i = 1, self.AIR_CONTROLLED.size do
        local e = self.AIR_CONTROLLED:get(i)
        local behavior = e:get(_components.player_state).state
        local air_control = e:get(_components.air_control)

        if behavior.state == "jump" or behavior.state == "falling" then
            local transform = e:get(_components.transform)
            if love.keyboard.isDown(air_control.keys.left) and not love.keyboard.isDown(air_control.keys.right) then
                transform.pos.x = transform.pos.x - air_control.speed * dt
            end
            if love.keyboard.isDown(air_control.keys.right) and not love.keyboard.isDown(air_control.keys.left) then
                transform.pos.x = transform.pos.x + air_control.speed * dt
            end
        end
    end
end

function jumping:player_idling()
    for i = 1, self.JUMPERS.size do
        local e = self.JUMPERS:get(i)
        e:get(_components.jump):reset()
    end
end

return jumping
