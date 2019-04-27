local jump =
    Component(
    function(e, keys)
        assert(keys.jump, "missing jump key for jump component")
        Util.t.print(keys)
        e.keys = keys
        e.jump_velocity = _constants.JUMP_ACCEL
        e.fall_speed = _constants.FALL_SPEED
        e.is_jumping = false -- TODO: replace with player behaviour component FSM?
        -- e.timer = Timer.after()
    end
)

return jump
