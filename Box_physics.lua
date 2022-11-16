local world
local box

function love.load()
    world = love.physics.newWorld(0, 0, true)

    box = {}
    box.body = love.physics.newBody(world, 300, 520, "dynamic")
    box.shape = love.physics.newRectangleShape(50, 50)
    box.fixture = love.physics.newFixture(box.body, box.shape, 1)
    box.fixture:setRestitution(0)
    box.fixture:setFriction(0.6)
end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    love.graphics.setColor(0.4, 0.2, 0)
    love.graphics.polygon("fill", box.body:getWorldPoints(box.shape:getPoints()))
end