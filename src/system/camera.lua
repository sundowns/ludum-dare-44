local camera = System({_components.camera, _components.transform})

function camera:init()
    self.camera = Camera(0, camera_height)
    self.camera:zoomTo(2.0)
    self.timer = Timer.new()
    self.is_shaking = false
    self.jitter = 0
end

function camera:attach()
    self.camera:attach()
end

function camera:detach()
    self.camera:detach()
end

function camera:update(dt)
    self.timer:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local transform = e:get(_components.transform)
        local camera_height = transform.pos.y - 20

        if self.is_shaking then
            -- + math.random(-jitter, jitter)
            self.camera:lookAt(
                transform.pos.x + math.random(-self.jitter, self.jitter),
                camera_height + math.random(-self.jitter, self.jitter)
            )
        else
            self.camera:lookAt(transform.pos.x, camera_height)
        end
    end
end

function camera:shake(duration, jitter)
    assert(duration > 0)

    self.is_shaking = true
    self.jitter = jitter or 2
    self.timer:after(
        duration,
        function()
            self.is_shaking = false
        end
    )
end

return camera
