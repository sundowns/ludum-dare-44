-- x and y are world coords (floats)
-- distance is a single cell ()
return function(x, y, direction, distance, patrol_speed)
    local moving_tile =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.sprite,
        "BRICK",
        0,
        1,
        1,
        0,
        0
    ):give(_components.collides, _constants.CELL_WIDTH, _constants.CELL_HEIGHT)

    -- special calcs for patrolling things direction
    local destination = nil
    if direction == "UP" then
        destination = Vector(x, y - _constants.CELL_HEIGHT * distance)
    elseif direction == "RIGHT" then
        destination = Vector(x + _constants.CELL_WIDTH * distance, y)
    elseif direction == "LEFT" then
        destination = Vector(x - _constants.CELL_WIDTH * distance, y)
    elseif direction == "DOWN" then
        destination = Vector(x, y + _constants.CELL_HEIGHT * distance)
    else
        assert(false, "Moving tile received invalid direction: " .. direction)
    end

    moving_tile:give(_components.patrolling, Vector(x, y), destination, patrol_speed)

    moving_tile:apply()
    return moving_tile
end
