
local antiaim = {
    refs = {
        state = ui.add_dropdown("antiaim state", { "stand", "run", "walk", "duck", "air", "duck + air", "brute 1", "brute 2", "brute 3" }),
    },

    menu_refs = {
        yaw_additive = ui.get("Rage", "Anti-aim", "General", "Yaw additive"),
    },

    states = {
        [0] = "stand",
        [1] = "run",
        [2] = "walk",
        [3] = "duck",
        [4] = "air",
        [5] = "duck + air",
        [6] = "brute 1",
        [7] = "brute 2",
        [8] = "brute 3"
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
        body_yaw_freestanding = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " body yaw freestanding", { "-", "peek fake", "peek real" }),
        left_yaw_limit = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " left yaw limit", 0, 60),
        right_yaw_limit = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " right yaw limit", 0, 60),
        roll_compatibility = ui.add_checkbox("[" .. antiaim.states[i] .. "]" .. " roll compatibility"),
        roll_mode = ui.add_dropdown("[" .. antiaim.states[i] .. "]" .. " roll mode", { "static", "jitter", "sway" }),
        roll_dynamic = ui.add_checkbox("[" .. antiaim.states[i] .. "]" .. " dynamic roll"),
        roll_value = ui.add_slider("[" .. antiaim.states[i] .. "]" .. " roll value", -50, 50),
	}
end

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
        ref.yaw_jitter_value:set_visible(state and not ref.yaw_random_jitter:get())
        ref.yaw_random_jitter:set_visible(state and ref.yaw_jitter:get() > 0)
        ref.yaw_random_jitter_min:set_visible(state and ref.yaw_jitter:get() > 0 and ref.yaw_random_jitter:get())
        ref.yaw_random_jitter_max:set_visible(state and ref.yaw_jitter:get() > 0 and ref.yaw_random_jitter:get())
        ref.body_yaw:set_visible(state)
        ref.body_yaw_freestanding:set_visible(state and ref.body_yaw:get() > 0)
        ref.left_yaw_limit:set_visible(state and ref.body_yaw:get() > 0)
        ref.right_yaw_limit:set_visible(state and ref.body_yaw:get() > 0)
        ref.roll_compatibility:set_visible(state)
        ref.roll_mode:set_visible(state and ref.roll_compatibility:get())
        ref.roll_dynamic:set_visible(state and ref.roll_compatibility:get())
        ref.roll_value:set_visible(state and ref.roll_compatibility:get() and not ref.roll_dynamic:get())
    end
end

antiaim.get_state = function()
    local state = -1

    if globals._local.player:ducking() then
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
    local state = antiaim.get_state()
    
    print(tostring(globals._local.player:side()))

   -- print(tostring(antiaim.refs[state].left_yaw_add:get()))
end