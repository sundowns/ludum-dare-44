-- x and y are world coordinates (float)
return function(x, y)
    local player =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collides,
        _constants.PLAYER_WIDTH,
        _constants.PLAYER_HEIGHT,
        true,
        Vector(5, 0) -- offset relative to transform
    ):give(
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
    ):give(_components.direction):apply()
    return player
end
