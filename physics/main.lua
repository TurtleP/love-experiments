local w, h = 400, 240
local objects = {}
local world

function love.load()
    -- the height of a meter our worlds will be 64px
    love.physics.setMeter(64)

    local log = love.filesystem.newFile("log.txt", "w")
    log:write("WidthxHeight: " .. w .. "x" .. h .. "\n")
    -- create a world for the bodies to exist in with horizontal gravity
    -- of 0 and vertical gravity of 9.81
    world = love.physics.newWorld(0, 9.81 * 64, true)
    log:write("World: " .. type(world) .. "\n")

    -- let's create the ground
    objects.ground = {}

    -- remember, the shape (the rectangle we create next) anchors to the
    -- body from its center, so we have to move it to (w/2, h-50/2)
    objects.ground.body = love.physics.newBody(world, w / 2, h - 50 / 2)

    -- make a rectangle with a width of w and a height of 50
    objects.ground.shape = love.physics.newRectangleShape(w, 50)

    -- attach shape to body
    objects.ground.fixture = love.physics.newFixture(objects.ground.body, objects.ground.shape)
    log:write("Ground (fixture): " .. type(objects.ground.fixture) .. "\n")

    -- -- let's create a ball
    -- objects.ball = {}
    -- -- place the body in the center of the world and make it dynamic, so
    -- -- it can move around
    -- objects.ball.body = love.physics.newBody(world, w/2, h/2, "dynamic")
    -- -- the ball's shape has a radius of 20
    -- objects.ball.shape = love.physics.newCircleShape(20)
    -- -- Attach fixture to body and give it a density of 1.
    -- objects.ball.fixture = love.physics.newFixture(objects.ball.body,
    --                                                objects.ball.shape, 1)
    -- objects.ball.fixture:setRestitution(0.9) -- let the ball bounce

    -- -- let's create a couple blocks to play around with
    -- objects.block1 = {}
    -- objects.block1.body = love.physics.newBody(world, 200, 550, "dynamic")
    -- objects.block1.shape = love.physics.newRectangleShape(0, 0, 50, 100)
    -- -- A higher density gives it more mass.
    -- objects.block1.fixture = love.physics.newFixture(objects.block1.body,
    --                                                  objects.block1.shape, 5)

    -- objects.block2 = {}
    -- objects.block2.body = love.physics.newBody(world, 200, 400, "dynamic")
    -- objects.block2.shape = love.physics.newRectangleShape(0, 0, 100, 50)
    -- objects.block2.fixture = love.physics.newFixture(objects.block2.body,
    --                                                  objects.block2.shape, 2)

    -- initial graphics setup
    -- set the background color to a nice blue
    love.graphics.setBackgroundColor(0.41, 0.53, 0.97)
    -- love.window.setMode(650, 650) -- set the window dimensions to 650 by 650
end


function love.update(dt)
    world:update(dt)
end

function love.draw(screen)
    if screen == "bottom" then
        return
    end

    -- set the drawing color to green for the ground
    love.graphics.setColor(0.28, 0.63, 0.05)

    -- draw a "filled in" polygon using the ground's coordinates
    love.graphics.polygon("fill", objects.ground.body:getWorldPoints(objects.ground.shape:getPoints()))

    -- set the drawing color to red for the ball
    -- love.graphics.setColor(0.76, 0.18, 0.05)
    -- love.graphics.circle("fill", objects.ball.body:getX(),
    --                      objects.ball.body:getY(), objects.ball.shape:getRadius())

    -- -- set the drawing color to grey for the blocks
    -- love.graphics.setColor(0.20, 0.20, 0.20)
    -- love.graphics.polygon("fill", objects.block1.body:getWorldPoints(
    --                          objects.block1.shape:getPoints()))
    -- love.graphics.polygon("fill", objects.block2.body:getWorldPoints(
    --                          objects.block2.shape:getPoints()))
end

function love.gamepadpressed(_, button)
    if button == "start" then
        love.event.quit()
    end
end
