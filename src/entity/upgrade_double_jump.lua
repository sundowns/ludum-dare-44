-- x and y are world (floats)
return function(x, y)
    local upgrade_double_jump =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "DOUBLE_JUMP",
        "Double Jump",
        3
    ):apply()
    return upgrade_double_jump
end
