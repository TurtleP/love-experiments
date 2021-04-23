-- set up variables
local textFont = love.graphics.newFont(16)
local textColors = {}

textColors.default = {0.08, 0.08, 0.08}
textColors.pressed = {1.00, 1.00, 1.00}

g_windowShown = false

local boxPosition = {}
local boxSize = {}

local function newButton(id, text, x, width)
    local button = {}

    button.text = text
    button.width = width

    button.x = x
    button.y = boxPosition.y + (boxSize.h - 40)

    button.width = width
    button.height = 40

    button.id = id or 1

    button.textColor = textColors.default

    function button:drawShadowText(x, y)
        love.graphics.setColor(textColors.default)
        love.graphics.print(self.text, textFont, x, y)
    end

    function button:draw()
        local x, y = self.x + (self.width - textFont:getWidth(self.text)) / 2, self.y + (self.height - textFont:getHeight()) / 2

        if self.textColor == textColors.pressed then
            self:drawShadowText(x, y + 1)
        end

        love.graphics.setColor(self.textColor)
        love.graphics.print(self.text, textFont, x, y)
    end

    function button:touchpressed(_, x, y)
        if (x > self.x and x + 1 < self.x + self.width and y > self.y and y + 1 < self.y + self.height) then
            self.textColor = textColors.pressed
            return self.id
        end
    end

    function button:touchreleased()
        self.textColor = textColors.default
    end

    function button:mousepressed(x, y)
        return self:touchpressed(nil, x, y)
    end

    return button
end

local function newMessageBox(text, buttons)
    local messagebox = {}

    local currentFont = love.graphics.getFont()
    textFont:setLineHeight(1.25)

    messagebox.buttons = {}
    assert(#buttons < 3, "cannot have more than two buttons")

    -- textures
    local textures = {}

    textures.single = {}

    textures.single[0] = love.graphics.newImage("romfs/prompt_single_up.png")
    textures.single[1] = love.graphics.newImage("romfs/prompt_single_down.png")

    textures.double = {}

    textures.double[0] = love.graphics.newImage("romfs/prompt_double_up.png")
    textures.double[1] = love.graphics.newImage("romfs/prompt_double_left.png")
    textures.double[2] = love.graphics.newImage("romfs/prompt_double_right.png")

    messagebox.texture = textures.single[0]

    if #buttons == 0 then
        table.insert(messagebox.buttons, newButton("OK", boxPosition.x, boxSize.w))
    else
        if #buttons == 2 then
            messagebox.texture = textures.double[0]
        end

        local width = (boxSize.w / #buttons)
        for i = 1, #buttons do
            table.insert(messagebox.buttons, newButton(i, buttons[i], boxPosition.x + (i - 1) * width, width))
        end
    end

    messagebox.baseTexture = messagebox.texture
    messagebox.mode = #messagebox.buttons == 1 and "single" or "double"

    local buttonID = nil
    function messagebox:poll(event, ...)
        local args = {...}

        if event == "touchpressed" or event == "mousepressed" then
            if event == "touchpressed" then
                for _, button in ipairs(self.buttons) do
                    buttonID = button:touchpressed(unpack(args))
                end
            elseif event == "mousepressed" then
                for _, button in ipairs(self.buttons) do
                    buttonID = button:mousepressed(unpack(args))
                end
            end

            if not buttonID then
                return
            end

            self.texture = textures[self.mode][buttonID]
        elseif event == "touchreleased" or event == "mousereleased" then
            self.texture = self.baseTexture
            if buttonID then
                self.buttons[buttonID]:touchreleased()
            end
            return buttonID
        end
    end

    function messagebox:draw()
        love.graphics.setColor(1, 1, 1)
        love.graphics.print(love.timer.getFPS())

        love.graphics.draw(self.texture, boxPosition.x, boxPosition.y)

        love.graphics.setColor(textColors.default)
        love.graphics.printf(text, textFont, 24, ((boxPosition.y + boxSize.h) - 40) / 3, boxSize.w - 24, "center")

        for _, value in ipairs(self.buttons) do
            value:draw()
        end

        love.graphics.setFont(currentFont)
    end

    return messagebox
end

local box

local function main()
    while true do
        if love.event and love.event.pump then
            love.event.pump()

            for name, a, b, c, d, e, f in love.event.poll() do
                local value = box:poll(name, a, b, c, d, e, f)

                if value then
                    g_windowShown = false
                    return value
                end
            end
        end

        if love.timer then
            dt = love.timer.step()
        end

        -- Call update
        if love.update then
            love.update(dt)
        end

        if love.graphics and love.graphics.isActive() then
            love.graphics.origin()
            love.graphics.clear(love.graphics.getBackgroundColor())

            if love.draw then
                love.draw()
            end

            box:draw()

            love.graphics.present()
        end

        if love.timer then
            love.timer.sleep(0.001)
        end
    end
end

function love.window.showMessageBox(text, buttons)
    g_windowShown = true

    boxPosition = { x = 10, y = 12}
    boxSize = { w = (love.graphics.getWidth("bottom") or 320) - (boxPosition.x * 2), h = love.graphics.getHeight() - (boxPosition.y * 2)}

    box = newMessageBox(text, buttons)

    return main()
end
