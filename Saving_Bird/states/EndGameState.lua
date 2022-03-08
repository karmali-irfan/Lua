-- Class for endgame 

EndGameState = class {}

function EndGameState:init()

end 

function EndGameState:update(dt) -- freezing the screen when the game ends 
    BG_SPEED = 0
    G_SPEED = 0
    P_SCROLL = 0
end 

function EndGameState:render()
    bird:render()
    for key, pole in pairs(poles) do 
        pole:render()
    end
    love.graphics.setFont(score_font)
    scoreCount()
    love.graphics.printf(score, 0, 20, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(small_font)
    love.graphics.printf('Press enter', 0, VIRTUAL_HEIGHT - 100, VIRTUAL_WIDTH, 'center')
end 

