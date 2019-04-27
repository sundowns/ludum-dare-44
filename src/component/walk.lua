local MAX_VELOCITY = 100

local walk =
    Component(
    function(e, keys)
        assert(keys.right, "missing right key for run component")
        assert(keys.left, "missing left key for run component")
        e.keys = keys
        e.x_velocity = 0
        e.walk_speed = _constants.WALK_SPEED
        e.friction = _constants.FRICTION
    end
)

function walk:move(modifier)
    self.x_velocity = self.walk_speed * modifier
end

function walk:applyFriction(dt)
    if self.x_velocity > 0 then
        self.x_velocity = self.x_velocity - (self.friction * dt)
    elseif self.x_velocity < 0 then
        self.x_velocity = self.x_velocity + (self.friction * dt)
    end

    if math.abs(self.x_velocity) < 5 then
        self.x_velocity = 0
    end
end

return walk
