ButtonHeight = 75

function NewButton(text,fn)
    return {text = text , fn = fn, now = false, last = false }
end


local buttons = {}
local font = nil 
local button_sound = love.audio.newSource("MusicAndSounds/zvuk11.mp3","stream")
local kalinka = love.audio.newSource("MusicAndSounds/kalinka.mp3","stream")
local phone = love.graphics.newImage("assets/kal.jpg")

function love.load()
    love.window.setMode(800,600)
    --love.window.setFullscreen(true,"desktop")
    
    love.audio.play(kalinka)
    love.audio.setVolume(0.2)
    font =  love.graphics.newFont("assets/TriodPostnaja.ttf",33)
    love.window.setTitle("Korobeinik")
    table.insert(buttons,NewButton(
        "Play",
        function()
            
           io.write("i am working ","\n")
            
           love.audio.play(button_sound)
           
           
        end))


    table.insert(buttons,NewButton(
        "Settings",
        function()
            print("i am working too")
            love.audio.play(button_sound)
        end))

        
    table.insert(buttons,NewButton(
        "Exit",
        function()
			love.audio.play(button_sound)
            love.timer.sleep(0.5)
            love.event.quit(0)
        end))
    
    
    
end

function love.draw()

    love.graphics.draw(phone,0,0)
    
    local bw = love.graphics.getWidth()
    local bh = love.graphics.getHeight()

    ButtonWidth = bw*(1/3)

    local margin = 16
    local CursorY = 0

    TotalHeight = (ButtonHeight+margin)*#buttons
    
    for i , button in ipairs(buttons) do 

        button.now = button.last

        local bx = (bw*0.5) - (ButtonWidth*0.5)

        local by = (bh*0.5) - (ButtonHeight * 0.5) - (TotalHeight*0.5)+CursorY

        local color = {0.4,0.4,0.5,1}

        local mx , my  = love.mouse.getPosition()

        local hot  = mx > bx  and mx < bx + ButtonWidth and my > by and my < by + ButtonHeight

        
    
        if hot then --
            color = { 0.8,0.8,0.9,1}
           
           
            --love.audio.play(button_sound)
          
        end 
       
        
        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then 
            button.fn()
           
        end 

        love.graphics.setColor(unpack(color))

        love.graphics.rectangle("fill",bx,by,ButtonWidth,ButtonHeight)

        love.graphics.setColor(1,0,0,1)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)-30

        love.graphics.print(button.text,font,(bw*0.5) - textW * 0.5,by+textH*0.5)
        
        CursorY = CursorY + (ButtonHeight + margin)


    end

end