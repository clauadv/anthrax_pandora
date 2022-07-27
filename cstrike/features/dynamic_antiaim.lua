local dynamic_antiaim = {
    refs = {
        edge_yaw_label = ui.add_label("edge yaw"),
        edge_yaw_cog = ui.add_cog("edge yaw", false, true),
        teleport_inair = ui.add_checkbox("teleport in air"),
        teleport_inair_weapons = ui.add_multi_dropdown("weapons", { "scout", "awp", "deagle", "pistols" }),
        on_use = ui.add_checkbox("allow on use"),
        anti_backstab = ui.add_checkbox("anti backstab"),
        roll_manual = ui.add_checkbox("manual direction roll")
    },

    menu_refs = {
        fake_yaw_on_use = ui.get("Rage", "Anti-aim", "General", "Fake yaw on use"),
        doubletap = ui.get("Rage", "Exploits", "General", "Double tap key"),
        pitch = ui.get("Rage", "Anti-aim", "General", "Pitch"),
        yaw_additive = ui.get("Rage", "Anti-aim", "General", "Yaw additive"),
        manual_left = ui.get("Rage", "Anti-aim", "General", "Manual left key"),
        manual_right = ui.get("Rage", "Anti-aim", "General", "Manual right key"),
        inverter = ui.get("Rage", "Anti-aim", "General", "Anti-aim invert")
    },

    vars = {
        anti_backstab = {
            should_work = false
        },

        edge_yaw = {
            condition = 0,
            edging = false,
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
    dynamic_antiaim.refs.roll_manual:set_visible(tab)
end

dynamic_antiaim.edge_yaw = function()
    if not dynamic_antiaim.refs.edge_yaw_cog:get_key() then
        return
    end

    local local_eye = globals._local.eye_position
    local view_angle = globals._local.view_angles.y

    local freestanding = function()
        local data = {
            distance = 35,
            point = nil
        }

        dynamic_antiaim.vars.edge_yaw.edging = false
        for i = view_angle - 180, view_angle + 90, 180 / 16 do
            if i == view_angle then
                break
            end

            local radians = i * math.pi / 180
            local eye_position = vector.new(
                local_eye.x + 256 * math.cos(radians), 
                local_eye.y + 256 * math.sin(radians), 
                local_eye.z
            )

            local trace = engine_trace.trace_ray(local_eye, eye_position, globals._local.player, 0x4600400B)
            if trace.fraction * 256 < data.distance then
                data.distance = trace.fraction * 256
                data.point = vector.new(
                    local_eye.x + 256 * trace.fraction * math.cos(radians), 
                    local_eye.y + 256 * trace.fraction * math.sin(radians), 
                    local_eye.z
                )

                dynamic_antiaim.vars.edge_yaw.edging = true
            end
        end

        dynamic_antiaim.vars.edge_yaw.point = data.point
    end

    local get_angle = function()
        if not dynamic_antiaim.vars.edge_yaw.point then
            return 0
        end

        local point = vector.new(
            dynamic_antiaim.vars.edge_yaw.point.x - local_eye.x, 
            dynamic_antiaim.vars.edge_yaw.point.y - local_eye.y, 
            dynamic_antiaim.vars.edge_yaw.point.z - local_eye.z
        )

        local point_tangent = math.atan2(point.y, point.x) * 180 / math.pi;
        local normalized_view_angle = math.normalize(view_angle - 180);

        return math.normalize(point_tangent - normalized_view_angle)
    end

    freestanding()

    if dynamic_antiaim.vars.edge_yaw.edging then
        dynamic_antiaim.menu_refs.yaw_additive:set(get_angle())
        dynamic_antiaim.vars.edge_yaw.should_work = true

    else
        dynamic_antiaim.vars.edge_yaw.should_work = false
    end
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
        exploits.force_uncharge()
    end
end

dynamic_antiaim.on_use = function()
    dynamic_antiaim.menu_refs.fake_yaw_on_use:set(dynamic_antiaim.refs.on_use:get())
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
        dynamic_antiaim.vars.anti_backstab.should_work = true

    else
        dynamic_antiaim.menu_refs.pitch:set(1)
        dynamic_antiaim.vars.anti_backstab.should_work = false
    end
end

dynamic_antiaim.roll_manual = function()
    if not dynamic_antiaim.refs.roll_manual:get() then
        return
    end

    if dynamic_antiaim.menu_refs.manual_left:get_key() or dynamic_antiaim.menu_refs.manual_right:get_key() then
        dynamic_antiaim.menu_refs.inverter:set_key(true)
    end
end