local states = {
    default = {
        {
            duration = 1,
            action = function()
                _instances.world:emit("player_idling")
            end
        }
    },
    walk = {
        {
            duration = 1
        }
    },
    jump = {
        {duration = 1}
    },
    fall = {
        {duration = 1}
    }
}

local player_state =
    Component(
    function(e)
        e.state = Behavior(states)
    end
)

function player_state:update(dt)
    self.state:update(dt)
end

return player_state
