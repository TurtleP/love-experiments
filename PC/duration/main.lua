local source = nil
function love.load()
    source = love.audio.newSource("main.ogg", "stream")
end

function love.draw()
    local str = "Source Position: " .. source:tell() .. "s\n"
    str = str .. "Source Duration: " .. source:getDuration() .. "s"

    love.graphics.print(str)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        source:play()
    end
end
