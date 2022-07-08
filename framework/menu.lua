local Object = require("lib.classic")
local Menu = Object:extend()

function Menu:new()
    self.current = 1
    self.elements = {}
    self.justify = "centre"
end

function Menu:getHeight()
    local height = 0
    for i=1,#self.elements do
        local element = self.elements[i]
        height = height + element:getHeight()
    end
    return height
end

function Menu:addElement(element)
    table.insert(self.elements, element)
end

function Menu:reset()
    self.current = 1
    if (not self.elements[self.current].enabled ) then
        self:next()
    end
end

function Menu:next()
    local i = (self.current - 1) + 1

    self.current = (i % #self.elements) + 1 
    if (not self.elements[self.current].enabled ) then
        self:next()
    end
end

function Menu:previous()
    if (self.current == 1) then 
        self.current = #self.elements
    else
        self.current = self.current - 1
    end

    if (not self.elements[self.current].enabled ) then
        self:previous()
    end
end

function Menu:update(dt)
    local element = self.elements[self.current]
    -- local d = 0
    -- while element.enabled == false do
    --     if (d == #self.elements) then
    --         error("All elements of menu disabled!")
    --     end
    --     self:next()
    --     element = self.elements[self.current]
    --     d = d + 1
    -- end

end

function Menu:accept()
    local element = self.elements[self.current]
    element:accept()
end

function Menu:draw(y)
    if (self.justify == "centre") then
        local mid = DRAW_WIDTH / 2
        local top = y
        for i=1,#self.elements do
            local element = self.elements[i]
            
            local elWidth = element:getWidth()
            local x =  elWidth / 2

            element:draw(i == self.current, mid - x, top)

            top = top + element:getHeight()
        end
    elseif (self.justify == "left") then
        local width = 0
        for i=1,#self.elements do
            local element = self.elements[i]
            
            local elWidth = element:getWidth()

            if (elWidth > width) then 
                width = elWidth
            end
        end

        local mid = DRAW_WIDTH / 2
        local x = mid - (width / 2)
        local top = y
        for i=1,#self.elements do
            local element = self.elements[i]
            element:draw(i == self.current, x, top)

            top = top + element:getHeight()
        end

    end
end

-- function Menu:draw()
--     print("there")
--     self:draw(0)
-- end

-- menu stack

local MenuStack = Object:extend()

function MenuStack:new()
    self.stack = {}
end

function MenuStack:clear()
    self.stack = {}
end

function MenuStack:empty()
    return #self.stack == 0
end

function MenuStack:push(menu)
    table.insert(self.stack, menu)
    menu:reset()
end

function MenuStack:pop()
    table.remove(self.stack, #self.stack)
end

function MenuStack:update(dt)
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:update(dt)
end


function MenuStack:getHeight()
   if (#self.stack == 0) then return end
    return self.stack[#self.stack]:getHeight()
end

function MenuStack:draw(top)
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:draw(top)
end

function MenuStack:draw()
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:draw()
end

function MenuStack:accept()
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:accept()
end

function MenuStack:next()
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:next()
end

function MenuStack:previous()
   if (#self.stack == 0) then return end
    self.stack[#self.stack]:previous()
end

return {
    Menu = Menu,
    MenuStack = MenuStack
}
