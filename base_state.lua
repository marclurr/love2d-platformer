local Object = require("lib.classic")

local BaseState = Object:extend()

function BaseState:new()
    self.releaseEventHandlers = {}
    self.pressEventHandlers = {}
end

function BaseState:registerReleaseEventHandler(event, fn)
    self.releaseEventHandlers[event] = fn
end

function BaseState:registerPressEventHandler(event, fn)
    self.pressEventHandlers[event] = fn
end


function BaseState:update(dt)
    self:updateInput()
end

function BaseState:updateInput()
    for k, b in pairs(input) do
        b:update()
    end
end

function BaseState:keyreleased(key)
    if (inputMap.keyboard[key]) then
        for _, b in ipairs(inputMap.keyboard[key]) do
           b:release()
           if (self.releaseEventHandlers[b.name]) then
                self.releaseEventHandlers[b.name](self)
           end
        end
    end

end

function BaseState:keypressed(key)
    if (inputMap.keyboard[key]) then
        for _, b in ipairs(inputMap.keyboard[key]) do
           b:press()
           if (self.pressEventHandlers[b.name]) then
            self.pressEventHandlers[b.name](self)
            end
        end
    end
end


function BaseState:gamepadpressed(j, button)
    if (inputMap.gamepad[button]) then
        for _, b in ipairs(inputMap.gamepad[button]) do
            b:press()
            if (self.pressEventHandlers[b.name]) then
             self.pressEventHandlers[b.name](self)
             end
         end
        
    end
end


function BaseState:gamepadreleased(j, button)
    if (inputMap.gamepad[button]) then
        for _, b in ipairs(inputMap.gamepad[button]) do
            b:release()
            if (self.releaseEventHandlers[b.name]) then
             self.releaseEventHandlers[b.name](self)
             end
         end
    end
end

return BaseState