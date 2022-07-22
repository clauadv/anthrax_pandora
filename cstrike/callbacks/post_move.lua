local on_post_move = function()
    globals.update()

    local crosshair_target = entity_list.get_crosshair_target()
    local player_info = engine.get_player_info(crosshair_target.index)
    print(tostring(player_info.name))
end

callbacks.register("post_move", on_post_move)