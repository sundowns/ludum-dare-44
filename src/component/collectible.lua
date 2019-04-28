local collectible =
    Component(
    function(e, type, friendly_name)
        assert(type, "Received collectible with no type")
        assert(type, "Received collectible with no friendly_name")
        e.collectible = true
        e.type = type
        e.friendly_name = love.graphics.newText(_fonts.COLLECTIBLES, "Press [E] to acquire " .. friendly_name)
    end
)

return collectible
