local rage = {
    refs = {
        dt_consistency = ui.add_checkbox("doubletap consistency"),
        dt_consistency_cog = ui.add_cog("will force your minimum damage to your target's hp / 2 + 1", false, false),
        dt_consistency_options = ui.add_multi_dropdown("weapons", { "autosnipers", "deagle", "pistols" })
    }
}

rage.visibility = function()
    local tab = menu.tabs:get() == 0 and true or false

    rage.refs.dt_consistency:set_visible(tab)
    rage.refs.dt_consistency_cog:set_visible(tab and rage.refs.dt_consistency:get())
    rage.refs.dt_consistency_options:set_visible(tab and rage.refs.dt_consistency:get())
end

rage.dt_consistency = function()
    if not rage.refs.dt_consistency:get() then
        return
    end

    if not (rage.refs.dt_consistency_options:get("autosnipers") and globals._local.weapon:is_autosniper() or
            rage.refs.dt_consistency_options:get("deagle") and globals._local.weapon:is_deagle() or
            rage.refs.dt_consistency_options:get("pistols") and globals._local.weapon:is_pistol()) then

        return
    end

    local target = globals.crosshair_target.entity
    if not target then
        return
    end

    local health = target:health()
    local damage = math.round(health / 2 + 1)
    local min_damage = ui.get_rage("General", "Minimum damage")

    -- body
    local body = target:hitbox_position(entity_list.hitboxes.body)
    local body_trace = penetration.simulate_bullet(globals._local.player, globals._local.eye_position, body)
    if body_trace.damage * 2 > health and exploits.ready() then
        min_damage:set(damage)
    end

    -- body extrapolated
    local body_ex_trace = penetration.simulate_bullet(globals._local.player, globals._local.player:extrapolate(20), body)
    if body_ex_trace.damage * 2 > health and exploits.ready() then
        min_damage:set(damage)
    end
end