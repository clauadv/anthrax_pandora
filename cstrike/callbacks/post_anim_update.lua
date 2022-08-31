local on_post_anim_update = function()
    if globals._local.player == 0 then
        return
    end

    antiaim.vars.side = globals._local.player:side()

    misc.animations()
end

callbacks.register("post_anim_update", on_post_anim_update)