local g_Button = nil
function love.load()
end

function love.draw()
    if g_Button then
        love.graphics.print("pressed " .. g_Button)
    end
end

function love.gamepadpressed(joy, button)
    if button == "start" then
        love.event.quit()
    else
        g_Button = button
    end
end

function love.gamepadaxis(joy, axis, value)

end
