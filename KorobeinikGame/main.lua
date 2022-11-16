require "vector2"
require "player"
require "platform"
require "Box_physics"
require 'hood'

local world
local player
local level1
local BoxInLevel1

function love.load()

    hoodload()

    world = love.physics.newWorld(0, 9.81 * love.physics.getMeter(), true)
    player = CreatePlayer(world,100,300)
    BoxInLevel1 = {}
    BoxInLevel1[1] = BoxLoad(world,200,522,65,62)
    BoxInLevel1[2] = BoxLoad(world,1000,522,65,62)

    level1 = {}
    level1[1] = CreatePlatform(world,400,575,700,50 )
    level1[2] = CreatePlatform(world,400,420,100,30 )
    level1[3] = CreatePlatform(world,1200,575,600,50 )
end

function love.keyreleased(key)
    keyreleasedPlayer(key,player)
 end

function love.update(dt) 
    UpdatePlayer(player,dt)
    --BoxUpdate(BoxInLevel1,dt)
    world:update(dt)
end

function love.draw()
    love.graphics.push()
    local playerposition = vector2.new(-player.body:getPosition(),player.body:getPosition())
    love.graphics.translate(playerposition.x+380,0)
    DrawLevel(level1)
    DrowPlayer(player)
    BoxDraw(BoxInLevel1)
    love.graphics.pop()
    hooddraw()
end

function love.draw()
    love.graphics.push()
    local playerposition = vector2.new(-player.body:getPosition(),player.body:getPosition())
    love.graphics.translate(playerposition.x+380,0)
    DrawLevel(level1)
    DrowPlayer(player)
    BoxDraw(BoxInLevel1)
    love.graphics.pop()
    love.graphics.print("X : 10",30,100)
end
