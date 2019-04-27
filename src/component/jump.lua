local jump =
    Component(
    function(e, keys)
        assert(keys.jump, "missing jump key for jump component")
        Util.t.print(keys)
        e.keys = keys
        e.jump_velocity = _constants.JUMP_ACCEL
        e.is_jumping = false -- TODO: replace with player behaviour component FSM?
    end
)

return jump
