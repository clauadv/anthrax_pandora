local config = {    
    refs = {
        list = ui.add_dropdown("config list", {}),
        save = ui.add_button("save"),
        load = ui.add_button("load"),
        reload = ui.add_button("reload")
    },

    array = {}
}

config.visibility = function()
    local tab = menu.tabs:get() == 5 and true or false

    config.refs.list:set_visible(tab)
    config.refs.save:set_visible(tab)
    config.refs.load:set_visible(tab)
    config.refs.reload:set_visible(tab)
end

config.export = function()
    local str = ""

    str = str

    -- rage tab
    .. tostring(rage.refs.dt_consistency:get()) .. "|"
    .. tostring(rage.refs.dt_consistency_options:get("autosnipers")) .. "|"
    .. tostring(rage.refs.dt_consistency_options:get("deagle")) .. "|"
    .. tostring(rage.refs.dt_consistency_options:get("pistols")) .. "|"

    -- antiaim tab
    .. tostring(antiaim.refs.state:get()) .. "|"

    local antiaim_str = ""
    for i = 0, #antiaim.states do
        local ref = antiaim.refs[i]

        antiaim_str = antiaim_str

        .. tostring(ref.left_yaw_add:get()) .. "|"
        .. tostring(ref.right_yaw_add:get()) .. "|"
        .. tostring(ref.yaw_jitter:get()) .. "|"
        .. tostring(ref.yaw_jitter_value:get()) .. "|"
        .. tostring(ref.yaw_random_jitter:get()) .. "|"
        .. tostring(ref.yaw_random_jitter_min:get()) .. "|"
        .. tostring(ref.yaw_random_jitter_max:get()) .. "|"
        .. tostring(ref.body_yaw:get()) .. "|"
        .. tostring(ref.body_yaw_freestanding:get()) .. "|"
        .. tostring(ref.left_yaw_limit:get()) .. "|"
        .. tostring(ref.right_yaw_limit:get()) .. "|"
        .. tostring(ref.roll_mode:get()) .. "|"
        .. tostring(ref.roll_dynamic:get()) .. "|"
        .. tostring(ref.roll_value:get()) .. "|"
    end

    str = str .. antiaim_str

    --[[

    -- dynamic antiaim tab
    .. tostring(dynamic_antiaim.refs.edge_yaw_cog:get_key()) .. "|"
    .. tostring(dynamic_antiaim.refs.teleport_inair:get()) .. "|"
    .. tostring(dynamic_antiaim.refs.on_use:get()) .. "|"
    .. tostring(dynamic_antiaim.refs.anti_backstab:get()) .. "|"
    .. tostring(dynamic_antiaim.refs.manual:get()) .. "|"
    .. tostring(dynamic_antiaim.refs.manual_left_cog:get_key()) .. "|"
    .. tostring(dynamic_antiaim.refs.manual_right_cog:get_key()) .. "|"

    -- visuals tab
    .. tostring(visuals.refs.removals:get("fading chams")) .. "|"
    .. tostring(visuals.refs.removals:get("thirdperson animation")) .. "|"
    .. tostring(visuals.refs.indicators_color:get_color():r()) .. "|"
    .. tostring(visuals.refs.indicators_color:get_color():g()) .. "|"
    .. tostring(visuals.refs.indicators_color:get_color():b()) .. "|"
    .. tostring(visuals.refs.indicators_color:get_color():a()) .. "|"
    .. tostring(visuals.refs.manual_arrows_color:get_color():r()) .. "|"
    .. tostring(visuals.refs.manual_arrows_color:get_color():g()) .. "|"
    .. tostring(visuals.refs.manual_arrows_color:get_color():b()) .. "|"
    .. tostring(visuals.refs.manual_arrows_color:get_color():a()) .. "|"
    .. tostring(visuals.refs.desync_arrows_color:get_color():r()) .. "|"
    .. tostring(visuals.refs.desync_arrows_color:get_color():g()) .. "|"
    .. tostring(visuals.refs.desync_arrows_color:get_color():b()) .. "|"
    .. tostring(visuals.refs.desync_arrows_color:get_color():a()) .. "|"

    -- misc tab
    .. tostring(misc.refs.animations:get("static legs in-air")) .. "|"
    .. tostring(misc.refs.animations:get("sliding legs")) .. "|"
    .. tostring(misc.refs.animations:get("pitch on land")) .. "|"

    --]]

    return str
end

config.import = function(input)
    local str = utils:str_to_sub(input, "|")

    -- rage tab
    rage.refs.dt_consistency:set(utils:to_boolean(str[1]))
    rage.refs.dt_consistency_options:set("autosnipers", utils:to_boolean(str[2]))
    rage.refs.dt_consistency_options:set("deagle", utils:to_boolean(str[3]))
    rage.refs.dt_consistency_options:set("pistols", utils:to_boolean(str[4]))

    -- antiaim tab
    antiaim.refs.state:set(tonumber(str[5]))

    --[[
        run -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        walk -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        duck -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        air -> -63|63|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        duck + air -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        brute 1 -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        brute 2 -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
        brute 3 -> -180|-180|0|-180|false|-180|-180|0|0|0|0|false|0|false|-50|
    ]]

    -- stand
    antiaim.refs[0].left_yaw_add:set(tonumber(str[6]))
    antiaim.refs[0].right_yaw_add:set(tonumber(str[7]))
    antiaim.refs[0].yaw_jitter:set(tonumber(str[8]))
    antiaim.refs[0].yaw_jitter_value:set(tonumber(str[9]))
    antiaim.refs[0].yaw_random_jitter:set(utils:to_boolean(str[10]))
    antiaim.refs[0].yaw_random_jitter_min:set(tonumber(str[11]))
    antiaim.refs[0].yaw_random_jitter_max:set(tonumber(str[12]))
    antiaim.refs[0].body_yaw:set(tonumber(str[13]))
    antiaim.refs[0].body_yaw_freestanding:set(tonumber(str[14]))
    antiaim.refs[0].left_yaw_limit:set(tonumber(str[15]))
    antiaim.refs[0].right_yaw_limit:set(tonumber(str[16]))
    antiaim.refs[0].roll_mode:set(tonumber(str[17]))
    antiaim.refs[0].roll_dynamic:set(utils:to_boolean(str[18]))
    antiaim.refs[0].roll_value:set(tonumber(str[19]))

    print("imported successfully")
end

local _http = http.new({ task_interval = 0.3, enable_debug = false, timeout = 10 })

config.update = function()
    _http:get("http://uraganu.go.ro:3000/get_all", function(data)
        config.array = { "-" }

        if data:success() then
            local decode = json.decode(data.body)
            for _, i in ipairs(decode) do
                table.insert(config.array, tostring(i.user))
            end          

            config.refs.list:update_items(config.array)
        end
    end)
end

config.update()

config.refs.save:add_callback(function()
    _http:post("http://uraganu.go.ro:3000/save", { user = client.username, input = config.export() }, function(data)
        if (data:success()) then
            config.update()
        end
    end)
end)

config.refs.load:add_callback(function()
    _http:post("http://uraganu.go.ro:3000/get", { id = tostring(config.refs.list:get()) }, function(data)
        if data:success() then
            local decode = json.decode(data.body)
            for _, i in ipairs(decode) do
                config.import(base64.decode(i.input))
            end
        end
    end)
end)

config.refs.reload:add_callback(function()
    _http:get("http://uraganu.go.ro:3000/get_all", function(data)
        if data:success() then
            config.update()
        end
    end)
end)