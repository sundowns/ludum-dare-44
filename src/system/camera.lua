local camera = System({_components.camera, _components.transform})

function camera:init()
    self.camera = Camera(0, camera_height)
    self.camera:zoomTo(1.5)
end

function camera:attach()
    self.camera:attach()
end

function camera:detach()
    self.camera:detach()
end

function camera:update(dt)
    for i = 1, self.pool.size do
        local e = self.pool:get(i)
        local transform = e:get(_components.transform)
        self.camera:lookAt(transform.pos.x, transform.pos.y - 20)
    end
end

return camera
