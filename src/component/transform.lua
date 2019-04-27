local transform =
    Component(
    function(e, position)
        assert(position.x and position.y, "Transform component received a non-vector position on creation")
        e.pos = position
    end
)

function transform:setPosition(position)
    assert(position.x and position.y, "Transform component received a non-vector position when setting position")
    self.pos = position
end

function transform:translate(dx, dy)
    self.pos = Vector(self.pos.x + dx, self.pos.y + dy)
end

return transform
