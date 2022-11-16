require "Player"
require "vector2"
function CreateBullets(world,x,y)
    local bullets = {}
    bullets.pic = love.graphics.newImage("assets/bullet.png")
    --bullets.body = love.physics.newBody(world, 10,30, "dynamic")
    --bullets.shape = love.physics.newRectangleShape(5, 3)
    --bullets.fixture = love.physics.newFixture(bullets.body, bullets.shape, 1)
    --bullets.fixture:setFriction(1)
    --bullets.body:setFixedRotation(true)

    bullets.x = 100
    bullets.y = 200
	bullets.Speed = 1000
	
	bullets.ShootingRate = 0.9
	
	bullets.ShootingTime = 0

    return bullets
end

--[[function CreateDonuts(world,x,y)
    local donuts = {}
	donuts.Speed = 1000
	donuts.ShootingRate = 0.9
	donuts.ShootingTime = 0
    return donuts
end]]


--[[function BulletUpdate(bullets,dt)
    local BulletSpeed = vector2.new(1500, 0)
    if love.mouse.isDown(1) then 
        bullets.body:applyForce(BulletSpeed.x, BulletSpeed.y)
    end
function BulletSpawn()
    table.insert(bullets,{x = X, y = Y ,BulletSpeed})
end
end]]

function bulletSpawn(bullets)
   
    table.insert(bullets,{x = bullets.x+46, y = bullets.y+29 ,bulletSpeed = bullets.Speed })
    
end

function BulletDraw(bullets)
    for i,v in ipairs(bullets) do 
        love.graphics.draw(bullets.pic,v.x,v.y,0,0.6,0.6)
    end
end
--[[for i,v in ipairs(donuts) do 
    love.graphics.draw(donut,v.x,v.y,0,0.4,0.4)
end]]


