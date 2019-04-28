local jump =
    Component(
    function(e, keys, double_jump)
        assert(keys.jump, "missing jump key for jump component")
        e.keys = keys
        e.velocity = 0
        e.base_jump_velocity = _constants.JUMP_ACCEL
        e.base_jump_decay = _constants.JUMP_DECAY
        e.falling_trigger_velocity = 230 -- value tweaked to fit when extra fall speed should kick in
        e.jump_decay = e.base_jump_decay
        e.bump_head_decay_multiplier = _constants.JUMP_BUMP_HEAD_DECAY_MODIFIER
        e.fall_speed_modifier = 2
        e.can_double_jump = double_jump or false
        e.has_double_jumped = false
        e.jump_duration = 0 --used to track when double jump is allowed
        e.minimum_jump_duration_for_double_jump = 0.4
    end
)

function jump:jump()
    self.velocity = self.base_jump_velocity
    self.jump_decay = self.base_jump_decay
end

function jump:double_jump()
    self.velocity = self.base_jump_velocity
    self.has_double_jumped = true
end

function jump:reset()
    self.has_double_jumped = false
    self.jump_duration = 0
end

function jump:decay(dt)
    local fall_speed_modifier = 1
    if self.velocity < self.falling_trigger_velocity then
        fall_speed_modifier = self.fall_speed_modifier
    end

    self.velocity = self.velocity - _constants.JUMP_DECAY * fall_speed_modifier * dt
end

function jump:bump_head()
    self.velocity = self.velocity - 5
    self.jump_decay = self.jump_decay * self.bump_head_decay_multiplier
end

return jump
