local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local TitleMenu = Menu.Menu:extend()

function TitleMenu:new()
    self.super.new(self)

    self.t = 0
    self.y = 0
    self:addElement(MenuElement.TextMenuElement("Continue"):disable())
    self:addElement(MenuElement.TextMenuElement("New Game", function() 
        title.super.updateInput(title)
        Gamestate.switch(game, levels.debug)
    end))
    self:addElement(MenuElement.TextMenuElement("Options", pushMenu(optionsMenu)))
    self:addElement(MenuElement.TextMenuElement("Quit", love.event.quit))
end

function TitleMenu:update(dt)
    self.super.update(self, dt)

    self.t = self.t + dt
    self.y = math.sin(self.t * 3) * 8
end

function TitleMenu:draw()
    local text = "Mushroom Massacre"

    love.graphics.setColor(189/255, 0, 0,1)
    centreText(text, -1, 16 + self.y)
    centreText(text, -1, 15 + self.y)
    centreText(text, -1, 17 + self.y)
    centreText(text, 1, 16 + self.y)
    centreText(text, 1, 15 + self.y)
    centreText(text, 1, 17 + self.y)
    
    centreText(text, 0, 15 + self.y)
    centreText(text, 0, 17 + self.y)
    love.graphics.setColor(1, 1, 1, 1)
    centreText(text, 0, 16 + self.y)
    -- local menuY = (DRAW_HEIGHT /2) - (self.super.getHeight(self) / 2)
   
    self.super.draw(self, 100)
    -- self.super.draw(self, 64)
end

return TitleMenu()