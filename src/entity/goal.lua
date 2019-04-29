-- x and y are world (floats)
return function(x, y)
    local goal =
        Entity():give(_components.transform, Vector(x, y), Vector(0, 0)):give(
        _components.collectible,
        "GOAL",
        "Goal",
        0
    ):give(_components.goal):give(_components.sprite, "GOAL", 0, 1, 1, 0, 0):apply()
    return goal
end
