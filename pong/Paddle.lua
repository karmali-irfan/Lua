-- Pong by Irfan Karmali
-- 28.12.2021
-- Paddle Class for Pong 


Paddle = class{}

paddle_speed = 200

-- Initializer function to call everything you want, Lua's version of a parametric constructor
function Paddle:init (x, y, width, height, up, down) 
    self.x = x
    self.y = y
    self.width =width
    self.height = height
    self.up = up
    self.down = down
end 

-- Render function --> Renders or draws
function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 

-- Update function
function Paddle:update(dt)
    if love.keyboard.isDown(self.down) then
        self.y = math.min(VIRTUAL_HEIGHT - 30, self.y + paddle_speed * dt)
    end
    if love.keyboard.isDown(self.up) then
        self.y = math.max(0, self.y - paddle_speed * dt)
    end
end