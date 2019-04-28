local states = {
    default = {
        {duration = 1}
    },
    walk = {
        {duration = 1}
    },
    jump = {
        {duration = 1}
    },
    falling = {
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
