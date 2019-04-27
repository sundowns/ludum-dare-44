local transform =
    Component(
    function(e, position, velocity)
        assert(position.x and position.y, "Transform component received a non-vector position on creation")
        assert(velocity.x and velocity.y, "Transform component received a non-vector velocity on creation")
        e.pos = position
        e.vel = velocity
    end
)

function transform:setPosition(position)
    assert(position.x and position.y, "Transform component received a non-vector position when setting position")
    self.pos = position
end

function transform:translate(dx, dy)
    self.pos = Vector(self.pos.x + dx, self.pos.y + dy)
end

function transform:setVelocity(velocity)
    assert(velocity.x and velocity.y, "Transform component received a non-vector velocity when setting velocity")
    self.vel = velocity
end

return transform
