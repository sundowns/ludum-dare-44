-- x and y are world coords (floats)
return function(x, y)
    local moving_hazard =
        Entity():give(_components.transform, Vector(x, y + _constants.CELL_HEIGHT / 2), Vector(0, 0)):give(
        _components.damage,
        _constants.CELL_WIDTH,
        _constants.CELL_HEIGHT / 2
    ):give(_components.sprite, "SPIKES", 0, 1, 1, 0, -_constants.CELL_HEIGHT / 2):give(_components.patrolling):apply()
    return moving_hazard
end
