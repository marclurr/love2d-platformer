local Object = require("lib.classic")
local TriggerSystem = tiny.processingSystem(Object:extend())

local function filter(item, other)
    if (other.isPlayer) then
        return "cross"
    end
    return nil
end

function TriggerSystem:new()
    self.filter = tiny.requireAll("position", "hitbox", "trigger")
end

function TriggerSystem:process(e, dt)
    local pos = e.position
    local overlappingObjs = e.trigger.overlappingObjs
    local filter = e.trigger.filter

    local _, _, cols, len = game.world:check(e, pos.x, pos.y, filter)

    local currentCollisions = {}

   
    for i=1,len do
        local obj = cols[i].other
        currentCollisions[obj] = obj
        if (not overlappingObjs[obj]) then
            overlappingObjs[obj] = obj
            if (e.onTriggerEntered) then
                e:onTriggerEntered(obj)
            end
        end
    end
    

    for k,obj in pairs(overlappingObjs) do
        if (not currentCollisions[obj]) then
            overlappingObjs[k] = nil
            if (e.onTriggerExited) then
                e:onTriggerExited(obj)
            end
        end
    end
end
    
return TriggerSystem