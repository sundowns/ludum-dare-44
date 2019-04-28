-- x and y are grid coordinates
return function(x, y)
    local player =
        Entity():give(
        _components.transform,
        Vector(x * _constants.CELL_WIDTH, y * _constants.CELL_HEIGHT),
        Vector(0, 0)
    ):give(_components.collides, _constants.PLAYER_WIDTH, _constants.PLAYER_HEIGHT):give(
        _components.walk,
        {
            left = "a",
            right = "d"
        }
    ):give(
        _components.air_control,
        {
            left = "a",
            right = "d"
        }
    ):give(_components.gravity, _constants.GRAVITY):give(_components.camera):give(
        _components.health,
        _constants.HEALTH_BASE
    ):give(_components.player_state):give(
        _components.sprite,
        "PLAYER",
        0,
        1,
        1,
        0,
        -(_constants.CELL_HEIGHT - _constants.PLAYER_HEIGHT)
    ):apply()
    return player
end
