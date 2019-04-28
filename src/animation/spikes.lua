assert(assets.spikes)
assert(anim8)

return {
    id = "SPIKES",
    image = assets.spikes,
    grid = anim8.newGrid(32, 32, assets.spikes:getWidth(), assets.spikes:getHeight()),
    animation_names = {
        "default"
    },
    layers = {
        {
            default = {
                frame_duration = 1000,
                x = 1,
                y = 1
            }
        }
    }
}
