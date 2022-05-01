local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local PauseMain = Menu.Menu:extend()

function PauseMain:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("Continue", function() pause:back() end))
    self:addElement(MenuElement.TextMenuElement("Options", function() menuStack:push(optionsMenu) end))
    self:addElement(MenuElement.TextMenuElement("Quit", function()
        menuStack:push(quitConfirmMenu)
    end))
end

function PauseMain:draw()
    centreText("- PAUSED -", 0, 32)

    local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 64)
    -- self.super.draw(self, 64)
end

pauseMainMenu = PauseMain()