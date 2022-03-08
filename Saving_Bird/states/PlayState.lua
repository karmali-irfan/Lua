-- Class for PlayState 

PlayState = class{}

score = 0
BG_SPEED = 25
G_SPEED = 60

function PlayState:init()
    
end 

function PlayState:update(dt)
    BG_SPEED = 25
    G_SPEED = 50
    P_SCROLL = 60
    Pole():update(dt)
    bird:update(dt)
end 

function PlayState:render()
    bird:render()
    for key, pole in pairs(poles) do 
        pole:render()
    end
    love.graphics.setFont(score_font)
    scoreCount()
    love.graphics.printf(score, 0, 20, VIRTUAL_WIDTH, 'center')
end

function scoreCount() -- function to keep track of the scores 
    for key, pole in pairs(poles) do 
        if pole.score == false then 
            if pole.x + pole.width < bird.x then 
                score = score + 1 
                sounds['point']:play()
                pole.score = true 
            end
        end
    end
end