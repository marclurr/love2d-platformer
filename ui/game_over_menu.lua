local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local GameOver = Menu.Menu:extend()
function GameOver:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("Yes", function() 
        Gamestate.switch(game, game.currentLevel)
    end))
    self:addElement(MenuElement.TextMenuElement("No", function()
        Gamestate.switch(title)
    end))
end

function GameOver:draw()
    centreText("Game Over, try again?", 0, 32)

    local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, menuY)
end

return GameOver()