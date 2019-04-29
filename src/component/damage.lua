local damage =
    Component(
    function(e, width, height, offset)
        e.hazard = true -- boolean value used for collision resolution
        e.value = 1
        e.width = width
        e.height = height
        e.offset = offset or Vector(0, 0)
        assert(e.offset.x and e.offset.y, "received non vector offset to damage component")
    end
)

return damage
