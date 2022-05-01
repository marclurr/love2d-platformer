local Object = require("lib.classic")
local MenuState = require("menu_state")

local PauseState = MenuState:extend()

function PauseState:new()
    self.super.new(self, pauseMainMenu)
end

function PauseState:draw()
    game:draw()

    MenuState.draw(self)
end

return PauseState