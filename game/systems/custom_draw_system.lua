local Object = require("lib.classic")
local CustomDrawSystem = tiny.processingSystem(Object:extend())
CustomDrawSystem.isDrawSystem = true
CustomDrawSystem.drawWhenPaused = true

function CustomDrawSystem:new()
    self.filter = tiny.requireAll("draw")
end

function CustomDrawSystem:process(e, dt)
    if (type(e.draw) == "function") then 
        e:draw()
    end

end

return CustomDrawSystem