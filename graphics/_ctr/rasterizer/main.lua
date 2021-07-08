local rasterizer, glyphData
function love.load()
    love.graphics.setBackgroundColor(0.8,0.75,1)
    love.graphics.set3D(false)

    rasterizer = love.font.newBCFNTRasterizer()
    glyphData = rasterizer:getGlyphData("!")
end

function love.draw(screen)
    if screen == "top" then
        love.graphics.print("Default Font xAdvance: " .. rasterizer:getAdvance(), 0, 0)
        love.graphics.print("! (default Font) xAdvance: " .. glyphData:getAdvance(), 0, 14)
        love.graphics.print("Defualt Font glyph count: " .. rasterizer:getGlyphCount(), 0, 28)
    end
end

function love.gamepadpressed(joystick, button)
    if button == "start" then love.event.quit() end
end