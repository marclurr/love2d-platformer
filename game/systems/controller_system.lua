local Object = require("lib.classic")
local ControllerSystem = tiny.processingSystem(Object:extend())

function ControllerSystem:new()
    self.filter = tiny.requireAll("controller")
end

function ControllerSystem:process(e, dt)
    e.controller.logic(e, dt)
end

return ControllerSystem