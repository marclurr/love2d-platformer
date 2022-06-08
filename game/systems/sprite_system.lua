local Object = require("lib.classic")
local SpriteSystem = tiny.processingSystem(Object:extend())
SpriteSystem.isDrawSystem = true

function SpriteSystem:new()
    self.filter = tiny.requireAll("position", "sprite")
end

function SpriteSystem:process(e, dt)
    local pos = e.position
    local an = e.sprite.animation
    local spritesheet = e.sprite.spritesheet
    local ox = e.sprite.ox or 0
    local oy = e.sprite.oy or 0
    local sx = e.sprite.sx or 1
    local sy = e.sprite.sy or 1
    if (an) then 
        an.flippedH = e.sprite.flippedH or false
        
        an:draw(spritesheet, pos.x, pos.y, 0, sx, sy , ox, oy)
    else
        love.graphics.draw(spritesheet, pos.x, pos.y, 0, sx, sy, ox, oy)
    end
end
    
return SpriteSystem