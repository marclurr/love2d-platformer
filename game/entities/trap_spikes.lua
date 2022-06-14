local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local TrapSpikes = Object:extend()


function TrapSpikes:new(x, y, up)
    up = up or false
    self.name = "Spikes"
    Components.position(self, x, y)
    Components.hitbox(self, 16, 4)
    Components.sprite(self, assets.sprites.spikes_small)
    Components.causesDamage(self, Damage.kill, Predicates.isPlayer)
   
    if (up) then 
        self.position.y = y - self.hitbox.h
        self.sprite.oy = 5
        self.sprite.sy = -1
    end   
end

return function(layer, obj) 
    local x, y = obj.x, obj.y
    local num = obj.polyline[#obj.polyline].x / CELL_SIZE
    
    local traps = {}
    
    local i = 0
   
    for i=1,num do
        table.insert(traps, TrapSpikes(x + ((i-1) * CELL_SIZE), y, obj.properties.direction == "up" ))
    end
    
    return traps, num
end