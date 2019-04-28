local sprite =
    Component(
    function(e, name, rot, sx, sy, offset_x, offset_y)
        e.name = name
        e.animation = nil
        e.sx = sx or 1
        e.sy = sy or 1
        e.offset_x = offset_x or 0
        e.offset_y = offset_y or 0
        e.visible = true
    end
)

function sprite:setAnimationData(animation)
    self.animation = animation
end

return sprite
