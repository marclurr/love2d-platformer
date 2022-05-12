local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local TitleMenu = Menu.Menu:extend()

function TitleMenu:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("Continue"):disable())
    self:addElement(MenuElement.TextMenuElement("New Game", function() 
        Gamestate.switch(game, levels.debug)
    end))
    self:addElement(MenuElement.TextMenuElement("Options", pushMenu(optionsMenu)))
    self:addElement(MenuElement.TextMenuElement("Quit", love.event.quit))
end

function TitleMenu:draw()
    local text = "Micro Metroidvania Prototype"

    love.graphics.setColor(0.5,0.3,0.0,1)
    centreText(text, -1, 16)
    centreText(text, -1, 15)
    centreText(text, -1, 17)
    centreText(text, 1, 16)
    centreText(text, 1, 15)
    centreText(text, 1, 17)
    
    centreText(text, 0, 15)
    centreText(text, 0, 17)
    love.graphics.setColor(0.0, 0.0, 0.0, 1)
    centreText(text, 0, 16)
    -- local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 100)
    -- self.super.draw(self, 64)
end

return TitleMenu()