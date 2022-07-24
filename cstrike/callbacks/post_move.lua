local on_post_move = function(cmd)
    globals.update(cmd)

    rage.dt_consistency()
    antiaim.run()
    dynamic_antiaim.manual()
end

callbacks.register("post_move", on_post_move)