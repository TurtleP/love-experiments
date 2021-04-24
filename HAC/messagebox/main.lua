love.run = require("run")

local showImage = false
local rectSin = 0
function love.load()
    love.graphics.setBackgroundColor(1, 0, 1)
    love.window.updateMode(1280, 720)
end

function love.update(dt)
    rectSin = rectSin + 16 * dt
end

function love.draw()
    love.graphics.print("Hello World!\nW to activate Dialog\nSpace to toggle Texture")
    love.graphics.rectangle("fill", 160, 120 + math.sin(rectSin) * 4, 64, 64)
end

local dialog = "When an error occurs while you are playing a software title on this console, Nintendo"..
" would like your permission to send the error information to the relevant party in orer to help analyze"..
" and resolve the issue"

local buttons = { {"OK", "a"}, {"Yes", "b"}}

function love.keypressed(key)
    if key == "return" then
        love.event.quit()
    elseif key == "w" then
        local button = love.window.showMessageBox(nil, dialog, buttons)
        print("Pressed button " .. tostring(button) .. "!")
    elseif key == "space" then
        showImage = not showImage
    end
end
