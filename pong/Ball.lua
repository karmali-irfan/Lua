-- Pong by Irfan Karmali
-- 28.12.2021
-- Paddle Class for Ball 

--Declaring ball as a class, creating a class like we do in C
Ball = class{}

-- Initializer function for the ball
function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
end 
-- Function to reset the ball
function Ball:reset() 
    self.x = VIRTUAL_WIDTH / 2 - 2.5
    self.y = VIRTUAL_HEIGHT / 2 - 2.5
end
-- Function to move the ball 
function Ball:update(dt)
    if gameState == 'start' then
        ball_dx = math.random(2) == 1 and 100 or - 100 
        ball_dy = math.random(-50, 50)
        self:reset() -- You're asking the class 'self' which is the name in the main to reset
    elseif gameState == 'play' then 
        self.x = self.x + ball_dx * dt
        self.y = self.y + ball_dy * dt
        if self:collision(paddle_right) then -- Collision with right paddle
            sound.hit:play()
            ball_dx = -ball_dx * 1.05
            self.x = self.x - 4
            ball_dy = math.random(-50, 50) * (ball_dy / ball_dy)  --changing the angle of reflection from the paddles
        elseif self:collision(paddle_left) then -- Collision with left paddle
            sound.hit:play() --Calling the sound to play
            ball_dx = -ball_dx * 1.2
            self.x = self.x + 5
            ball_dy = math.random(-50, 50) * (ball_dy / ball_dy) --Multiplying by (ball_dy / ball_dy) will help maintain y-direction
        end
        if self.y >= VIRTUAL_HEIGHT - 5 then  -- Collision with upper boundary
            sound.hit:play() --Calling the sound to play
            self.y = VIRTUAL_HEIGHT - 5
            ball_dy = - ball_dy
        end
        if self.y <= 0 then -- Collision with lower boundary
            sound.hit:play() --Calling the sound to play
            self.y = 0
            ball_dy = -ball_dy
        end
        if ball.x <= 0 then  -- Point gain for right paddle
            score_right = score_right + 1
            sound['point_gain']:play()
            ball:reset()
            gameState ='start'
            
        end 
        if ball.x > VIRTUAL_WIDTH then -- Point gain for left paddle
            score_left = score_left + 1
            sound['point_gain']:play()
            ball:reset()
            gameState ='start'
        end
    end
end 
-- Function to render the ball
function Ball:render() 
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end 
--Function to detect collisions 
function Ball:collision(Paddle)
    --Horizontal 
    if self.x > Paddle.x + Paddle.width or self.x + self.width < Paddle.x then
        return false 
    elseif self.y > Paddle.y + Paddle.height or self.y + self.height < Paddle.y then
        return false   
    else 
        return true
    end
end


