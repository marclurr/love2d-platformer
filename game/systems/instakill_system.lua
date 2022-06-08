local Object = require("lib.classic")
local InstaKillSystem = tiny.processingSystem(Object:extend())

local function filter(item, other)
    if (other.isPlayer) then
        return "cross"
    end
    return nil
end

function InstaKillSystem:new()
    self.filter = tiny.requireAll("position", "hitbox", "instaKill")
end

function InstaKillSystem:process(e, dt)
    local pos = e.position
    local _, _, cols, len = game.world:check(e, pos.x, pos.y, filter)
    if (len > 0) then 
        game.player.health.current = 0
    end
end
    
return InstaKillSystem