local misc = {
    refs = {
        animations = ui.add_multi_dropdown("animations", { "static legs in-air", "sliding legs", "pitch on land" })
    }
}

misc.visibility = function()
    local tab = menu.tabs:get() == 4 and true or false

    misc.refs.animations:set_visible(tab)
end