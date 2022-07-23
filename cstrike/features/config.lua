local _http = http.new({
    task_interval = 0.3, -- polling intervals
    enable_debug = false, -- print http requests to the console
    timeout = 10 -- request expiration time
})

local done = false
local configs = {}

function loop()
    if done then
        ui.add_dropdown("config list", { "mearsa"})

        done = false
    end
end

_http:get("http://uraganu.go.ro:3000/configs", function(data)
    if (data:success()) then
        local decode = json.decode(data.body)
        for _, i in ipairs(decode) do
            table.insert(configs, tostring(i.user))
            print(tostring(i.user))

            done = true
        end
    end
end)