local peachy = require "lib/peachy"

function CreatePlayer(world,x,y)
    local player = {}
    player.korobeinik = peachy.new("assets/korobein.json", love.graphics.newImage("assets/korobein.png"), "def1")
    player.body = love.physics.newBody(world, 100,  300, "dynamic")
    player.shape = love.physics.newRectangleShape(42, 69)
    player.fixture = love.physics.newFixture(player.body, player.shape, 1)
    player.fixture:setFriction(0.7)
    player.body:setFixedRotation(true)
    player.maxvelocity = 200
    player.jumped = false
    player.onground = false
    player.mode = false
    player.balalayka = love.audio.newSource("MusicAndSounds/balalayk1.ogg","static")
	player.netsrun = love.audio.newSource("MusicAndSounds/netstrun1.ogg","static")
	player.scream = love.audio.newSource("MusicAndSounds/scream.mp3","static")
	player.upal = love.audio.newSource("MusicAndSounds/upal.mp3","static")
    player.step = love.audio.newSource("MusicAndSounds/step.ogg","static")
    return player
end

 

function UpdatePlayer(player,dt)

    function love.wheelmoved(x,y)
        if y > 0 then
            player.mode = true 
        end
        if y < 0 then
            player.mode = false
        end
    end 

    local playergravity = vector2.new(0,800)
    player.body:applyForce(playergravity.x, playergravity.y)

    if love.keyboard.isDown("d") and player.onground then
        local moveForce = vector2.new(900, 0)
        player.body:applyForce(moveForce.x, moveForce.y)
        love.audio.play(player.step)
        if player.mode then 
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step2")
            
        end
        if not player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step1")
        end
    elseif love.keyboard.isDown("a") and player.onground then
        local moveForce = vector2.new(-900, 0)
        player.body:applyForce(moveForce.x, moveForce.y)
        love.audio.play(player.step)
        
        if player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step2")
        end
        if not player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step1")
        end
    else
        player.body:applyForce(0, 0)
        if player.mode then
            player.korobeinik:setTag("def1")
        end
        if not player.mode then
            player.korobeinik:setTag("def")
        end
    end
    
    if love.keyboard.isDown("space") and player.jumped == false and player.onground == true then
        local jumpForce = vector2.new(0, -1000)
        player.body:applyLinearImpulse(jumpForce.x, jumpForce.y)
        player.jumped = true
    end
    

    local velocity = vector2.new(player.body:getLinearVelocity())
    if velocity.x > 0 then
        player.body:setLinearVelocity(math.min(velocity.x,player.maxvelocity), velocity.y)
    else
        player.body:setLinearVelocity(math.max(velocity.x,-player.maxvelocity), velocity.y)
    end

    local contacts = player.body:getContacts()
    if #contacts == 0 then
        player.onground = false
        if player.mode then
            player.korobeinik:setTag("jump2")
        end
        if not player.mode then
            player.korobeinik:setTag("jump")
        end
    else
        for i = 1, #contacts, 1 do
            local normal = vector2.new(contacts[i]:getNormal())
            --io.write("X: ", normal.x, " Y:", normal.y, " \n")            
            if normal.y == 1 then
                player.onground = true
            end
        end
    end
   
end

function keyreleasedPlayer(key,player)
    if key == "space" then
       player.jumped = false
    end
end

function DrowPlayer(player)
    love.graphics.setColor(1, 1, 1)
    player.korobeinik:draw(player.body:getX()-50, player.body:getY()-65, 0, 2, 2)
    love.graphics.setColor(1, 1, 1,0)
    love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
end