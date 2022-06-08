local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local AnimatedSprite = Object:extend()

function AnimatedSprite:new(spritesheet)
    self.spritesheet = spritesheet
    self.animations = {}
    
end

function AnimatedSprite:addAnimation(name, animation)

end

function AnimatedSprite:play(newAnim, force)
    if (force or newAnim ~= self.anim) then
        self.anim = newAnim
        self.anim:reset()
    end
end

function AnimatedSprite:update(dt)
    self.anim.flippedH = self.flippedH
    self.anim:update(dt)
    if (self.anim.status == "paused" and self.delegate and self.delegate.animationComplete) then
        self.delegate.animationComplete(self.delegate, self.anim)
    end
end


return AnimatedSprite