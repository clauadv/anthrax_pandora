local config = {
    refs = {
        list = ui.add_dropdown("config list", { "1", "2" }),
        save = ui.add_button("save"),
        load = ui.add_button("load")
    },
    
    array = {}
}

config.visibility = function()
    local tab = menu.tabs:get() == 5 and true or false

    config.refs.list:set_visible(tab)
    config.refs.save:set_visible(tab)
    config.refs.load:set_visible(tab)
end

local _http = http.new({ task_interval = 0.3, enable_debug = false, timeout = 10 })

_http:get("http://uraganu.go.ro:3000/configs", function(data)
    if data:success() then
        local decode = json.decode(data.body)
        for _, i in ipairs(decode) do
            table.insert(config.array, tostring(i.user))
        end

        -- needs to be implemented
        -- config.refs.list:update_list(config.array)
    end
end)

config.refs.save:add_callback(function()
    print("saved config")
end)

config.refs.load:add_callback(function()
    print("loaded config")
end)