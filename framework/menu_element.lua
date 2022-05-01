local Object = require("lib.classic")
local MenuElement = Object:extend()

function MenuElement:new(fn)
    if (not fn) then 
        fn = function() 
            print("no action for menu item " .. tostring(self))
        end
    end
    self.fn = fn
    self.enabled = true
end

function MenuElement:enable()
    self.enabled = true
    return self
end

function MenuElement:disable()
    self.enabled = false
    return self
end

function MenuElement:getWidth()
    return 0
end

function MenuElement:getHeight()
    return 0
end

function MenuElement:draw(selected, x, y)
    local colour = {1, 1, 1, 1}
    if (selected) then
        colour = {1, 1, 0, 1}
    end

    if (self.enabled == false) then
        colour = {0.6, 0.6, 0.6, 1}
    end
    love.graphics.setColor(colour)
end

function MenuElement:accept()
    self.fn()
end

local TextMenuElement = MenuElement:extend()

function TextMenuElement:new(text, fn)
    self.super.new(self, fn)
    self.text = text
end

function TextMenuElement:__tostring()
    return self.text
end

function TextMenuElement:getWidth()
    return fnt:getWidth(self.text)
end

function TextMenuElement:getHeight()
    return fnt:getHeight()
end

function TextMenuElement:draw(selected, x, y)
    MenuElement.draw(self, selected, x, y)
    
    love.graphics.print(self.text, fnt, x, y)
end


-- option menu element

local OptionMenuElement = MenuElement:extend()

function OptionMenuElement:new(text, values, selected)
    self.super.new(self, fn)
    self.text = text
    self.values = values
    self.selected = selected
end

function OptionMenuElement:__tostring()
    return self.text
end

function OptionMenuElement:getWidth()
    return fnt:getWidth(self.text)
end

function OptionMenuElement:getHeight()
    return fnt:getHeight()
end

function OptionMenuElement:draw(selected, x, y)
    MenuElement.draw(self, selected, x, y)

    love.graphics.print(self.text, fnt, x, y)
end




return {
    TextMenuElement = TextMenuElement,
    OptionMenuElement = OptionMenuElement
}




