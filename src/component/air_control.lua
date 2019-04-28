local air_control =
    Component(
    function(e, keys, modifier)
        if not modifier then
            modifier = 1
        end
        e.keys = keys
        e.speed = _constants.AIR_CONTROL_SPEED * modifier
    end
)

return air_control
