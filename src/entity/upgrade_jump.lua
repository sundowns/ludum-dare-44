-- x and y are world (floats)
return function(x, y)
    local upgrade_jump =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "JUMP",
        "Jump",
        1
    ):give(_components.sprite, "UPGRADE_JUMP", 0, 1, 1, 0, -5):apply()
    return upgrade_jump
end
