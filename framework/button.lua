local Object = require("lib.classic")
local Button = Object:extend()

function Button:new()
    self.pressed = false
    self.wasPressed = false
end

function Button:intValue()
    return self.pressed and 1 or 0
end

function Button:press()
    self.pressed = true
end

function Button:release()
    self.pressed = false
end

function Button:update()
    self.wasPressed = self.pressed
end

function Button:justPressed()
    return self.wasPressed == false and self.pressed == true
end

function Button:justReleased()
    return self.wasPressed == true and self.pressed == false
end

return Button