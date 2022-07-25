local dynamic_antiaim = {
    refs = {
        edge_yaw_label = ui.add_label("edge yaw"),
        edge_yaw_cog = ui.add_cog("edge yaw", false, true),
        teleport_inair = ui.add_checkbox("teleport in air"),
        teleport_inair_weapons = ui.add_multi_dropdown("weapons", { "scout", "awp", "deagle", "pistols" }),
        on_use = ui.add_checkbox("allow on use"),
        anti_backstab = ui.add_checkbox("anti backstab")
    },

    menu_refs = {
        fake_yaw_on_use = ui.get("Rage", "Anti-aim", "General", "Fake yaw on use"),
        doubletap = ui.get("Rage", "Exploits", "General", "Double tap key"),
        pitch = ui.get("Rage", "Anti-aim", "General", "Pitch"),
        yaw_additive = ui.get("Rage", "Anti-aim", "General", "Yaw additive")
    },

    vars = {
        anti_backstab = {
            should_work = false
        }
    }
}

dynamic_antiaim.visibility = function()
    local tab = menu.tabs:get() == 2 and true or false

    dynamic_antiaim.refs.edge_yaw_label:set_visible(tab)
    dynamic_antiaim.refs.edge_yaw_cog:set_visible(tab)
    dynamic_antiaim.refs.teleport_inair:set_visible(tab)
    dynamic_antiaim.refs.teleport_inair_weapons:set_visible(tab and dynamic_antiaim.refs.teleport_inair:get())
    dynamic_antiaim.refs.on_use:set_visible(tab)
    dynamic_antiaim.refs.anti_backstab:set_visible(tab)
end

dynamic_antiaim.on_use = function()
    dynamic_antiaim.menu_refs.fake_yaw_on_use:set(dynamic_antiaim.refs.on_use:get())
end

dynamic_antiaim.teleport_inair = function()
    if not dynamic_antiaim.refs.teleport_inair:get() then
        return
    end

    if not dynamic_antiaim.menu_refs.doubletap:get_key() then
        return
    end

    if not (dynamic_antiaim.refs.teleport_inair_weapons:get("scout") and globals._local.weapon:is_scout() or
    dynamic_antiaim.refs.teleport_inair_weapons:get("awp") and globals._local.weapon:is_awp() or
    dynamic_antiaim.refs.teleport_inair_weapons:get("deagle") and globals._local.weapon:is_deagle() or
    dynamic_antiaim.refs.teleport_inair_weapons:get("pistols") and globals._local.weapon:is_pistol()) then

        return
    end

    local target = globals.crosshair_target.entity
    if not target then
        return
    end

    if target:can_hit() and globals._local.player:air() and exploits.ready() then
        dynamic_antiaim.menu_refs.doubletap:set_key(false)
    end
end

dynamic_antiaim.anti_backstab = function()
    if not dynamic_antiaim.refs.anti_backstab:get() then
        return
    end

    local target = globals.crosshair_target.entity
    if not target then
        return
    end

    local target_weapon = target:weapon()
    if not target_weapon then
        return
    end

    local target_origin = target:origin()

    local distance = globals._local.origin:dist_to(target_origin)
    local min_distance = 200

    if target_weapon:is_knife(target_weapon) and distance <= min_distance then
        dynamic_antiaim.menu_refs.pitch:set(0)
        dynamic_antiaim.menu_refs.yaw_additive:set(180)

    else
        dynamic_antiaim.menu_refs.pitch:set(1)
        dynamic_antiaim.vars.anti_backstab.should_work = false
    end
end