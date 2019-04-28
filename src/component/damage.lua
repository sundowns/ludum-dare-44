local damage =
    Component(
    function(e, width, height)
        e.hazard = true -- boolean value used for collision resolution
        e.value = 1
        e.width = width
        e.height = height
    end
)

return damage
