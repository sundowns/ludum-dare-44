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
        -- love.graphics.translate( // TODO: this?
        --     WORLD_OFFSET.x + (self.cellWidth / self.tileWidth + 28),
        --     WORLD_OFFSET.y + (self.cellHeight / self.tileHeight + 28)
        -- ) -- fuck this & fuck u
        love.graphics.scale(
            _constants.CELL_WIDTH / _constants.TILE_WIDTH,
            _constants.CELL_HEIGHT / _constants.TILE_HEIGHT
        )
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
