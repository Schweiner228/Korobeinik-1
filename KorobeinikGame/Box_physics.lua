require "hood"
require "vector2"
function BoxLoad(world,x,y,width,height)
    local box = {}
    box.body = love.physics.newBody(world, x, y, "dynamic")
    box.shape = love.physics.newRectangleShape(width, height)
    box.fixture = love.physics.newFixture(box.body, box.shape, 1)
   -- box.fixture:setRestitution(0.1)
    box.body:setFixedRotation(true)
    box.fixture:setFriction(1)
    box.fixture:setUserData("box")
    pic = love.graphics.newImage("assets/stone.png")
    return box
end
function UpdateBox(box,dt) 
    local boxgravity = vector2.new(0,3300)
    box.body:applyForce( boxgravity.x, boxgravity.y)
end 

function BoxDraw(BoxInLevel1)
    love.graphics.setColor(1, 1, 1,0.9)
    for i = 1,#BoxInLevel1,1 do 
        --love.graphics.polygon("fill", BoxInLevel1[i].body:getWorldPoints(BoxInLevel1[i].shape:getPoints()))
        love.graphics.draw(pic,BoxInLevel1[i].body:getX()-32,BoxInLevel1[i].body:getY()-32,0,2,2)
    end
end
