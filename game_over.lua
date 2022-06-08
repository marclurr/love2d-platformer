local Object = require("lib.classic")
local MenuState = require("menu_state")

local GameOverState = MenuState:extend()

function GameOverState:new()
    self.super.new(self, gameOverMenu)
end

function GameOverState:draw()
    game:draw()

    MenuState.draw(self)
end

return GameOverState