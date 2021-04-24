love.run = require("run")

local showImage = false
local rectSin = 0
function love.load()
    love.graphics.setBackgroundColor(1, 0, 1)
    love.window.updateMode(320, 240)

    tex = love.graphics.newImage("maxresdefault.jpg")
end

function love.update(dt)
    rectSin = rectSin + 16 * dt
end

function love.draw()
    if showImage then
        love.graphics.draw(tex)
    end
    love.graphics.print("Hello World!\nW to activate Dialog\nSpace to toggle Texture")
    love.graphics.rectangle("fill", 160, 120 + math.sin(rectSin) * 4, 64, 64)
end

local dialog = "Windows 10 is now available for free for your device. Would you like to update now?"
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
