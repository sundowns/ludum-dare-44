local air_dash =
    Component(
    function(e, keys)
        assert(keys.dash, "missing dash key from airdash")
        e.keys = keys
        e.has_air_dashed = false
        e.velocity = 200
        e.duration = 0.35
        e.timer = Timer.new()
    end
)

function air_dash:activate()
    self.has_air_dashed = true
end

function air_dash:update(dt)
    self.timer:update(dt)
end

function air_dash:reset()
    self.has_air_dashed = false
end

return air_dash
