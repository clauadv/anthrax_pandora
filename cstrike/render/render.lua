render.fonts = {
    tahoma_13px = render.create_font("Tahoma", 13, 500, bit.bor(font_flags.dropshadow, font_flags.antialias));
}

render.screen = {
    w = 0,
    h = 0
}

local render_get_screen = render.get_screen
render.get_screen = function()
    local screen_w, screen_h = render_get_screen()
    return vector2d.new(screen_w, screen_h)
end

render.update = function()
    local screen = render.get_screen()

    render.screen.w = screen.x
    render.screen.h = screen.y
end