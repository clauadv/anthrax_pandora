local dynamic_antiaim = {
    refs = {
        edge_yaw_label = ui.add_label("edge yaw"),
        edge_yaw_cog = ui.add_cog("edge yaw", false, true),
        teleport_inair = ui.add_checkbox("teleport in air"),
        on_use = ui.add_checkbox("allow on use"),
        anti_backstab = ui.add_checkbox("anti backstab"),
        manual_antiaim = ui.add_checkbox("manual antiaim"),
        manual_roll_compatibility = ui.add_checkbox("manual roll compatibility"),
        manual_left_label = ui.add_label("manual left"),
        manual_left_cog = ui.add_cog("manual left", false, true),
        manual_right_label = ui.add_label("manual right"),
        manual_right_cog = ui.add_cog("manual right", false, true)
    }
}

dynamic_antiaim.visibility = function()
    local tab = menu.tabs:get() == 2 and true or false

    dynamic_antiaim.refs.edge_yaw_label:set_visible(tab)
    dynamic_antiaim.refs.edge_yaw_cog:set_visible(tab)
    dynamic_antiaim.refs.teleport_inair:set_visible(tab)
    dynamic_antiaim.refs.on_use:set_visible(tab)
    dynamic_antiaim.refs.anti_backstab:set_visible(tab)
    dynamic_antiaim.refs.manual_antiaim:set_visible(tab)
    dynamic_antiaim.refs.manual_roll_compatibility:set_visible(tab and dynamic_antiaim.refs.manual_antiaim:get())
    dynamic_antiaim.refs.manual_left_label:set_visible(tab and dynamic_antiaim.refs.manual_antiaim:get())
    dynamic_antiaim.refs.manual_left_cog:set_visible(tab and dynamic_antiaim.refs.manual_antiaim:get())
    dynamic_antiaim.refs.manual_right_label:set_visible(tab and dynamic_antiaim.refs.manual_antiaim:get())
    dynamic_antiaim.refs.manual_right_cog:set_visible(tab and dynamic_antiaim.refs.manual_antiaim:get())
end