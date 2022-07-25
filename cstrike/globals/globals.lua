local globals = {
    _local = {
        player = 0,
        weapon = 0,
        weapon_type = 0,
        velocity = vector.new(0, 0, 0),
        origin = vector.new(0, 0, 0),
        eye_position = vector.new(0, 0, 0),
        view_angles = vector.new(0, 0, 0)
    },

    crosshair_target = 0,
    cmd = 0
}

globals.update = function(cmd)
    globals._local.player = entity_list.get_local_player()
    globals._local.weapon = globals._local.player:weapon()
    globals._local.weapon_type = globals._local.player:weapon_type()
    globals._local.velocity = globals._local.player:velocity()
    globals._local.origin = globals._local.player:origin()
    globals._local.eye_position = globals._local.player:eye_position()
    globals._local.view_angles = engine.get_view_angles()
    globals.crosshair_target = entity_list.get_crosshair_target()
    globals.cmd = cmd
end