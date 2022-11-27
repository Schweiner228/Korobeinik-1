local peachy = require "lib/peachy"
require "hood"
--require "weapons"

function CreatePlayer(world,x,y)
    local player = {}
    player.x = 100
    player.y = 300
    player.korobeinik = peachy.new("assets/korobein.json", love.graphics.newImage("assets/korobein.png"), "def1")
    player.body = love.physics.newBody(world, player.x,  player.y, "dynamic")
    player.shape = love.physics.newRectangleShape(42, 69)
    player.fixture = love.physics.newFixture(player.body, player.shape, 1)
    player.fixture:setFriction(0.1)
    player.body:setFixedRotation(true)
    player.maxvelocity = 1800
    player.jumped = false
    player.onground = false
    player.mode = false
    player.fixture:setUserData(player)
    player.tag = "player"
    player.balalayka = love.audio.newSource("MusicAndSounds/balalayk1.ogg","static")
	player.netsrun = love.audio.newSource("MusicAndSounds/netstrun1.ogg","static")
	player.scream = love.audio.newSource("MusicAndSounds/scream.mp3","static")
	player.upal = love.audio.newSource("MusicAndSounds/upal.mp3","static")
    player.step = love.audio.newSource("MusicAndSounds/step.ogg","static")
    player.vzmach = love.audio.newSource("MusicAndSounds/vzmach.ogg","static")
    player.collisionnormal = vector2.new(0,0)
    return player
end

direction = "right"



function UpdatePlayer(player,dt)
    function love.wheelmoved(x,y)
        if y > 0 then
            player.mode = true
        end
        if y < 0 then
            player.mode = false
        end
    end 

    local playergravity = vector2.new(0,1300)
    player.body:applyForce(playergravity.x, playergravity.y)
    local playervelocity = vector2.new(player.body:getLinearVelocity())

   if love.keyboard.isDown("d") and player.collisionnormal.x ~= 1 then 
        player.body:setLinearVelocity(700, playervelocity.y)
        direction = "right"
        if player.onground then
            love.audio.play(player.step)
        end 
        if player.mode then 
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step2")
            
        end
        if not player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step1")
        end
    
    elseif love.keyboard.isDown("a") and player.collisionnormal.x ~= -1  then
       player.body:setLinearVelocity(-700, playervelocity.y)
       direction = "left"

        if player.onground then
            love.audio.play(player.step)
        end
        
        if player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step2")
        end
    
        if not player.mode then
            player.korobeinik:update(dt)
            player.korobeinik:setTag("step1")
        end
      
    else
        player.body:setLinearVelocity(0, playervelocity.y)
        
        if player.mode then
            player.korobeinik:setTag("def1")
        end
        if not player.mode then
            player.korobeinik:setTag("def")
        end

    end

    --[[if love.keyboard.isDown("d") and love.keyboard.isDown("space")--[[and player.collisionnormal.x ~= 1  then
        player.body:setLinearVelocity(500, playervelocity.y)
        direction = "right"

        --[[if player.onground then 
            player.body:setLinearVelocity(0, playervelocity.y)
        end ]]
         
        --love.audio.play(player.step)
       --[[ if love.keyboard.isDown("a") and love.keyboard.isDown("space") then 
            player.body:setLinearVelocity(0, playervelocity.y)
        end 
        
    
   
    elseif love.keyboard.isDown("a") and love.keyboard.isDown("space") --[[and player.collisionnormal.x ~= -1  then
       player.body:setLinearVelocity(-500, playervelocity.y)
       direction = "left"
        --love.audio.play(player.step)
        --[[if love.keyboard.isDown("b") and love.keyboard.isDown("space") then 
            player.body:setLinearVelocity(0, playervelocity.y)
        end ]]
        --[[if player.onground then 
            player.body:setLinearVelocity(0, playervelocity.y)
        end 

    end]]
    
    if love.keyboard.isDown("space") and player.jumped == false and player.onground == true then
        love.audio.play(player.step)
        jumpForce = vector2.new(0, -3700)
        player.body:applyLinearImpulse(jumpForce.x, jumpForce.y)
        player.jumped = true
        player.onground = false
    end

    if  player.onground == false then
        if player.mode then
            player.korobeinik:setTag("jump2")
        end
        if not player.mode then
            player.korobeinik:setTag("jump")
        end
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
    else
        for i = 1, #contacts, 1 do
            local normal = vector2.new(contacts[i]:getNormal())
            --io.write("X: ", normal.x, " Y:", normal.y, " \n")            
            if normal.y == 1 then
                player.onground = true
            end
        end
    end

    --[[local contacts = player.body:getContacts()
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

    if player.body:getY() >= 530 then
		love.audio.setVolume(0.6)
		love.audio.play(player.scream)
	end 
	if player.body:getY() >= 2200 then
		love.audio.stop(player.scream)
		love.audio.play(player.upal)
        h = 0
	end 
	if player.body:getY() >= 4300 then
		love.audio.stop(player.upal)
	end ]]

    
    if love.keyboard.isDown("space") and h == 0  then 
        xh = 950
        h = 3 
        player.body:setY(100)
        player.body:setX(300)
        bcounter = 1500
        love.audio.stop(player.upal)
    end

    if love.keyboard.isDown("escape") then 
        love.event.quit(0)
    end
end 

function BeginContactPlayer(fixtureA,fixtureB,contact,player)
    if (fixtureA:getUserData().tag == "player" and 
       fixtureB:getUserData().tag == "platform") or 
       (fixtureA:getUserData().tag == "platform" and 
       fixtureB:getUserData().tag == "player") then
        local normal = vector2.new(contact:getNormal())
        if normal.y == 1 then
            player.onground = true
            if player.mode then
                player.korobeinik:setTag("def1")
            end
            if not player.mode then
                player.korobeinik:setTag("def")
            end
        end
        player.collisionnormal =  normal
        --[[if normal.y == 0 then
           
            player.onground = false
            if player.mode then
                player.korobeinik:setTag("jump2")
            end
            if not player.mode then
                player.korobeinik:setTag("jump")
            end
        end]]
    end


    if (fixtureA:getUserData().tag == "player" and fixtureB:getUserData().tag == "box") 
    or (fixtureA:getUserData().tag == "box" and 
    fixtureB:getUserData().tag == "player") then
        local normal = vector2.new(contact:getNormal())
        if normal.y == 1 then
            player.onground = true
           --[[ if player.mode then
                player.korobeinik:setTag("def1")
            end
            if not player.mode then
                player.korobeinik:setTag("def")
            end]]
        end
        --player.collisionnormal =  normal
    end


    
    if (fixtureA:getUserData().tag == "platform" and 
    fixtureB:getUserData().tag == "box") or 
    (fixtureA:getUserData().tag == "platfom" and 
    fixtureB:getUserData().tag == "box") then
        local normal = vector2.new(contact:getNormal())
        if normal.y == 1 then
            player.onground = true
           --[[ if player.mode then
                player.korobeinik:setTag("def1")
            end
            if not player.mode then
                player.korobeinik:setTag("def")
            end]]
        end
        --player.collisionnormal =  normal
    end


    if (fixtureA:getUserData().tag == "player" 
    and fixtureB:getUserData().tag == "deth1") 
    or (fixtureA:getUserData().tag == "deth1" 
    and fixtureB:getUserData().tag == "player") then
        --levelcompleted = true
        --player.body:setLinearVelocity(0, 0)
        love.audio.setVolume(0.6)
        love.audio.play(player.scream)
    end

    if (fixtureA:getUserData().tag == "player" and 
    fixtureB:getUserData().tag == "deth2") 
    or (fixtureA:getUserData().tag == "deth2" 
    and fixtureB:getUserData().tag == "player") then
        --levelcompleted = true
        --player.body:setLinearVelocity(0, 0)
        love.audio.stop(player.scream)
        love.audio.play(player.upal)
        h = 0
    end

    if (fixtureA:getUserData().tag == "player" 
    and fixtureB:getUserData().tag == "deth3") 
    or (fixtureA:getUserData().tag == "deth3" 
    and fixtureB:getUserData().tag == "player") then
        --levelcompleted = true
        --player.body:setLinearVelocity(0, 0)
        love.audio.stop(player.upal)
    end

    if (fixtureA:getUserData().tag == "player" and 
       fixtureB:getUserData().tag == "amonite") or 
       (fixtureA:getUserData().tag == "amonite" and 
       fixtureB:getUserData().tag == "player") then
        local normal = vector2.new(contact:getNormal())
        if normal.y == 1 then
            if h <3 then 
                h = math.random(h-1,h+1)
            else
                h = h - math.random(0,1)
            end
        end

    end
end


function keyreleasedPlayer(key,player)
    if key == "space" then
       player.jumped = false
    end
end


function DrawPlayer(player)
    if direction == "right" then 
        bodyX =player.body:getX()-50
        skaleX = 2 
    end

    if direction == "left" then 
        bodyX = player.body:getX()+50
        skaleX = -2
    end

    player.korobeinik:draw(bodyX, player.body:getY()-65,0,skaleX, 2)
    --love.graphics.setColor(1, 1, 1,0)
    if player.body:getY()>550 then 
        love.graphics.setColor(1,0,0,0.3)
    end 
   -- love.graphics.polygon("fill", player.body:getWorldPoints(player.shape:getPoints()))
end


function DrawScreenDeath(player)
    if h == 0 then 
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("GAME OVER", font, 405, 300,0,1.4)
        love.graphics.print("press 'Space' to restart", font, 460, 380,0,0.5)
        love.graphics.print("press 'Esc' to exit", font, 480, 410,0,0.5)
        love.graphics.setColor(0, 0, 0,0.6)
        love.graphics.rectangle("fill",0,0,1280,720)
        xh=-200
    end
end
