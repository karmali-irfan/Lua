-- Class for Pole 

Pole = class{}

local P_IMAGE = love.graphics.newImage('pole.png')
P_SCROLL = 60
local timer = 0
poles = {}

function Pole: init() -- initializer function
    self.image = P_IMAGE
    self.y = math.random(VIRTUAL_HEIGHT / 2, VIRTUAL_HEIGHT - 40)
    self.width = self.image: getWidth()
    self.height = self.image: getHeight()
    self.x = VIRTUAL_WIDTH + self.width
    self.score = false
end 

function Pole:update(dt)
    timer = timer + dt
    if timer > 3 then -- inserting poles onto the screen
        table.insert(poles, Pole())
        timer = 0
    end
    for key, pole in pairs(poles) do -- moving the poles 
        pole.x = pole.x - P_SCROLL * dt
        if pole.x < 0 then
            table.remove(poles, key)
        end
    end 
    for key, pole in pairs(poles) do -- detecting collision between the poles and the bird
        pole:collision(bird, pole) 
    end
end 

function Pole:render()    
    love.graphics.draw(self.image, self.x, self.y - 70, 0, 1, -1) -- Upper Pole
    love.graphics.draw(self.image, self.x, self.y) -- Lower Pole
end 

function Pole:collision(bird, pole) -- Collision function. 
    if bird.y + bird.height - 4 < pole.y  and bird.y + 4 > pole.y - 70 then  
    elseif bird.x + bird.width - 4 < self.x or bird.x + 4 > self.x + self.width then 
    else 
        sounds['end']:play()
        gState:change('end')
    end
end
 