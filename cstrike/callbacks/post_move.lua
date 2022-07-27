local on_post_move = function(cmd)
    globals.update(cmd)

    rage.dt_consistency()
    antiaim.run()
    dynamic_antiaim.edge_yaw()
    dynamic_antiaim.teleport_inair()
    dynamic_antiaim.anti_backstab()
    misc.jump_scout()
end

callbacks.register("post_move", on_post_move)