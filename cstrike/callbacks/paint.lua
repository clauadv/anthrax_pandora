local on_paint = function()
    render.update()

    rage.visibility()
    antiaim.visibility()
    dynamic_antiaim.visibility()
    visuals.visibility()
    misc.visibility()
    config.visibility()

    dynamic_antiaim.on_use()
    visuals.removals()
    visuals.indicators()
end

callbacks.register("paint", on_paint)