local visuals = {
    refs = {
        removals = ui.add_multi_dropdown("removals", { "fading chams", "thirdperson animation" }),
        indicators = ui.add_multi_dropdown("indicators", { "default", "arrows" }),
        indicators_directional = ui.add_checkbox("directional indicators"),
        indicators_label = ui.add_label("indicators color"),
        indicators_color = ui.add_cog("indicators color", true, false),
        manual_arrows_label = ui.add_label("manual arrows color"),
        manual_arrows_color = ui.add_cog("manual arrows color", true, false),
        desync_arrows_label = ui.add_label("desync arrows color"),
        desync_arrows_color = ui.add_cog("desync arrows color", true, false)
    },

    menu_refs = {
        exploits_enabled = ui.get("Rage", "Exploits", "General", "Enabled"),
        hide_shots_key = ui.get("Rage", "Exploits", "General", "Hide shots key"),
        double_tap_key = ui.get("Rage", "Exploits", "General", "Double tap key"),
        force_body_aim = ui.get_rage("Accuracy", "Force body-aim"),
        force_body_aim_key = ui.get_rage("Accuracy", "Force body-aim key"),
        force_safety = ui.get_rage("General", "Force safety key"),
        freestanding_key = ui.get("Rage", "Anti-aim", "General", "Freestanding key")
    }
}

visuals.visibility = function()
    local tab = menu.tabs:get() == 3 and true or false

    visuals.refs.removals:set_visible(tab)
    visuals.refs.indicators:set_visible(tab)
    visuals.refs.indicators_directional:set_visible(tab and visuals.refs.indicators:get("default"))
    visuals.refs.indicators_label:set_visible(tab and visuals.refs.indicators:get("default"))
    visuals.refs.indicators_color:set_visible(tab and visuals.refs.indicators:get("default"))
    visuals.refs.manual_arrows_label:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.manual_arrows_color:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.desync_arrows_label:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.desync_arrows_color:set_visible(tab and visuals.refs.indicators:get("arrows"))
end

visuals.removals = function()
    if visuals.refs.removals:get("fading chams") then
        esp.set_fading_chams(not visuals.refs.removals:get("fading chams"))
    end

    if visuals.refs.removals:get("thirdperson animation") then
        -- bug: if u set animation on false and then on true again, the animation is still disabled
        esp.set_thirdperson_animation(not visuals.refs.removals:get("thirdperson animation"))
    end
end

local animation = {data = {}}

animation.lerp = function(start, end_pos, time)
    return (end_pos - start) * (global_vars.frametime * time * 175) + start
end

animation.new = function(name, value, time)
    if animation.data[name] == nil then
        animation.data[name] = value
    end

    animation.data[name] = animation.lerp(animation.data[name], value, time)

    return animation.data[name]
end

visuals.default_indicators = function()
    if not (engine.is_connected() and engine.in_game()) then
        return
    end

    if not client.is_alive() then
        return
    end

    local indicators = {}

    local state = antiaim.states[antiaim.get_state()]
    local color = visuals.refs.indicators_color:get_color()
    local pulse = math.sin(math.abs(-math.pi + (global_vars.curtime * (1 / .75)) % (math.pi * 2))) * 255

    local should_display = false
    local inlined_spacing = 0

    local direction = 0
    if visuals.refs.indicators_directional:get() then
        direction = input.key_down(0x41) == true and -30 or input.key_down(0x44) == true and 30 or 0
    end

    -- local _animation = animation.new("animation_", globals._local.player:scoped() and direction or 0, 0.02)
    local _animation = animation.new("animation_", 0, 0.02)

    table.insert(indicators, { name = "ANTHRAX", color = client.is_beta() and color.new(color:r(), color:g(), color:b(), pulse) or color })
    table.insert(indicators, { name = string.upper(state), color = color })

    if (visuals.menu_refs.exploits_enabled:get() and visuals.menu_refs.double_tap_key:get_key()) then
        table.insert(indicators, { name = "DT", color = exploits.ready() and color or color.new(255, 0, 0) })
        should_display = true

    elseif (visuals.menu_refs.exploits_enabled:get() and visuals.menu_refs.hide_shots_key:get_key()) then
        table.insert(indicators, { name = "HS", color = exploits.ready() and color or color.new(255, 0, 0) })
        should_display = true
    end

    table.insert(indicators, { 
        name = "BAIM", 
        color = (visuals.menu_refs.force_body_aim:get() and visuals.menu_refs.force_body_aim_key:get_key()) and color.new(255, 255, 255) or color.new(255, 255, 255, 50), 
        inlined = true 
    })

    table.insert(indicators, { 
        name = "SAFE", 
        color = visuals.menu_refs.force_safety:get_key() and color or color.new(255, 255, 255, 50), 
        inlined = true 
    })

    table.insert(indicators, { 
        name = "FS", 
        color = visuals.menu_refs.freestanding_key:get_key() and color or color.new(255, 255, 255, 50), 
        inlined = true 
    })

    for i = 1, #indicators do
        local bind = indicators[i]

        local text_size_x, text_size_y = render.fonts.small_fonts:get_size(bind.name)

        if bind.inlined then
            if should_display then
                render.fonts.small_fonts:text(render.center_screen.w - 25 + (20 * inlined_spacing) + _animation, render.center_screen.h + 32, bind.color, bind.name)
                
            else
                render.fonts.small_fonts:text(render.center_screen.w - 24 + (20 * inlined_spacing) + _animation, render.center_screen.h + 24, bind.color, bind.name)
            end

            inlined_spacing = inlined_spacing + 1

        else
            render.fonts.small_fonts:text(render.center_screen.w - (text_size_x / 2) + _animation, render.center_screen.h + (8 * i), bind.color, bind.name)
        end
    end
end

visuals.indicators = function()
end