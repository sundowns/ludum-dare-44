assert(assets.tileset)
assert(anim8)

return {
    id = "BRICK",
    image = assets.tileset,
    grid = anim8.newGrid(32, 32, assets.tileset:getWidth(), assets.tileset:getHeight()),
    animation_names = {
        "default"
    },
    layers = {
        {
            default = {
                frame_duration = 1000,
                x = 2,
                y = 1
            }
        }
    }
}
