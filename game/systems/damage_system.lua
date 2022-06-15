local Object = require("lib.classic")
local DamageSystem = tiny.processingSystem(Object:extend())

function DamageSystem:new()
    self.filter = tiny.requireAll("causesDamage", "position",  "hitbox")
end

function DamageSystem:process(e, dt)
    local pos = e.position
    local filter = e.causesDamage.filter
    local damageFn = e.causesDamage.damageFn

    local _, _, cols, len = game.world:check(e, pos.x, pos.y, filter)

    for i=1,len do
        local obj = cols[i].other
        if (obj.health and obj.health.current > 0 and obj.health.invincible == 0 ) then
            local damageAmount = damageFn(obj)
            if (damageAmount > 0) then
                obj.health.current = obj.health.current - damageAmount

                if (obj.onDamageTaken) then
                    local dir =  e.causesDamage.direction 
                    print(dir)
                    if (dir == nil or dir == 0) then 
                        if (pos.x < obj.position.x) then 
                            dir = 1
                        elseif (pos.x >= obj.position.x) then
                            dir = -1
                        end
                    end
                    obj:onDamageTaken(e, damageAmount, dir)
                end

                if (e.causesDamage.onHit) then 
                    e.causesDamage.onHit(e)         
                end
            end
        end
    end

end


return DamageSystem
