local stageManager = System({})

function stageManager:init()
    self.stage = nil
    self:loadStage("resource/test.lua")
end

function stageManager:loadStage(path)
    self.stage = STI(path)

    print("Loaded stage successfully")
end

function stageManager:draw()
    if self.stage then
        love.graphics.push()
        love.graphics.scale(1.25, 1.25) -- incredible hack! probably calculate this if ur a nerd
        if self.stage.layers["Background"] then
            self.stage.layers["Background"]:draw()
        end
        if self.stage.layers["World"] then
            self.stage.layers["World"]:draw()
        end
        if self.stage.layers["Foreground"] then
            self.stage.layers["Foreground"]:draw()
        end

        love.graphics.pop()
    end
end

function stageManager:update(dt)
    if self.stage then
        self.stage:update(dt)
    end
end

return stageManager
