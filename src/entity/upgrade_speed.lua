-- x and y are world (floats)
return function(x, y)
    local upgrade_speed =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "SPEED",
        "Speed Boost",
        3
    ):give(_components.sprite, "UPGRADE_SPEED", 0, 1, 1, 0, -8):give(_components.levitating):apply()
    return upgrade_speed
end
