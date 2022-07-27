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
    local data = {}

    for option, value in pairs(rage.refs) do
        local value_type = value:get_type()
    
        if value_type == "checkbox" or value_type == "dropdown" or value_type == "slider" then
            table.insert(data, { "rage", option, value:get() })

        elseif value_type == "multi_dropdown" then
            for i = 1, #value:get_items() do
                table.insert(data, { "rage", option, value:get(value:get_items()[i]), value:get_items()[i] })
            end

        elseif value_type == "color_cog" then
            local color = {
                value:get_color():r(),
                value:get_color():g(),
                value:get_color():b(),
                value:get_color():a()
            }

            table.insert(data, { "rage", option, color })
        end
    end

    for state = 0, #antiaim.states do
        for option, value in pairs(antiaim.refs[state]) do
            local value_type = value:get_type()
        
            if value_type == "checkbox" or value_type == "dropdown" or value_type == "slider" then
                table.insert(data, { "antiaim_" .. tostring(antiaim.states[state]), option, value:get() })
    
            elseif value_type == "multi_dropdown" then
                for i = 1, #value:get_items() do
                    table.insert(data, { "antiaim_" .. tostring(antiaim.states[state]), option, value:get(value:get_items()[i]), value:get_items()[i] })
                end
    
            elseif value_type == "color_cog" then
                local color = {
                    value:get_color():r(),
                    value:get_color():g(),
                    value:get_color():b(),
                    value:get_color():a()
                }
    
                table.insert(data, { "antiaim_" .. tostring(antiaim.states[state]), option, color })
            end
        end
    end

    for option, value in pairs(dynamic_antiaim.refs) do
        local value_type = value:get_type()
    
        if value_type == "checkbox" or value_type == "dropdown" or value_type == "slider" then
            table.insert(data, { "dynamic_antiaim", option, value:get() })

        elseif value_type == "multi_dropdown" then
            for i = 1, #value:get_items() do
                table.insert(data, { "dynamic_antiaim", option, value:get(value:get_items()[i]), value:get_items()[i] })
            end

        elseif value_type == "color_cog" then
            local color = {
                value:get_color():r(),
                value:get_color():g(),
                value:get_color():b(),
                value:get_color():a()
            }

            table.insert(data, { "dynamic_antiaim", option, color })
        end
    end
    
    for option, value in pairs(visuals.refs) do
        local value_type = value:get_type()
    
        if value_type == "checkbox" or value_type == "dropdown" or value_type == "slider" then
            table.insert(data, { "visuals", option, value:get() })

        elseif value_type == "multi_dropdown" then
            for i = 1, #value:get_items() do
                table.insert(data, { "visuals", option, value:get(value:get_items()[i]), value:get_items()[i] })
            end

        elseif value_type == "color_cog" then
            local color = {
                value:get_color():r(),
                value:get_color():g(),
                value:get_color():b(),
                value:get_color():a()
            }

            table.insert(data, { "visuals", option, color })
        end
    end

    for option, value in pairs(misc.refs) do
        local value_type = value:get_type()
    
        if value_type == "checkbox" or value_type == "dropdown" or value_type == "slider" then
            table.insert(data, { "misc", option, value:get() })

        elseif value_type == "multi_dropdown" then
            for i = 1, #value:get_items() do
                table.insert(data, { "misc", option, value:get(value:get_items()[i]), value:get_items()[i] })
            end

        elseif value_type == "color_cog" then
            local color = {
                value:get_color():r(),
                value:get_color():g(),
                value:get_color():b(),
                value:get_color():a()
            }

            table.insert(data, { "visuals", option, color })
        end
    end

    print("exported successfully")
    return json.encode(data)
end

config.import = function(input)
    local data = json.decode(input)

    local name = {
        ["rage"] = rage.refs,
        ["antiaim_stand"] = antiaim.refs[0],
        ["antiaim_run"] = antiaim.refs[1],
        ["antiaim_walk"] = antiaim.refs[2],
        ["antiaim_duck"] = antiaim.refs[3],
        ["antiaim_air"] = antiaim.refs[4],
        ["antiaim_duck + air"] = antiaim.refs[5],
        ["antiaim_brute 1"] = antiaim.refs[6],
        ["antiaim_brute 2"] = antiaim.refs[7],
        ["antiaim_brute 3"] = antiaim.refs[8],
        ["dynamic_antiaim"] = dynamic_antiaim.refs,
        ["visuals"] = visuals.refs,
        ["misc"] = misc.refs
    }

    for _, i in pairs(data) do
        local category = i[1]
        local option = i[2]
        local value = i[3]

        local ref = name[category][option]
        local ref_type = ref:get_type()

        if ref_type == "checkbox" or ref_type == "dropdown" or ref_type == "slider" then
            ref:set(value)
            -- print(tostring(option) .. ".set(" .. tostring(value) .. ")")

        elseif ref_type == "multi_dropdown" then
            ref:set(i[4], value)
            -- print(tostring(option) .. ".set(" .. tostring(i[4]) .. ", ".. tostring(value) .. ")")

        elseif ref_type == "color_cog" then
            local color = color.new(value[1], value[2], value[3], value[4])
            ref:set_color(color)

            -- print(tostring(option) .. ".set_color(" .. tostring(value[1]) .. "," .. tostring(value[2]) .. "," .. tostring(value[3]) .. "," .. tostring(value[4]) .. ")")
        end
    end

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
    _http:post("http://uraganu.go.ro:3000/save", { user = client.username, config = config.export() }, function(data)
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
                config.import(i.config)
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