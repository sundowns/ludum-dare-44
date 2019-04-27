local state_manager = System({_components.player_state})

function state_manager:init()
end

function state_manager:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local player_state = e:get(_components.player_state)
        player_state:update(dt)
    end
end

return state_manager
