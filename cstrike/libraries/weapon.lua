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
    revolver = 64,

    default_ct = 42,
    default_t = 59,
    bayonet = 197108,
    classic = 197111,
    flip = 197113,
    gut = 197114,
    karambit = 197115,
    m9_bayonet = 197116,
    huntsman = 197117,
    falchion = 197120,
    bowie = 197122,
    butterfly = 197123
}

function entity:is_autosniper()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.scar20 or weapon == entity_list.weapons.g3sg1 then
        return true
    end
    
    return false
end

function entity:is_pistol()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.duals or weapon == entity_list.weapons.fiveseven or
       weapon == entity_list.weapons.glock or weapon == entity_list.weapons.tec9 or
       weapon == entity_list.weapons.p2000 or weapon == entity_list.weapons.p250 or
       weapon == entity_list.weapons.usp then

        return true
    end
    
    return false
end

function entity:is_knife()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.default_ct or weapon == entity_list.weapons.default_t or
       weapon == entity_list.weapons.bayonet or weapon == entity_list.weapons.classic or
       weapon == entity_list.weapons.flip or weapon == entity_list.weapons.gut or
       weapon == entity_list.weapons.karambit or weapon == entity_list.weapons.m9_bayonet or
       weapon == entity_list.weapons.huntsman or weapon == entity_list.weapons.falchion or
       weapon == entity_list.weapons.bowie or weapon == entity_list.weapons.butterfly then

        return true
    end
    
    return false
end

function entity:is_deagle()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.deagle then
        return true
    end
    
    return false
end

function entity:is_scout()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.ssg08 then
        return true
    end
    
    return false
end

function entity:is_awp()
    local weapon = self:weapon_type()
    if weapon == entity_list.weapons.awp then
        return true
    end
    
    return false
end