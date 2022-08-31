
local antiaim = {
    refs = {
        state = ui.add_dropdown("antiaim state", { "stand", "run", "walk", "duck", "air", "duck + air", "phase 1", "phase 2", "phase 3" }),
    },

    vars = {
        side = false,

        phase = {
            id = 0,
            tick = 0,
            distance = 75,

            min_time = 4,
            reset_time = 0,

            active = false
        }
    },

    menu_refs = {
        yaw_additive = ui.get("Rage", "Anti-aim", "General", "Yaw additive"),
        yaw_jitter = ui.get("Rage", "Anti-aim", "General", "Yaw jitter"),
        yaw_jitter_conditions = ui.get("Rage", "Anti-aim", "General", "Yaw jitter conditions"),
        yaw_jitter_type = ui.get("Rage", "Anti-aim", "General", "Yaw jitter type"),
        yaw_jitter_range = ui.get("Rage", "Anti-aim", "General", "Yaw jitter range"),
        yaw_random_jitter = ui.get("Rage", "Anti-aim", "General", "Random jitter range"),
        yaw_random_jitter_min = ui.get("Rage", "Anti-aim", "General", "Yaw jitter range min"),
        yaw_random_jitter_max = ui.get("Rage", "Anti-aim", "General", "Yaw jitter range max"),
        body_yaw = ui.get("Rage", "Anti-aim", "General", "Fake yaw type"),
        body_yaw_direction = ui.get("Rage", "Anti-aim", "General", "Fake yaw direction"),
        body_yaw_limit = ui.get("Rage", "Anti-aim", "General", "Body yaw limit"),
        body_roll = ui.get("Rage", "Anti-aim", "General", "Body roll"),
        body_roll_amount = ui.get("Rage", "Anti-aim", "General", "Body roll amount"),
        body_roll_move_key = ui.get("Rage", "Anti-aim", "General", "Body roll move key")
    },

    states = {
        [0] = "stand",
        [1] = "run",
        [2] = "walk",
        [3] = "duck",
        [4] = "air",
        [5] = "duck + air",
        [6] = "phase 1",
        [7] = "phase 2",
        [8] = "phase 3"
    }
}

for i = 0, #antiaim.states do
	antiaim.refs[i] = { 
        left_yaw_add = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " left yaw add", -180, 180),
        right_yaw_add = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " right yaw add", -180, 180),
        yaw_jitter = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " yaw jitter", { "-", "center", "offset" }),
        yaw_jitter_value = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " jitter value", -180, 180),
        yaw_random_jitter = ui.add_checkbox("[" .. antiaim.states[i] .. "]" .. " random jitter"),
        yaw_random_jitter_min = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " random jitter min", -180, 180),
        yaw_random_jitter_max = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " random jitter max", -180, 180),
        body_yaw = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " body yaw", { "-", "jitter", "eye yaw" }),
        body_yaw_freestanding = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " body yaw freestanding", { "hotkey", "peek fake", "peek real" }),
        left_yaw_limit = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " left yaw limit", 0, 60),
        right_yaw_limit = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " right yaw limit", 0, 60),
        roll_mode = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " roll mode", { "-", "static", "jitter", "sway" }),
        roll_dynamic = ui.add_checkbox("[" .. antiaim.states[i] .. "]" .. " dynamic roll"),
        roll_value = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " roll value", -50, 50)
	}
end

antiaim.set_default_values = function()
    for i = 0, #antiaim.states do
        local ref = antiaim.refs[i]
        local state = tab and antiaim.states[menu_state] == antiaim.states[i]

        ref.left_yaw_add:set(0)
        ref.right_yaw_add:set(0)
        ref.yaw_jitter:set(0)
        ref.yaw_jitter_value:set(0)
        ref.yaw_random_jitter:set(false)
        ref.yaw_random_jitter_min:set(0)
        ref.yaw_random_jitter_max:set(0)
        ref.body_yaw:set(0)
        ref.body_yaw_freestanding:set(0)
        ref.left_yaw_limit:set(0)
        ref.right_yaw_limit:set(0)
        ref.roll_mode:set(0)
        ref.roll_dynamic:set(false)
        ref.roll_value:set(0)
    end
end

antiaim.set_default_values()

antiaim.visibility = function()
    local tab = menu.tabs:get() == 1 and true or false
    local menu_state = antiaim.refs.state:get()

    antiaim.refs.state:set_visible(tab)

    for i = 0, #antiaim.states do
        local ref = antiaim.refs[i]
        local state = tab and antiaim.states[menu_state] == antiaim.states[i]

        ref.left_yaw_add:set_visible(state)
        ref.right_yaw_add:set_visible(state)
        ref.yaw_jitter:set_visible(state)
        ref.yaw_jitter_value:set_visible(state and ref.yaw_jitter:get() > 0 and not ref.yaw_random_jitter:get())
        ref.yaw_random_jitter:set_visible(state and ref.yaw_jitter:get() > 0)
        ref.yaw_random_jitter_min:set_visible(state and ref.yaw_jitter:get() > 0 and ref.yaw_random_jitter:get())
        ref.yaw_random_jitter_max:set_visible(state and ref.yaw_jitter:get() > 0 and ref.yaw_random_jitter:get())
        ref.body_yaw:set_visible(state)
        ref.body_yaw_freestanding:set_visible(state and ref.body_yaw:get() > 0)
        ref.left_yaw_limit:set_visible(state and ref.body_yaw:get() > 0)
        ref.right_yaw_limit:set_visible(state and ref.body_yaw:get() > 0)
        ref.roll_mode:set_visible(state)
        ref.roll_dynamic:set_visible(state and ref.roll_mode:get() > 0)
        ref.roll_value:set_visible(state and ref.roll_mode:get() > 0 and not ref.roll_dynamic:get())
    end
end

antiaim.get_state = function()
    if globals._local.player == 0 then
        return
    end

    local state = -1

    if antiaim.vars.phase.id == 1 then
        state = 6

    elseif antiaim.vars.phase.id == 2 then
        state = 7

    elseif antiaim.vars.phase.id == 3 then
        state = 8

    elseif globals._local.player:ducking_inair() then
        state = 5

    elseif globals._local.player:ducking() then
        state = 3

    elseif globals._local.player:air() then
        state = 4

    elseif globals._local.player:standing() then
        state = 0

    elseif globals._local.player:slow_walking() then
        state = 2

    elseif globals._local.player:moving() then
        state = 1
    end

    return state
end

antiaim.run = function()
    if dynamic_antiaim.vars.anti_backstab.should_work or dynamic_antiaim.vars.edge_yaw.should_work then
        return
    end

    local state = antiaim.get_state()
    
    local menu_states = { "Standing", "Moving", "In air", "Walking", "Allow manual", "Allow freestanding" }
    for i = 1, #menu_states do
        antiaim.menu_refs.yaw_jitter_conditions:set(menu_states[i], true)
    end

    antiaim.menu_refs.yaw_additive:set(antiaim.vars.side == "left" and antiaim.refs[state].left_yaw_add:get() or antiaim.refs[state].right_yaw_add:get())
    antiaim.menu_refs.yaw_jitter:set(antiaim.refs[state].yaw_jitter:get() > 0)
    antiaim.menu_refs.yaw_jitter_type:set(antiaim.refs[state].yaw_jitter:get() == 1 and 2 or 0)
    antiaim.menu_refs.yaw_jitter_range:set(antiaim.refs[state].yaw_jitter_value:get())
    antiaim.menu_refs.yaw_random_jitter:set(antiaim.refs[state].yaw_random_jitter:get())

    if antiaim.refs[state].yaw_random_jitter:get() then
        antiaim.menu_refs.yaw_random_jitter_min:set(antiaim.refs[state].yaw_random_jitter_min:get())
        antiaim.menu_refs.yaw_random_jitter_max:set(antiaim.refs[state].yaw_random_jitter_max:get())
    end

    antiaim.menu_refs.body_yaw:set(antiaim.refs[state].body_yaw:get() == 1 and 1 or 0)
    antiaim.menu_refs.body_yaw_direction:set(antiaim.refs[state].body_yaw_freestanding:get())
    antiaim.menu_refs.body_yaw_limit:set(antiaim.vars.side == "left" and antiaim.refs[state].left_yaw_limit:get() or antiaim.refs[state].right_yaw_limit:get())
    antiaim.menu_refs.body_roll:set(antiaim.refs[state].roll_mode:get())
    antiaim.menu_refs.body_roll_amount:set(antiaim.refs[state].roll_value:get())

    if antiaim.refs[state].roll_dynamic:get() then
        antiaim.menu_refs.body_roll_amount:set(antiaim.vars.side == "left" and 50 or -50)
    end

    for i = 1, 8 do
        if state == i then
            antiaim.menu_refs.body_roll_move_key:set_key(antiaim.refs[state].roll_mode:get() > 0)
        end
    end
end

antiaim.run_phase = function(event)
    if antiaim.vars.phase.tick == global_vars.tickcount then
        return
    end

    local attacker = entity_list.get_client_entity(engine.get_player_for_user_id(event:get_int("userid")))
    if not attacker or attacker:is_local() or attacker:teammate() or attacker:dormant() then
        return 
    end

    local bullet_vector = vector.new(event:get_int("x"), event:get_int("y"), event:get_int("z"))
    local enemy_eye_position = attacker:eye_position()

    local closest_point = math.closest_point_on_ray(bullet_vector, enemy_eye_position, globals._local.eye_position)
    local bullet_distance = closest_point:dist_to(globals._local.eye_position)

    if bullet_distance > antiaim.vars.phase.distance then
        return
    end

    antiaim.vars.phase.tick = global_vars.tickcount
    antiaim.vars.phase.id = 1 + (antiaim.vars.phase.id % 4)

    -- after 3 misses we reset the phase 
    if antiaim.vars.phase.id == 4 then
        antiaim.vars.phase.id = 1
    end

    antiaim.vars.phase.reset_time = global_vars.realtime + antiaim.vars.phase.min_time
end

antiaim.reset_phase = function()
    if antiaim.vars.phase.reset_time < global_vars.realtime then
        antiaim.vars.phase.id = 0
        antiaim.vars.phase.active = false
        return
    end

    antiaim.vars.phase.active = true
end