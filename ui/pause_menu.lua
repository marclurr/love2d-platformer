local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local PauseMain = Menu.Menu:extend()

function PauseMain:new()
    self.super.new(self)
    self:addElement(MenuElement.TextMenuElement("Continue", function() pause:back() end))
    self:addElement(MenuElement.TextMenuElement("Options", pushMenu(optionsMenu)))
    self:addElement(MenuElement.TextMenuElement("Quit", pushMenu(quitConfirmMenu)))
end

function PauseMain:draw()
    centreText("- PAUSED -", 0, 32)

    local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 64)
end

return PauseMain()