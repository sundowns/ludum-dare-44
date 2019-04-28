local DIRECTIONS = {
    ["left"] = "LEFT",
    ["right"] = "RIGHT"
}

local direction =
    Component(
    function(e)
        e.value = DIRECTIONS.right
    end
)

function direction:set(new)
    assert(DIRECTIONS[string.lower(new)], "attempted to change to non-existing direction")
    self.value = DIRECTIONS[string.lower(new)]
end

return direction
