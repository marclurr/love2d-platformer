local Object = require("lib.classic")
local AnimationSystem = tiny.processingSystem(Object:extend())
AnimationSystem.isDrawSystem = true

function AnimationSystem:new()
    self.filter = tiny.requireAll("sprite", "animation")
end

function AnimationSystem:process(e, dt)
    local nextAnimation = e.animation.nextAnimation
    local sprite = e.sprite
    -- get next animation
    if (nextAnimation) then
        local next = nextAnimation(e, dt)
        if (next ~= sprite.animation) then 
            next:reset()
            e.sprite.animation = next
        end
    end

    -- update animation
    local an = e.sprite.animation
    if (an) then
        an:update(dt)
        if (an.status == "paused" and e.onAnimationComplete) then
            e:onAnimationComplete(an)
        end
    end
end
    
return AnimationSystem