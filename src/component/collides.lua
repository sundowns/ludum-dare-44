local collides =
    Component(
    function(e, width, height, is_player)
        e.width = width
        e.height = height
        e.is_player = is_player or false
    end
)

return collides
