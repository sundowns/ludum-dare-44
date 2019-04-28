local collectible =
    Component(
    function(e, type)
        assert(type, "Received collectible with no type")
        e.collectible = true
        e.type = type
    end
)

return collectible
