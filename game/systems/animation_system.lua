local Object = require("lib.classic")
local AnimationSystem = tiny.processingSystem(Object:extend())

function AnimationSystem:new()
    self.filter = tiny.requireAll("sprite")
end

function AnimationSystem:process(e, dt)
    local an = e.sprite.animation
    if (an) then
        an:update(dt)
        if (an.status == "paused" and e.onAnimationComplete) then
            e:onAnimationComplete(an)
        end
    end
end
    
return AnimationSystem