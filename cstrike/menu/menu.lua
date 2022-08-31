local menu = {
    ui.add_label(client.is_beta() and "anthrax beta for pandora" or "anthrax for pandora"),
    tabs = ui.add_dropdown("tabs", { "rage", "antiaim", "dynamic antiaim", "visuals", "misc", "config" })
}