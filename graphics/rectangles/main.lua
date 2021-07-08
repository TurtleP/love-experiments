function love.load()

end

function love.draw()
    love.graphics.setColor(1, 1, 1, 0.5)

    love.graphics.setLineWidth(10)
    love.graphics.rectangle("line", 40, 40, 64, 64, 8, 8)

    love.graphics.setLineWidth(2)
    love.graphics.rectangle("line", 272, 40, 64, 64, 8, 8)

    love.graphics.rectangle("fill", 168, 40, 64, 64, 8, 8)
end

function love.gamepadpressed(_, button)
    if button == "start" then
        love.event.quit()
    end
end
