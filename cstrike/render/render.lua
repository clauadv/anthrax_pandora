render.fonts = {
    small_fonts = render.create_font("Small Fonts", 8, 400, bit.bor(font_flags.outline, font_flags.antialias))
}

render.screen = {
    w = 0,
    h = 0
}

render.center_screen = {
    w = 0,
    h = 0
}

render.update = function()
    local screen = render.get_screen()

    render.screen.w = screen.x
    render.screen.h = screen.y

    render.center_screen.w = screen.x / 2
    render.center_screen.h = screen.y / 2
end