local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local TitleMenu = Menu.Menu:extend()

function TitleMenu:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("Continue"):disable())
    self:addElement(MenuElement.TextMenuElement("New Game", function() 
        Gamestate.switch(game, levels.debug)
    end))

    self:addElement(MenuElement.TextMenuElement("Quit", love.event.quit))
end

function TitleMenu:draw()
    
    centreText("Game Name: The Revenge", -1, 16)
    centreText("Game Name: The Revenge", 1, 16)
    centreText("Game Name: The Revenge", 0, 16)
    -- local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 100)
    -- self.super.draw(self, 64)
end

titleMenu = TitleMenu()