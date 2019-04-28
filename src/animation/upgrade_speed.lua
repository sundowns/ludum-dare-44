assert(assets.powerups)
assert(anim8)

return {
    id = "UPGRADE_SPEED",
    image = assets.powerups,
    grid = anim8.newGrid(32, 32, assets.player:getWidth(), assets.player:getHeight()),
    animation_names = {
        "default"
    },
    layers = {
        {
            default = {
                frame_duration = 0.15,
                x = "1-6",
                y = 6
            }
        }
    }
}
