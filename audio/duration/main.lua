local source, paused = nil, false
function love.load()
    source = love.audio.newSource("main.ogg", "stream")
end

function love.draw()
    local str = "Source Position: " .. source:tell() .. "s\n" ..
                "Source Duration: " .. source:getDuration() .. "s\n" ..
                "Source Playing: "  .. tostring(source:isPlaying())

    love.graphics.print(str)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" then
        source:play()
    elseif key == "w" then
        paused = not paused
        if paused then
            source:pause()
        else
            source:resume()
        end
    end
end
