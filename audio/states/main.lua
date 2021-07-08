local sources = nil
function love.load()
    sources = { love.audio.newSource("audio/jojo.ogg", "stream"), love.audio.newSource("audio/spacejam.ogg", "stream") }
end

local str = [[
LÖVE Potion Audio Test
A: Stop all Sources (Source table)
B: Resume/Play all Sources (Source table)
Y: Stop all Sources (global)
X: Pause all Sources (global)
Start: Quit
]]
function love.draw(screen)
    if screen == "bottom" then
        return
    end

    love.graphics.print(str)
end

function love.gamepadpressed(_, button)
    if button == "a" then
        love.audio.stop(unpack(sources))
    elseif button == "b" then
        love.audio.play(unpack(sources))
    elseif button == "y" then
        love.audio.stop()
    elseif button == "x" then
        love.audio.pause()
    elseif button == "start" then
        love.event.quit()
    end
end
