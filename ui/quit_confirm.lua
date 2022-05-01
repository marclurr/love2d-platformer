local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local QuitConfirm = Menu.Menu:extend()
function QuitConfirm:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("No", function() pause:back() end))
    self:addElement(MenuElement.TextMenuElement("Yes", function()
        Gamestate.switch(title)
    end))
end

function QuitConfirm:draw()
    centreText("Quit, are you sure?", 0, 32)

    local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, menuY)
end

quitConfirmMenu = QuitConfirm()