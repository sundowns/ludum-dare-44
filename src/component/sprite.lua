local sprite =
    Component(
    function(e, name, rot, sx, sy)
        e.name = name
        e.animation = nil
        e.sx = sx
        e.sy = sy
        e.visible = true
    end
)

function sprite:setAnimationData(animation)
    self.animation = animation
end

return sprite
