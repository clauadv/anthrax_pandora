local visuals = {
    refs = {
        disable_fading_chams = ui.add_checkbox("disable fading chams"),
        indicators = ui.add_multi_dropdown("indicators", { "default", "arrows" }),
        indicators_label = ui.add_label("indicators color"),
        indicators_color = ui.add_cog("indicators color", true, false),
        arrows_label = ui.add_label("arrows color"),
        arrows_color = ui.add_cog("arrows color", true, false)
    }
}

visuals.visibility = function()
    local tab = menu.tabs:get() == 3 and true or false

    visuals.refs.disable_fading_chams:set_visible(tab)
    visuals.refs.indicators:set_visible(tab)
    visuals.refs.indicators_label:set_visible(tab)
    visuals.refs.indicators_color:set_visible(tab)
    visuals.refs.arrows_label:set_visible(tab)
    visuals.refs.arrows_color:set_visible(tab)
end