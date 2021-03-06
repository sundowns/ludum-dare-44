-- x and y are world coords (floats)
return function(x, y)
    local hazard =
        Entity():give(_components.transform, Vector(x, y + _constants.CELL_HEIGHT * 2 / 3), Vector(0, 0)):give(
        _components.damage,
        _constants.SPIKE_WIDTH,
        _constants.SPIKE_HEIGHT,
        Vector(3, 0)
    ):give(_components.sprite, "SPIKES", 0, 1, 1, 0, -_constants.CELL_HEIGHT * 2 / 3):apply()
    return hazard
end
