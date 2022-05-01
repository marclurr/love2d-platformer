local Object = require("lib.classic")
local Menu = Object:extend()

function Menu:new()
    self.current = 1
    self.elements = {}
end

function Menu:addElement(element)
    table.insert(self.elements, element)
end

function Menu:next()
    local i = (self.current - 1) + 1

    self.current = (i % #self.elements) + 1 
end

function Menu:previous()
    if (self.current == 1) then 
        self.current = #self.elements
    else
        self.current = self.current - 1
    end
end

function Menu:update(dt)
    local element = self.elements[self.current]
    local d = 0
    while element.enabled == false do
        if (d == #self.elements) then
            error("All elements of menu disabled!")
        end
        self:next()
        element = self.elements[self.current]
        d = d + 1
    end
end

function Menu:accept()
    local element = self.elements[self.current]
    element:accept()
end

function Menu:draw(y)
    local mid = DRAW_WIDTH / 2
    local top = y
    for i=1,#self.elements do
        local element = self.elements[i]
        
        local elWidth = element:getWidth()
        local x =  elWidth / 2

        element:draw(i == self.current, mid - x, top)

        top = top + element:getHeight()
    end

   
end

return Menu