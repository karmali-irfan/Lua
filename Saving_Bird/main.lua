-- All designs (including the backgound, the poles and the ground) are credited to EnzyMaine. 
-- All code was written by Irfan Karmali with the aid of an edX course. 

WIDTH = 1280
HEIGHT = 720
VIRTUAL_HEIGHT = 288
VIRTUAL_WIDTH = 512

push = require 'push'
class = require 'class'
require 'Bird'
require 'Pole'
require 'states/StartState'
require 'states/PlayState'
require 'states/State'
require 'states/EndGameState'

-- Local variable can only be accessed within this file
local background = love.graphics.newImage('bg.png') -- background image
local g_image = love.graphics.newImage('g.png') -- ground image
local BG_POSITION = 0
local G_POSITION = 0
-- Declaring bird 
bird = Bird()

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Saving Bird by Irfan Karmali')
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WIDTH, HEIGHT,{ -- Function to setup screen
        vsync = true,
        resizable = true, 
        fullscreen = false
    })
    love.keyboard.keysPressed = {} -- Creating a table to track keys pressed
    small_font = love.graphics.newFont('flappy.ttf', 10)
    score_font = love.graphics.newFont('flappy.ttf', 25)
    gState = State{
        ['start'] = function() return StartState() end, 
        ['play'] = function() return PlayState() end,
        ['end'] = function() return EndGameState() end,
    }
    gState:change('start')
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'), 
        ['point'] = love.audio.newSource('sounds/point.wav', 'static'), 
        ['end'] = love.audio.newSource('sounds/end.wav', 'static'), 
        ['loop'] = love.audio.newSource('sounds/loop.mp3', 'static')
    }
        sounds['loop']:setLooping(true)
        sounds['loop']:play()
end 

function love.resize(w, h)
    push: resize(w, h)
end


function love.keypressed(key) 
    love.keyboard.keysPressed[key] = key 
    if key == 'escape' then 
        love.event.quit()
    end 
    if key == 'space' then 
        gState:change('play') -- changing the state to play
    end 
    if key == 'enter' or key == 'return' then 
        poles = {}
        gState:change('start')
    end 
end 

-- Our function definition within keyboard 
function love.keyboard.wasPressed(key) 
    if bird.y < VIRTUAL_HEIGHT - 40  then 
        return love.keyboard.keysPressed[key] 
    end
end

function love.draw()
    push:start()
    love.graphics.draw(background, -BG_POSITION, 0)
    gState:render()
    love.graphics.draw(g_image, -G_POSITION, VIRTUAL_HEIGHT - 16)
    push:finish()
end

function love.update(dt) 
    BG_POSITION = (BG_POSITION + BG_SPEED * dt) % 413
    G_POSITION = (G_POSITION + G_SPEED * dt) % VIRTUAL_WIDTH
    gState:update(dt)
    love.keyboard.keysPressed = {} -- Resetting the table after every frame
end

