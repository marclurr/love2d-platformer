local Menu = require("framework.menu")

menuStack = Menu.MenuStack()
function pushMenu(menu)
    return function()
        menuStack:push(menu)
    end
end

-- order is significant
optionsMenu= require("ui.options_menu")
quitConfirmMenu = require("ui.quit_confirm")
pauseMainMenu = require("ui.pause_menu")
titleMenu = require("ui.title_menu")