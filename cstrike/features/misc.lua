local misc = {
    refs = {
        animations = ui.add_multi_dropdown("animations", { "static legs in-air", "sliding legs", "pitch on land" }),
        jump_scout = ui.add_checkbox("jump scout")
    },

    vars = {
        animations = {
            ground_ticks = 0,
            end_time = 0
        }
    }
}

misc.visibility = function()
    local tab = menu.tabs:get() == 4 and true or false

    misc.refs.animations:set_visible(tab)
    misc.refs.jump_scout:set_visible(tab)
end

misc.animations = function()
    if globals._local.player == 0 then
        return
    end

    local pose_paramter = globals._local.player:get_prop("DT_BaseAnimating", "m_flPoseParameter")

    if misc.refs.animations:get("static legs in-air") then
        pose_paramter:set_float_index(6, 1)
    end

    if misc.refs.animations:get("sliding legs") then
        pose_paramter:set_float_index(0, 1)
        ui.get("Misc", "General", "Movement", "Leg movement"):set(2)
    end

    if misc.refs.animations:get("pitch on land") then
        local on_ground = bit.band(globals._local.player:get_prop("DT_BasePlayer", "m_fFlags"):get_int(), 1)
        if on_ground == 1 then
            misc.vars.animations.ground_ticks = misc.vars.animations.ground_ticks + 1
        else
            misc.vars.animations.ground_ticks = 0
            misc.vars.animations.end_time = global_vars.curtime + 1
        end 
        
        if misc.vars.animations.ground_ticks > 2 and misc.vars.animations.end_time > global_vars.curtime then
            pose_paramter:set_float_index(12, 0.45)
        end
    end
end

misc.jump_scout = function()
    if not misc.refs.jump_scout:get() then
        return
    end

    local velocity = globals._local.player:velocity_speed()
    ui.get("Misc", "General", "Movement", "Auto strafe"):set(velocity > 5)
end