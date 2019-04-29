-- x and y are world (floats)
return function(x, y)
    local heart =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "HEART",
        "Heart",
        0
    ):give(_components.sprite, "HEART", 0, 1, 1, 8, 8):give(_components.levitating):apply()
    return heart
end
