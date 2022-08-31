local on_post_move = function(cmd)
    globals.update(cmd)

    if globals._local.player ~= 0 then
        rage.dt_consistency()
        antiaim.run()
        antiaim.reset_phase()
        dynamic_antiaim.edge_yaw()
        dynamic_antiaim.teleport_inair()
        dynamic_antiaim.anti_backstab()
        misc.jump_scout() 
    end
end

callbacks.register("post_move", on_post_move)