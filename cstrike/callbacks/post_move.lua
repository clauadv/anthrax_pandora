local on_post_move = function(cmd)
    globals.update(cmd)

    rage.dt_consistency()
    antiaim.run()
    dynamic_antiaim.teleport_inair()
    dynamic_antiaim.anti_backstab()
end

callbacks.register("post_move", on_post_move)