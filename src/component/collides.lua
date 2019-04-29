local collides =
    Component(
    function(e, width, height, is_player, offset)
        e.offset = offset or Vector(0, 0)
        assert(e.offset.x and e.offset.y, "received non vector offset to collide component")
        e.width = width
        e.height = height
        e.is_player = is_player or false
    end
)

return collides
