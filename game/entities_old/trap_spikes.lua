local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local TrapSpikes = Object:extend()

function TrapSpikes:new(x, y, dir)
    self.x = x --+1
    self.y = y
    self.w = 16
    self.h = 5
    self.sy = 1
    
    self.oy = 0
    self.ox = 0
    if (dir == "up") then
        self.sy = -1
        self.y = self.y - self.h
        self.oy = 5
    end


    self.spritesheet = assets.sprites.spikes_small
    

    self.debugLabel = "danger"

end

function TrapSpikes:beforeAdd()
    game.world:add(self, self.x, self.y, self.w, self.h)
end

function TrapSpikes:beforeRemove()
    game.world:remove(self)
end

function TrapSpikes:update(dt)
    -- self.anim:update(dt)
    local _, _, cols, len = game.world:check(self, self.x, self.y, function(item, other)
        if (other == game.player) then
            return "cross"
        end
        return nil
    end)

    if (len > 0 and not game.player:isDead()) then
        game.player:kill()
    end
end

function TrapSpikes:draw()
    love.graphics.draw(self.spritesheet, self.x+self.ox, self.y+self.oy, 0, 1, self.sy)
end

return function(layer, obj) 
    local x, y = obj.x, obj.y
    local num = obj.polyline[#obj.polyline].x / CELL_SIZE
    
    local traps = {}
    
    local i = 0
   
    for i=1,num do
        table.insert(traps, TrapSpikes(x + ((i-1) * CELL_SIZE), y, obj.properties.direction ))
    end
    
    return traps, num
end