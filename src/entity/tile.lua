-- x and y are grid indices (integers)
return function(x, y)
    local tile =
        Entity():give(
        _components.transform,
        Vector(
            x * _constants.CELL_WIDTH * _constants.FORBIDDEN_HACK_RATIO,
            y * _constants.CELL_HEIGHT * _constants.FORBIDDEN_HACK_RATIO
        ),
        Vector(0, 0)
    ):give(
        _components.collides,
        _constants.CELL_WIDTH * _constants.FORBIDDEN_HACK_RATIO,
        _constants.CELL_HEIGHT * _constants.FORBIDDEN_HACK_RATIO
    ):apply()
    return tile
end
