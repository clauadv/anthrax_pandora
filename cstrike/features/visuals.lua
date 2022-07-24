local visuals = {
    refs = {
        disable_fading_chams = ui.add_checkbox("disable fading chams"),
        indicators = ui.add_multi_dropdown("indicators", { "default", "arrows" }),
        indicators_label = ui.add_label("indicators color"),
        indicators_color = ui.add_cog("indicators color", true, false),
        manual_arrows_label = ui.add_label("manual arrows color"),
        manual_arrows_color = ui.add_cog("manual arrows color", true, false),
        desync_arrows_label = ui.add_label("desync arrows color"),
        desync_arrows_color = ui.add_cog("desync arrows color", true, false)
    }
}

visuals.visibility = function()
    local tab = menu.tabs:get() == 3 and true or false

    visuals.refs.disable_fading_chams:set_visible(tab)
    visuals.refs.indicators:set_visible(tab)
    visuals.refs.indicators_label:set_visible(tab and visuals.refs.indicators:get("default"))
    visuals.refs.indicators_color:set_visible(tab and visuals.refs.indicators:get("default"))
    visuals.refs.manual_arrows_label:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.manual_arrows_color:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.desync_arrows_label:set_visible(tab and visuals.refs.indicators:get("arrows"))
    visuals.refs.desync_arrows_color:set_visible(tab and visuals.refs.indicators:get("arrows"))
end