-- Class for Bird


Bird = class{}

gravity = 5
local anti_gravity = -2.3
-- Initializer function for bird
function Bird: init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = VIRTUAL_WIDTH / 2 - self.width / 2
    self.y = VIRTUAL_HEIGHT / 2 - self.height / 2
    self.dy = 0
end
-- Render function for bird
function Bird: render()
    love.graphics.draw(self.image, self.x, self.y)
end 
-- Update function for bird 
function Bird: update(dt)
    self.dy = self.dy + gravity * dt
    if love.keyboard.wasPressed('space') == 'space' then 
        sounds['jump']:play()
        self.dy = anti_gravity 
    end 
    if love.keyboard.wasPressed('up') == 'up' then 
        sounds['jump']:play()
        self.dy = anti_gravity 
    end
    self.y = self.y + self.dy  
    if self.y >= VIRTUAL_HEIGHT - 40 then 
        self.y = VIRTUAL_HEIGHT - 40
        self.dy = 0
        sounds['end']:play()
        gState:change('end')
    end
end 

