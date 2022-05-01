local Object = require("lib.classic")
local BaseState = require("base_state")



local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local TitleMenu = BaseState:extend()

function TitleMenu:new()
    self.super.new(self)

    self.menu = Menu()
    self.menu:addElement(MenuElement.TextMenuElement("Continue"):disable())
    self.menu:addElement(MenuElement.TextMenuElement("New Game", function() 
        Gamestate.switch(game, levels.debug)
    end))

    self.super.registerPressEventHandler(self, "down", self.next)
    self.super.registerPressEventHandler(self, "up", self.previous)
    self.super.registerPressEventHandler(self,"ui_accept", self.accept)
end

function TitleMenu:next()
    self.menu:next()
end

function TitleMenu:previous()
    self.menu:previous()
end

function TitleMenu:accept() 
    self.menu:accept()
end

function TitleMenu:startGame()
    Gamestate.switch(game, levels.debug)
end

function TitleMenu:update(dt)
    self.menu:update(dt)
end

function TitleMenu:draw()
    self.menu:draw(100)
end

return TitleMenu