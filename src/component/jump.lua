local jump =
    Component(
    function(e, keys)
        assert(keys.jump, "missing jump key for jump component")
        e.keys = keys
        e.jump_velocity = _constants.JUMP_ACCEL
        e.is_jumping = false -- TODO: replace with player behaviour component FSM?
        e.timer = nil
        e.jump_time = _constants.JUMP_TWEEN_TIME
    end
)

function jump:jump()
    self.is_jumping = true
end

return jump
