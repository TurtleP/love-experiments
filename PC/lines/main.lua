local line = {0, 0, 10, 10}
local line2 = {10, 10, 20, 20}

function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.line(unpack(line2))

    love.graphics.setColor(1, 1, 0)
    love.graphics.line(line)
end
