local on_paint = function()
    render.update()
end

callbacks.register("paint", on_paint)