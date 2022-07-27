-- hooked functions to make them readable in my eyes

local render_get_screen = render.get_screen
render.get_screen = function()
    local screen_w, screen_h = render_get_screen()
    return vector2d.new(screen_w, screen_h)
end

local penetration_simulate_bullet = penetration.simulate_bullet
penetration.simulate_bullet = function(attacker, start, _end)
    local damage, penetration_count, hitgroup = penetration_simulate_bullet(attacker, start, _end)
    return {
        damage = damage,
        penetration_count = penetration_count,
        hitgroup = hitgroup
    }
end

local ui_add_checkbox = ui.add_checkbox
ui.add_checkbox = function(name)
    local checkbox = ui_add_checkbox(name)

    __checkboxItem.type = "checkbox"

    return checkbox
end

function __checkboxItem:get_type()
    return __checkboxItem.type
end

__cogItem.type = {}

local ui_add_cog = ui.add_cog
ui.add_cog = function(tooltip, color, hotkey)
    local cog = ui_add_cog(tooltip, color, hotkey)

    if color then
        __cogItem.type[cog] = "color_cog"

    elseif hotkey then
        __cogItem.type[cog] = "hotkey_cog"
    end

    return cog
end

function __cogItem:get_type()
    return __cogItem.type[self]
end

local ui_add_slider = ui.add_slider
ui.add_slider = function(name, min, max)
    local slider = ui_add_slider(name, min, max)

    __sliderItem.type = "slider"

    return slider
end

function __sliderItem:get_type()
    return __sliderItem.type
end

local ui_add_dropdown = ui.add_dropdown
ui.add_dropdown = function(name, items)
    local dropdown = ui_add_dropdown(name, items)

    __dropdownItem.type = "dropdown"

    return dropdown
end

function __dropdownItem:get_type()
    return __dropdownItem.type
end

__multidropdownItem.items = {}

local ui_add_multi_dropdown = ui.add_multi_dropdown
ui.add_multi_dropdown = function(name, items)
    local multi_dropdown = ui_add_multi_dropdown(name, items)

    __multidropdownItem.type = "multi_dropdown"
    __multidropdownItem.items[multi_dropdown] = items

    return multi_dropdown
end

function __multidropdownItem:get_type()
    return __multidropdownItem.type
end

function __multidropdownItem:get_items()
    return __multidropdownItem.items[self]
end

local ui_add_label = ui.add_label
ui.add_label = function(name)
    local label = ui_add_label(name)

    __labelItem.type = "label"

    return label
end

function __labelItem:get_type()
    return __labelItem.type
end