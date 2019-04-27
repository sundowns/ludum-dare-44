-- x and y are grid coordinates
return function(x, y)
    local player =
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
    ):give(
        _components.walk,
        {
            left = "a",
            right = "d"
        }
    ):give(
        _components.jump,
        {
            jump = "space"
        }
    ):give(
        _components.air_control,
        {
            left = "a",
            right = "d"
        }
    ):give(_components.gravity, _constants.GRAVITY):give(_components.camera):give(_components.player_state):apply()
    return player
end
