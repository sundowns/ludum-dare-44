-- x and y are grid indices (integers)
return function(x, y)
    local hazard =
        Entity():give(
        _components.transform,
        Vector(x * _constants.CELL_WIDTH, y * _constants.CELL_HEIGHT),
        Vector(0, 0)
    ):give(_components.damage):apply()
    return hazard
end
