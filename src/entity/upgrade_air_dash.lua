-- x and y are world (floats)
return function(x, y)
    local upgrade_air_dash =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "AIR_DASH",
        "Air Dash",
        _constants.COST_AIR_DASH
    ):give(_components.sprite, "UPGRADE_AIR_DASH", 0, 1, 1, 0, -8):give(_components.levitating):apply()
    return upgrade_air_dash
end
