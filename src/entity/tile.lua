-- x and y are grid indices (integers)
return function(x, y)
    local tile =
        Entity():give(_components.transform, Vector(x * _constants.CELL_WIDTH, y * _constants.CELL_HEIGHT)):give(
        _components.collides,
        _constants.CELL_WIDTH,
        _constants.CELL_HEIGHT
    ):apply()
    return tile
end
