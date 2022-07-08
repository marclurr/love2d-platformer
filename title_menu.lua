local Object = require("lib.classic")
local MenuState = require("menu_state")
local Menu = require("framework.menu")
local MenuElement = require("framework.menu_element")

local TitleState = MenuState:extend()

function TitleState:new()
    MenuState.new(self, titleMenu)

end

return TitleState