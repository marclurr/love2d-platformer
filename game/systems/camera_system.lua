local Object = require("lib.classic")
local CameraSystem = tiny.processingSystem(Object:extend())

function CameraSystem:new()
    self.filter = tiny.requireAll("position", "isPlayer")
end

function CameraSystem:process(e, dt)
    local pos = e.position

    local cx = game.camera.pos.x 
    local cy = game.camera.pos.y

    cx = cx + ((pos.x - cx) * 8 * dt)
    cy = cy + ((pos.y - cy) * 8 * dt)


    game.camera:setPosition(cx, cy)
end
    
return CameraSystem