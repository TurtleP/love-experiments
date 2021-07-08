local status, data = "%s was %s!", {"", ""}
local count = 0

function love.load()

end

function love.draw()
    love.graphics.print(status:format(unpack(data)) .. "\nPress START twice to quit.")
end

function love.gamepadpressed(_, button)
    data = {button, "pressed"}

    if button == "start" then
        count = count + 1
        if count == 2 then
            love.event.quit()
        end
    else
        count = 0
    end
end

function love.gamepadreleased(_, button)
    data = {button, "released"}
end
