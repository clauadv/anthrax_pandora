local on_post_move = function()
    globals.update()
end

callbacks.register("post_move", on_post_move)