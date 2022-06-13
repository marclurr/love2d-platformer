local Object = require("lib.classic")
local SpriteSystem = tiny.sortedProcessingSystem(Object:extend())
SpriteSystem.isDrawSystem = true
SpriteSystem.drawWhenPaused = true

function SpriteSystem:new()
    self.filter = tiny.requireAll("position", "sprite")
end

function SpriteSystem:compare(l, r)
    return r.isPlayer == true
end

function SpriteSystem:process(e, dt)
    local pos = e.position
    local an = e.sprite.animation
    local spritesheet = e.sprite.spritesheet
    local ox = e.sprite.ox or 0
    local oy = e.sprite.oy or 0
    local sx = e.sprite.sx or 1
    local sy = e.sprite.sy or 1

    
    love.graphics.setShader(e.sprite.shader)
    love.graphics.setColor(e.sprite.mod)
    if (an) then 
        an.flippedH = e.sprite.flippedH or false
        
        an:draw(spritesheet, pos.x, pos.y, 0, sx, sy , ox, oy)
    else
        love.graphics.draw(spritesheet, pos.x, pos.y, 0, sx, sy, ox, oy)
    end

    love.graphics.setShader()
    love.graphics.setColor(1, 1, 1, 1)
end
    
return SpriteSystem