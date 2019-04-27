local stage_manager = System()

function stage_manager:init()
    self.stage = nil
end

function stage_manager:stageLoaded(path)
    self.stage = STI(path)

    assert(self.stage.layers["World"], "stage_manager loaded a stage with no 'World' layer.")

    local collidable_tile_data = self:readTileLayerData(self.stage.layers["World"])

    for y, row in ipairs(collidable_tile_data.tiles) do
        for x, cell in pairs(row) do
            -- Subtract 1 to index at 0
            self:getInstance():addEntity(_entities.tile(x - 1, y - 1))
        end
    end

    self:getInstance():addEntity(_entities.player(1, 15))
end

function stage_manager:draw()
    if self.stage then
        love.graphics.push()
        love.graphics.scale(_constants.FORBIDDEN_HACK_RATIO, _constants.FORBIDDEN_HACK_RATIO)
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

function stage_manager:update(dt)
    if self.stage then
        self.stage:update(dt)
    end
end

function stage_manager:readTileLayerData(layer)
    assert(layer.data)
    return {
        cols = layer.width,
        rows = layer.height,
        tile_width = _constants.CELL_WIDTH,
        tile_height = _constants.CELL_HEIGHT,
        tiles = layer.data
    }
end

return stage_manager
