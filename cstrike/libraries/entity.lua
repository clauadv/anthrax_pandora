function entity:health()
    return self:get_prop("DT_BasePlayer", "m_iHealth"):get_int()
end

function entity:armor()
    return self:get_prop("DT_CSPlayer", "m_ArmorValue"):get_int()
end

function entity:velocity()
    local velocity = self:get_prop("DT_BasePlayer", "m_vecVelocity[0]"):get_vector()
    return math.sqrt(velocity.x * velocity.x + velocity.y * velocity.y)
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
    return self:weapon():get_prop("DT_BaseAttributableItem", "m_iItemDefinitionIndex"):get_int()
end

function entity:team()
    return self:get_prop("DT_BaseEntity", "m_iTeamNum"):get_int()
end

function entity:teammate()    
    return self:team() == globals._local.player:team()
end

function entity:scoped()
    return self:get_prop("DT_CSPlayer", "m_bIsScoped"):get_int() == 1
end

function entity:tick_base()
    return self:get_prop("DT_BasePlayer", "m_nTickBase"):get_int() == 1
end

function entity:is_local()
    return self == globals._local.player
end

entity_list.weapons = {
    deagle = 1,
    duals = 2,
    fiveseven = 3,
    glock = 4,
    awp = 9,
    g3sg1 = 11,
    tect9 = 30,
    p2000 = 32,
    p250 = 36,
    scar20 = 38,
    ssg08 = 40,
    revolver = 64,
    usp = 262205
}

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