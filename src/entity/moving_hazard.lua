-- x and y are world coords (floats)
-- distance is a single cell ()
return function(x, y, direction, distance, patrol_speed)
    local moving_hazard =
        Entity():give(_components.transform, Vector(x, y + _constants.CELL_HEIGHT / 2), Vector(0, 0)):give(
        _components.damage,
        _constants.CELL_WIDTH,
        _constants.CELL_HEIGHT / 2
    ):give(_components.sprite, "SPIKES", 0, 1, 1, 0, -_constants.CELL_HEIGHT / 2)

    -- special calcs for patrolling things direction

    local destination = nil

    if direction == "UP" then
        destination = Vector(x, y + _constants.CELL_HEIGHT / 2 - _constants.CELL_HEIGHT * distance)
    elseif direction == "RIGHT" then
        destination = Vector(x + _constants.CELL_WIDTH * distance, y + _constants.CELL_HEIGHT / 2)
    elseif direction == "LEFT" then
        destination = Vector(x - _constants.CELL_WIDTH * distance, y + _constants.CELL_HEIGHT / 2)
    elseif direction == "DOWN" then
        destination = Vector(x, y + _constants.CELL_HEIGHT / 2 + _constants.CELL_HEIGHT * distance)
    else
        assert(false, "Moving hazard received invalid direction: " .. direction)
    end

    moving_hazard:give(_components.patrolling, Vector(x, y + _constants.CELL_HEIGHT / 2), destination, patrol_speed)

    moving_hazard:apply()
    return moving_hazard
end
