local stage_manager = System()

function stage_manager:init()
    self.stage = nil
end

function stage_manager:stageLoaded(path)
    self.stage = STI(path)

    assert(self.stage.layers["World"], "stage_manager loaded a stage with no 'World' layer.")

    -- Add tiles to collision world
    local collidable_tile_data = self:readTileLayerData(self.stage.layers["World"])
    for y, row in ipairs(collidable_tile_data.tiles) do
        for x, cell in pairs(row) do
            -- Subtract 1 to index at 0
            self:getInstance():addEntity(_entities.tile(x - 1, y - 1))
        end
    end

    if self.stage.layers["Collectibles"] then
        local collidables = self:readObjectLayerData(self.stage.layers["Collectibles"])

        for i, object in ipairs(collidables) do
            if object.type == "Jump" then
                self:getInstance():addEntity(_entities.upgrade_jump(object.x, object.y))
            elseif object.type == "Speed" then
                self:getInstance():addEntity(_entities.upgrade_speed(object.x, object.y))
            end
        end
    end

    self:getInstance():addEntity(_entities.player(2, 18))
end

function stage_manager:draw()
    if self.stage then
        if self.stage.layers["Background"] then
            self.stage.layers["Background"]:draw()
        end
        if self.stage.layers["World"] then
            self.stage.layers["World"]:draw()
        end
        if self.stage.layers["Foreground"] then
            self.stage.layers["Foreground"]:draw()
        end
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

function stage_manager:readObjectLayerData(objectLayer)
    assert(objectLayer.objects)

    local objects = {}

    for i, object in pairs(objectLayer.objects) do
        assert(object.type)
        table.insert(
            objects,
            {
                type = object.type,
                x = object.x,
                y = object.y - 1 * _constants.CELL_HEIGHT
            }
        )
    end
    return objects
end

return stage_manager
