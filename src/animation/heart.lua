assert(assets.tileset)
assert(anim8)

return {
    id = "HEART",
    image = assets.tileset,
    grid = anim8.newGrid(16, 16, assets.tileset:getWidth(), assets.tileset:getHeight()),
    animation_names = {
        "default"
    },
    layers = {
        {
            default = {
                frame_duration = 1000,
                x = 3,
                y = 6
            }
        }
    }
}
