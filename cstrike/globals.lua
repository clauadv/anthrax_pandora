local globals = {
    _local = {
        player = 0,
        weapon = 0,
        weapon_type = 0,
        origin = vector.new(0, 0, 0),
        velocity = vector.new(0, 0, 0),
        eye_position = vector.new(0, 0, 0)
    }
}

globals.update = function()
    globals._local.player = entity_list.get_client_entity(engine.get_local_player())
    globals._local.weapon = entity_list.get_client_entity(globals._local.player:get_prop("DT_BaseCombatCharacter", "m_hActiveWeapon"))
    globals._local.weapon_type = globals._local.weapon:get_prop("DT_BaseAttributableItem", "m_iItemDefinitionIndex"):get_int()
    globals._local.origin = globals._local.player:origin()
    globals._local.velocity = vector.new(0, 0, 0) -- to add
    globals._local.eye_position = globals._local.player:eye_position()

    print("player -> " .. tostring(globals._local.player))
    print("weapon -> " .. tostring(globals._local.weapon))
    print("weapon_type -> " .. tostring(globals._local.weapon_type))
    print("origin -> " .. tostring(globals._local.origin.x) .. ", " .. tostring(globals._local.origin.y) .. ", " .. tostring(globals._local.origin.z))
    print("velocity -> " .. tostring(globals._local.velocity.x) .. ", " .. tostring(globals._local.velocity.y) .. ", " .. tostring(globals._local.velocity.z))
    print("eye_position -> " .. tostring(globals._local.eye_position.x) .. ", " .. tostring(globals._local.eye_position.y) .. ", " .. tostring(globals._local.eye_position.z) .. "\n")
end