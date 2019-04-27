local transform =
    Component(
    function(e, pos)
        assert(pos.x and pos.y, "Transform component received a non-vector position")
        e.pos = pos
    end
)

function transform:translate(dx, dy)
    self.pos.x = self.pos.x + dx
    self.pox.y = self.pos.y + dy
end

return transform
