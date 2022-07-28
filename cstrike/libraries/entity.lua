function entity:health()
    return self:get_prop("DT_BasePlayer", "m_iHealth"):get_int()
end

function entity:armor()
    return self:get_prop("DT_CSPlayer", "m_ArmorValue"):get_int()
end

function entity:velocity()
    return self:get_prop("DT_BasePlayer", "m_vecVelocity[0]"):get_vector()
end

function entity:velocity_speed()
    local velocity = self:get_prop("DT_BasePlayer", "m_vecVelocity[0]"):get_vector()
    return math.round(math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y))
end

function entity:move_type()
    return self:get_prop("DT_BaseEntity", "m_nRenderMode"):get_int()
end

function entity:alive()
    return self:health() > 0
end

function entity:weapon()
    return entity_list.get_client_entity(self:get_prop("DT_BaseCombatCharacter", "m_hActiveWeapon"))
end

function entity:weapon_type()
    return self:get_prop("DT_BaseAttributableItem", "m_iItemDefinitionIndex"):get_int()
end

function entity:team()
    return self:get_prop("DT_BaseEntity", "m_iTeamNum"):get_int()
end

function entity:teammate()    
    return self:team() == globals._local.player:team()
end

function entity:enemy()
    return self:team() ~= globals._local.player:team()
end

function entity:scoped()
    return self:get_prop("DT_CSPlayer", "m_bIsScoped"):get_int() == 1
end

function entity:tick_base()
    return self:get_prop("DT_BasePlayer", "m_nTickBase"):get_int() == 1
end

function entity:is_local()
    return self:index() == globals._local.player:index()
end

function entity:name()
    return engine.get_player_info(self:index()).name
end

function entity:extrapolate(ticks)
    local head = self:hitbox_position(entity_list.hitboxes.head)
    local velocity = self:velocity()

    return vector.new(
        head.x + velocity.x * global_vars.interval_per_tick * ticks,
        head.y + velocity.y * global_vars.interval_per_tick * ticks,
        head.z + velocity.z * global_vars.interval_per_tick * ticks
    )
end

function entity:standing()
    if not (self:slow_walking() and self:air()) and self:velocity_speed() <= 4 then
        return true
    end

    return false
end

function entity:moving()
    if not (self:slow_walking() and self:air()) and self:velocity_speed() >= 4 then
        return true
    end

    return false
end

function entity:ducking()
    if globals.cmd:has_flag(4) and not self:air() then
        return true
    end

    return false
end

function entity:ducking_inair()
    if globals.cmd:has_flag(4) and self:air() then
        return true
    end

    return false
end

function entity:air()
    return self:get_prop("DT_BasePlayer", "m_hGroundEntity"):get_int() == -1
end

function entity:slow_walking()
    return ui.get("Misc", "General", "Movement", "Slow motion key"):get_key()
end

function entity:side()
    local pose_paramter = self:get_prop("DT_BaseAnimating", "m_flPoseParameter")
    local body_yaw = pose_paramter:get_float_index(11) * 120 - 60

    return body_yaw > 0 and "left" or "right"
end

function entity:can_hit()
    local trace = penetration.simulate_bullet(self, self:eye_position(), globals._local.player:hitbox_position(entity_list.hitboxes.body))
    if trace.damage > 0 then
        return true
    end

    return false
end

entity_list.hitboxes = {
    head = 0,
    neck = 1,
    pelvis = 2,
    body = 3,
    thorax = 4,
    chest = 5,
    upper_chest = 6,
    left_thigh = 7,
    right_thigh = 8,
    left_calf = 9,
    right_calf = 10,
    left_foot = 11,
    right_foot = 12
}

function entity_list:get_local_player()
    return entity_list.get_client_entity(engine.get_local_player())
end

function entity_list.get_players()
    local _players = {}

    local players = entity_list.get_all("CCSPlayer")
    for i = 1, #players do
        local player = entity_list.get_client_entity(players[i])

        if player:alive() and not player:dormant() and not player:is_local() then
            table.insert(_players, players[i])
        end
    end

    return _players
end

function entity_list.get_enemies()
    local enemies = {}

    local players = entity_list.get_all("CCSPlayer")
    for i = 1, #players do
        local player = entity_list.get_client_entity(players[i])

        if player:alive() and not player:dormant() and not player:teammate() and not player:is_local() then
            table.insert(enemies, players[i])
        end
    end

    return enemies
end

function entity_list.get_crosshair_target()
    local data = {
        index = nil,
        entity = nil,
        fov = 180
    }
    
    local enemies = entity_list.get_enemies()
    for i = 1, #enemies do
        local enemy = entity_list.get_client_entity(enemies[i])
        
        local head_position = enemy:hitbox_position(0)
        local fov = math.fov_to(globals._local.eye_position, head_position, globals._local.view_angles)

        if fov < data.fov then
            data.index = enemies[i]
            data.entity = enemy
            data.fov = fov
        end
    end

    return {
        index = data.index,
        entity = data.entity
    }
end