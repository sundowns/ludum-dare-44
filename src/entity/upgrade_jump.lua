-- x and y are world (floats)
return function(x, y)
    local upgrade_jump =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "JUMP",
        "Jump",
        1
    ):apply()
    return upgrade_jump
end
