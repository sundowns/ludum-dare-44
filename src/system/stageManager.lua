local stageManager = System({})

function stageManager:init()
    self.current_stage = nil
    self:loadStage("resource/stage.lua")
end

function stageManager:loadStage(path)
    self.current_stage = STI(path)

    print("Loaded stage successfully")
end

function stageManager:draw()
    if self.current_stage then
        love.graphics.push()
        -- love.graphics.translate( // TODO: this?
        --     WORLD_OFFSET.x + (self.cellWidth / self.tileWidth + 28),
        --     WORLD_OFFSET.y + (self.cellHeight / self.tileHeight + 28)
        -- ) -- fuck this & fuck u
        love.graphics.scale(self.cellWidth / self.tileWidth, self.cellHeight / self.tileHeight)
        if self.stage.layers["Foreground"] then
            self.stage.layers["Foreground"]:draw()
        end

        love.graphics.pop()
    end
end

function stageManager:update(dt)
    if self.current_stage then
        self.current_stage:update(dt)
    end
end

return stageManager
