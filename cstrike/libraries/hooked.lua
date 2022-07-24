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