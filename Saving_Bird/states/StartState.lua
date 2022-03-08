-- Class for start state 

StartState = class{}


function StartState: init()
    
end 

function StartState: update(dt)
    
end 

function StartState: render()
    for key, pole in pairs(poles) do 
        table.remove(poles) -- removing poles that might have been there
    end
    bird.y = VIRTUAL_HEIGHT / 2 - bird.height / 2 -- resetting the bird's position 
    bird:render()
    love.graphics.setFont(small_font)
    love.graphics.printf('Press SpaceBar to start', 0, VIRTUAL_HEIGHT - 100, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(score_font)
    score = 0
    love.graphics.printf(score, 0, 20, VIRTUAL_WIDTH, 'center')
end 

