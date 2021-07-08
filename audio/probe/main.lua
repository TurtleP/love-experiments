-- local username, friendCode = nil, nil
local source = nil
function love.load()
    -- username = love.system.getUsername()
    -- friendCode = love.system.getFriendCode()

    source = love.audio.newSource("main.oggggg", "stream")
    source:play()
end

local output = [[
Hello, %s.
Your console Friend Code is: %s.
Press any button to quit.
]]

function love.draw(_)
    -- love.graphics.print(output:format(tostring(username), tostring(friendCode)))
end

function love.gamepadpressed(_, _)
    love.event.quit()
end
