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
                y = 2,
                offset_x = 0,
                offset_y = 0,
                scale_x = 1,
                scale_y = 1,
                rotation = 0
            },
            walk = {
                frame_duration = 0.15,
                x = "1-6",
                y = 1,
                offset_x = 0,
                offset_y = 0,
                scale_x = 1,
                scale_y = 1,
                rotation = 0
            },
            run = {
                frame_duration = 0.15,
                x = "1-6",
                y = 3,
                offset_x = 0,
                offset_y = 0,
                scale_x = 1,
                scale_y = 1,
                rotation = 0
            },
            fall = {
                -- SAME AS DEFAULT ATM
                frame_duration = 1000,
                x = 1,
                y = 2,
                offset_x = 0,
                offset_y = 0,
                scale_x = 1,
                scale_y = 1,
                rotation = 0
            },
            jump = {
                -- SAME AS DEFAULT ATM
                frame_duration = 1000,
                x = 1,
                y = 2,
                offset_x = 0,
                offset_y = 0,
                scale_x = 1,
                scale_y = 1,
                rotation = 0
            }
        }
    }
}
