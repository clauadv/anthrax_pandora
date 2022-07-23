local on_paint = function()
    render.update()

    visuals.visibility()
    misc.visibility()
    loop()
end

callbacks.register("paint", on_paint)