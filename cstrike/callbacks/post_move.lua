local on_post_move = function()
    globals.update()

    rage.dt_consistency()
end

callbacks.register("post_move", on_post_move)