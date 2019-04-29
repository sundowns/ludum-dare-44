local MOVING_TARGETS = {
    ["origin"] = "ORIGIN",
    ["destination"] = "DESTINATION"
}

local patrolling =
    Component(
    function(e, origin, destination, speed)
        assert(origin.x and origin.y, "Received a non-vector origin for patrol component")
        assert(origin.x and origin.y, "Received a non-vector origin for patrol component")
        e.origin = origin
        e.destination = destination
        e.moving_to = MOVING_TARGETS.destination
        e.speed = speed or 1
    end
)

function patrolling:target(target)
    assert(MOVING_TARGETS[string.lower(target)])
    self.moving_to = MOVING_TARGETS[string.lower(target)]
end

return patrolling
