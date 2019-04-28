local collectible =
    Component(
    function(e, type, friendly_name, health_cost)
        assert(type, "Received collectible with no type")
        assert(type, "Received collectible with no friendly_name")
        e.collectible = true
        e.type = type
        e.health_cost = health_cost or 0
        e.friendly_name = love.graphics.newText(_fonts.COLLECTIBLES, "Press [E] to acquire " .. friendly_name)
    end
)

return collectible
