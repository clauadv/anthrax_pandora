local visuals = {
    refs = {
        removals = ui.add_multi_dropdown("removals", { "fading chams", "thirdperson animation" }),
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

    visuals.refs.removals:set_visible(tab)
    visuals.refs.indicators:set_visible(tab)
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