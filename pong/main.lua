-- Pong by Irfan Karmali
-- 28.12.2021

-- Including Libraries
push = require 'push'
class = require 'class'
require 'Paddle'
require 'Ball'

WINDOW_WIDTH = 1280 
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

paddle_right = Paddle (VIRTUAL_WIDTH - 10, VIRTUAL_HEIGHT - 40, 5, 30, 'up', 'down')
paddle_left = Paddle(10, 10, 5, 30, 'w', 's')
paddle_speed = 200
score_left = 0
score_right = 0
ball_x = VIRTUAL_WIDTH / 2 - 5 -- Horizontal position of the ball
ball_y = VIRTUAL_HEIGHT / 2 - 5 -- Vertical position of the ball
ball = Ball(VIRTUAL_WIDTH / 2 - 5 , VIRTUAL_HEIGHT / 2 - 5, 5, 5)

function love.load()
    push: setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true;
        fullscreen = false;
        resize = false;
    })
    retro_font = love.graphics.newFont('font.ttf', 10)
    love.graphics.setFont(retro_font)
    gameState = 'start'
    love.window.setTitle('Pong by Irfan Karmali ~ 2021')
end 

function love.draw()
    push: apply('start')

    love.graphics.clear(1/225, 100/225, 200/225, 0.8)
    love.graphics.printf('Hello Pong', 0, 2, VIRTUAL_WIDTH, 'center')
    paddle_right:render()
    paddle_left:render()
    ball:render()
    printFPS() -- Function to  printFPS(), see the function definition below
    if gameState == 'start' then
        displayScore() -- Function to display score, see function definition below
        if score_left ~= 10 or score_right ~= 10 then 
            love.graphics.printf('Prese enter to start', 0, 15, VIRTUAL_WIDTH, 'center')
        end 
    end
    if gameState == 'end' then
        displayScore() -- Function to display score, see function definition below
    end 


    push: apply('end')
end

function love.update(dt)
    paddle_left:update(dt)
    paddle_right:update(dt)
    ball:update(dt)
end

function love.keypressed(key)
    if key == 'escape' then 
        love.event.quit()
    end 
    if key == 'return' or key == 'enter' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'
        end
    end
    if key == 'space' then 
        score_left = 0
        score_right = 0
        gameState = 'start'
    end
end 

-- Function to Print FPS
function printFPS()
    love.graphics.setColor(225/225, 225/225, 0, 1)
    love.graphics.print('FPS:'..tostring(love.timer.getFPS()), 20, 2)
    -- "..tostring()" is lua's syntax for concantenating strings 
end

-- Function to display Score 
function displayScore()
    love.graphics.setColor(225/225, 225/225, 225/225, 1)
    score_font = love.graphics.newFont('font.ttf', 50)
    love.graphics.setFont(score_font)
    love.graphics.print(score_left, VIRTUAL_WIDTH / 2 - 12 - 30 , VIRTUAL_HEIGHT /3.1)
    love.graphics.print(score_right, VIRTUAL_WIDTH / 2 + 12, VIRTUAL_HEIGHT /3.1)
    love.graphics.setFont(retro_font)
    if score_left == 10 then 
        love.graphics.printf('PLayer 1 wins!', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press spacbar to restart', 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
        sound['win']:play() --Calling the sound to play
        gameState = 'end'
    elseif score_right == 10 then
        love.graphics.printf('Player 2 wins!', 0, VIRTUAL_HEIGHT - 50, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press spacbar to restart', 0, VIRTUAL_HEIGHT - 30, VIRTUAL_WIDTH, 'center')
        sound['win']:play() --Calling the sound to play
        gameState = 'end'
    end 
end

-- Table for sounds
sound = {
    ['hit'] = love.audio.newSource('sounds/hit.wav', 'static'),
    ['point_gain'] = love.audio.newSource('sounds/point_gain.wav', 'static'),
    ['win'] = love.audio.newSource('sounds/win.wav', 'static')
}