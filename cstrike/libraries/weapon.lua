entity_list.weapons = {
    deagle = 1,
    duals = 2,
    fiveseven = 3,
    glock = 4,
    awp = 9,
    g3sg1 = 11,
    tec9 = 30,
    p2000 = 32,
    p250 = 36,
    scar20 = 38,
    ssg08 = 40,
    usp = 61,
    revolver = 64
}

function entity:is_autosniper()
    local weapon = globals._local.weapon_type
    if weapon == entity_list.weapons.scar20 or weapon == entity_list.weapons.g3sg1 then
        return true
    end
    
    return false
end

function entity:is_pistol()
    local weapon = globals._local.weapon_type
    if weapon == entity_list.weapons.duals or weapon == entity_list.weapons.fiveseven or
       weapon == entity_list.weapons.glock or weapon == entity_list.weapons.tec9 or
       weapon == entity_list.weapons.p2000 or weapon == entity_list.weapons.p250 or
       weapon == entity_list.weapons.usp then

        return true
    end
    
    return false
end

function entity:is_deagle()
    local weapon = globals._local.weapon_type
    if weapon == entity_list.weapons.deagle then
        return true
    end
    
    return false
end

function entity:is_scout()
    local weapon = globals._local.weapon_type
    if weapon == entity_list.weapons.ssg08 then
        return true
    end
    
    return false
end

function entity:is_awp()
    local weapon = globals._local.weapon_type
    if weapon == entity_list.weapons.awp then
        return true
    end
    
    return false
end