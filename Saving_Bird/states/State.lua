-- Class for States

State = class{}


function State:init(state)
    self.empty = {
        render = function() end,
        update = function () end,
        enter = function () end,
        exit = function () end 
    } 
    self.states = state or {}
    self.current = self.empty
end 

function State:change(state) 
    self.current = self.states[state]()
end

function State:render()
    self.current:render()
end 

function State:update(dt)
    self.current:update(dt)
end

