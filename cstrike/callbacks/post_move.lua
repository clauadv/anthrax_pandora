local on_post_move = function()
    globals.update()

    rage.dt_consistency()
    dynamic_antiaim.manual()
end

callbacks.register("post_move", on_post_move)