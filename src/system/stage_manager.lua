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
            elseif object.type == "Double Jump" then
                self:getInstance():addEntity(_entities.upgrade_double_jump(object.x, object.y))
            elseif object.type == "Goal" then
                self:getInstance():addEntity(_entities.goal(object.x, object.y))
            elseif object.type == "Hazard" then
                self:getInstance():addEntity(_entities.hazard(object.x, object.y))
            elseif object.type == "Moving Hazard" then
                assert(object.properties, "moving hazard missing properties definition")
                assert(object.properties.distance, "moving hazard missing distance property")
                assert(object.properties.direction, "moving hazard missing direction property")
                assert(object.properties.speed, "moving hazard missing direction speed")

                self:getInstance():addEntity(
                    _entities.moving_hazard(
                        object.x,
                        object.y,
                        object.properties.direction,
                        object.properties.distance,
                        object.properties.speed
                    )
                )
            elseif object.type == "Moving Tile" then
                assert(object.properties, "moving tile missing properties definition")
                assert(object.properties.distance, "moving tile missing distance property")
                assert(object.properties.direction, "moving tile missing direction property")
                assert(object.properties.speed, "moving tile missing direction speed")

                self:getInstance():addEntity(
                    _entities.moving_tile(
                        object.x,
                        object.y,
                        object.properties.direction,
                        object.properties.distance,
                        object.properties.speed
                    )
                )
            elseif object.type == "Spawn" then
                self:getInstance():addEntity(_entities.player(object.x, object.y))
            elseif object.type == "Heart" then
                self:getInstance():addEntity(_entities.heart(object.x, object.y))
            end
        end
    end
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
                y = object.y - 1 * _constants.CELL_HEIGHT,
                properties = object.properties or {}
            }
        )
    end
    return objects
end

return stage_manager
