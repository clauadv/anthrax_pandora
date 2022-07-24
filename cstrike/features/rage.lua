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