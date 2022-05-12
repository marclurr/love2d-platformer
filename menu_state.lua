local Object = require("lib.classic")
local BaseState = require("base_state")

local MenuState = BaseState:extend()

function MenuState:new(startMenu)
    BaseState.new(self)
    self.startMenu = startMenu
    self.super.registerPressEventHandler(self,"ui_cancel", self.back)
    self.super.registerPressEventHandler(self, "down", self.next)
    self.super.registerPressEventHandler(self, "up", self.previous)
    self.super.registerPressEventHandler(self,"ui_accept", self.accept)
end

function MenuState:enter()
    menuStack:clear()
    menuStack:push(self.startMenu)
end

function MenuState:next()
    menuStack:next()
end

function MenuState:previous()
    menuStack:previous()
end

function MenuState:accept() 
    menuStack:accept()
end

function MenuState:back()
    menuStack:pop()
    if (menuStack:empty()) then
        -- "consume" input by 
        self.super.updateInput(self)
        Gamestate.pop()
    end
end

function MenuState:update(dt)
    menuStack:update(dt)
end

function MenuState:draw()
    love.graphics.setColor(0, 0, 0, 0.8)
    love.graphics.rectangle("fill", 0, 0, DRAW_WIDTH, DRAW_HEIGHT)

    love.graphics.setColor(1, 1, 1, 1)
    menuStack:draw()
end

return MenuState