function BoxLoad(world,x,y,width,height)
    local box = {}
    box.body = love.physics.newBody(world, x, y, "dynamic")
    box.shape = love.physics.newRectangleShape(width, height)
    box.fixture = love.physics.newFixture(box.body, box.shape, 1)
   -- box.fixture:setRestitution(0.1)
    box.body:setFixedRotation(false)
    box.fixture:setFriction(0.1)
    pic = love.graphics.newImage("assets/stone.png")
    return box
end

--[[function BoxUpdate(BoxInLevel1,dt)
    local boxgravity = vector2.new(0,800)
    BoxInLevel1.body:applyForce(boxgravity.x, boxgravity.y)
end]]

function BoxDraw(BoxInLevel1)
    love.graphics.setColor(0.4, 0.2, 0)
    for i = 1,#BoxInLevel1,1 do 
        love.graphics.polygon("fill", BoxInLevel1[i].body:getWorldPoints(BoxInLevel1[i].shape:getPoints()))
        love.graphics.draw(pic,BoxInLevel1[i].body:getX()-32,BoxInLevel1[i].body:getY()-34,0,2,2)
    end
    
end