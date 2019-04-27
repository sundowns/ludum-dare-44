local jump =
    Component(
    function(e, keys)
        assert(keys.jump, "missing jump key for jump component")
        e.keys = keys
        e.velocity = 0
        e.base_jump_velocity = _constants.JUMP_ACCEL
        e.base_jump_decay = _constants.JUMP_DECAY
        e.jump_decay = e.base_jump_decay
        e.bump_head_decay_multiplier = _constants.JUMP_BUMP_HEAD_DECAY_MODIFIER
    end
)

function jump:jump()
    self.velocity = self.base_jump_velocity
    self.jump_decay = self.base_jump_decay
end

function jump:decay(dt)
    self.velocity = self.velocity - _constants.JUMP_DECAY * dt
end

function jump:bump_head()
    self.velocity = self.velocity - 5
    self.jump_decay = self.jump_decay * self.bump_head_decay_multiplier
end

return jump
