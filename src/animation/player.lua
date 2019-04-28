assert(assets.player)
assert(anim8)

return {
    id = "PLAYER",
    image = assets.player,
    grid = anim8.newGrid(32, 32, assets.player:getWidth(), assets.player:getHeight()),
    animation_names = {
        "default",
        "fall",
        "walk",
        "jump"
    },
    layers = {
        {
            default = {
                frame_duration = 1000,
                x = 1,
                y = 2
            },
            walk = {
                frame_duration = 0.10,
                x = "1-6",
                y = 1
            },
            run = {
                frame_duration = 0.10,
                x = "1-6",
                y = 3
            },
            fall = {
                frame_duration = 0.15,
                x = 4,
                y = 4
            },
            jump = {
                frame_duration = 0.095,
                x = "1-6",
                y = 4
            }
        }
    }
}
