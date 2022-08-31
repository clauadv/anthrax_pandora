local on_bullet_impact = function(event)
    if globals._local.player == 0 then
        return
    end

    antiaim.run_phase(event)
end

callbacks.register("bullet_impact", on_bullet_impact)