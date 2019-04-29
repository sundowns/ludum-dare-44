local air_dash = System({_components.player_state, _components.air_dash, _components.direction, _components.transform})

function air_dash:init()
end

function air_dash:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local air_dash = e:get(_components.air_dash)
        air_dash:update(dt)
        if air_dash.has_air_dashed then
            break
        end

        local behavior = e:get(_components.player_state).state
        local transform = e:get(_components.transform)
        local direction = e:get(_components.direction)
        if love.keyboard.isDown(air_dash.keys.dash) and (behavior.state == "jump" or behavior.state == "fall") then
            air_dash:activate()
            if direction.value == "LEFT" then
                transform.velocity.x = transform.velocity.x - air_dash.velocity
                air_dash.timer:after(
                    air_dash.duration,
                    function()
                        transform.velocity.x = transform.velocity.x + air_dash.velocity
                    end
                )
            elseif direction.value == "RIGHT" then
                transform.velocity.x = transform.velocity.x + air_dash.velocity
                air_dash.timer:after(
                    air_dash.duration,
                    function()
                        transform.velocity.x = transform.velocity.x - air_dash.velocity
                    end
                )
            end
        end
    end
end

return air_dash
