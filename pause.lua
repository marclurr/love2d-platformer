local Object = require("lib.classic")
local MenuState = require("menu_state")

local PauseState = MenuState:extend()

function PauseState:new()
    self.super.new(self, pauseMainMenu)
end

function PauseState:back()
    menuStack:pop()
    if (menuStack:empty()) then
        -- "consume" input by 
        self.super.updateInput(self)
        Gamestate.pop()
    end
end

function PauseState:draw()
    game:draw()

    MenuState.draw(self)
end

return PauseState