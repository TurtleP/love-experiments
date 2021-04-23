love.run = require("run")

local showImage = false
function love.load()
    love.graphics.setBackgroundColor(1, 0, 1)
    love.window.updateMode(320, 240)

    tex = love.graphics.newImage("maxresdefault.jpg")
end

function love.update(dt)

end

function love.draw()
    if showImage then
        love.graphics.draw(tex)
    end
    love.graphics.print("Hello World!", 160, 120)
end

function love.keypressed(key)
    if key == "return" then
        love.event.quit()
    elseif key == "w" then
        local button = love.window.showMessageBox("Please plug in the AC adapter to ensure that the system does not lose power during the update. ", {"OK", "No"})
        print("Pressed button " .. button .. "!")
    elseif key == "space" then
        showImage = not showImage
    end
end
