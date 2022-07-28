local on_bullet_impact = function(event)
    antiaim.run_phase(event)
end

callbacks.register("bullet_impact", on_bullet_impact)