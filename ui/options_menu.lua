local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local OptionsMenu = Menu.Menu:extend()

function OptionsMenu:new()
    self.super.new(self)

    self:addElement(MenuElement.TextMenuElement("Fullscreen", toggleFullscreen))
    self:addElement(MenuElement.TextMenuElement("Debug", function()
        programSwitches.debug = not programSwitches.debug
    end))
    self:addElement(MenuElement.TextMenuElement("Back", function()  menuStack:pop() end))

end

function OptionsMenu:draw()
    centreText("- OPTIONS -", 0, 32)

    local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 64)
end

return OptionsMenu()