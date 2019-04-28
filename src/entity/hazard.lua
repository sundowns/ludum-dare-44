-- x and y are world coords (floats)
return function(x, y)
    local hazard =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.damage,
        _constants.CELL_WIDTH,
        _constants.CELL_HEIGHT
    ):apply()
    return hazard
end
