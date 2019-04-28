local health =
    Component(
    function(e, base)
        e.current = base
        e.max = base
    end
)

function health:reduce(delta)
    self.current = self.current - delta
end

return health
