local on_paint = function()
    render.update()

    rage.visibility()
    antiaim.visibility()
    dynamic_antiaim.visibility()
    visuals.visibility()
    misc.visibility()
    config.visibility()

    if globals._local.player ~= 0 then
        dynamic_antiaim.on_use()
        dynamic_antiaim.roll_manual()
        visuals.removals()
    end

    visuals.default_indicators()
end

callbacks.register("paint", on_paint)