local Object = require("lib.classic")
local LifetimeSystem = tiny.processingSystem(Object:extend())


function LifetimeSystem:new()
    self.filter = tiny.requireAll("lifetime")
end

function LifetimeSystem:process(e, dt)
    e.lifetime = e.lifetime - dt
    if (e.lifetime <= 0) then 
        game.registry:remove(e)
    end
end

return LifetimeSystem