local on_post_anim_update = function()
    misc.animations()

    if globals._local.player ~= 0 then
        antiaim.vars.side = globals._local.player:side()
    end
end

callbacks.register("post_anim_update", on_post_anim_update)