local on_post_anim_update = function()
    misc.animations()
end

callbacks.register("post_anim_update", on_post_anim_update)