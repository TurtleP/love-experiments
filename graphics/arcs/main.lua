local pacwidth = math.pi / 6 -- size of his mouth
function love.draw(screen)
    love.graphics.print("Hello World")

    love.graphics.translate(100, 100)
    -- half circle

    love.graphics.setColor( 1, 1, 1 )
    love.graphics.arc( "fill", 25, 25, 10, 0, math.pi)

    -- Pac-Man
    love.graphics.setColor( 1, 1, 0 ) -- pacman needs to be yellow
    love.graphics.arc( "fill", 200, 120, 25, pacwidth, (math.pi * 2) - pacwidth )
end

function love.gamepadpressed(joy, button)
    if button == "start" then
        love.event.quit()
    end
end
