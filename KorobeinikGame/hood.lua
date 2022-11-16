function hoodload()
    font = love.graphics.newFont('assets/TriodPostnaja.ttf', 32)
    h = 3
    counterhood = love.graphics.newImage('assets/balalayka.png')
    heart = love.graphics.newImage('assets/heart.png')
end

function hooddraw()

    love.graphics.print("X : 10", font, 700, 60)

    love.graphics.draw(counterhood, 650, 50, 0, 2, 2)
    for i = 1, h, 1 do
        love.graphics.draw(heart, 10 + i * 40, 50, 0, 4, 4)
    end
end