assert(assets.powerups)
assert(anim8)

return {
    id = "UPGRADE_AIR_DASH",
    image = assets.powerups,
    grid = anim8.newGrid(32, 32, assets.powerups:getWidth(), assets.powerups:getHeight()),
    animation_names = {
        "default"
    },
    layers = {
        {
            default = {
                frame_duration = 0.15,
                x = "1-6",
                y = 4
            }
        }
    }
}
