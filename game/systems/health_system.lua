local Object = require("lib.classic")
local HealthSystem = tiny.processingSystem(Object:extend())

function HealthSystem:new()
    self.filter = tiny.requireAll("health")
end

function HealthSystem:process(e, dt)
    local health = e.health
    health.invincible = math.max(0, health.invincible - dt)
    if (health.current <= 0 and health.previous > 0 and e.onHealthDepleted) then
        e:onHealthDepleted()
    end
    health.previous = health.current
end
    
return HealthSystem