local Object = require("lib.classic")
local PlatformingAnimationSystem = tiny.processingSystem(Object:extend())

function PlatformingAnimationSystem:new()
    self.filter = tiny.requireAll("platforming_animation", "platforming", "physics", "sprite", "velocity")
end

function PlatformingAnimationSystem:process(e, dt)
    local pan = e.platforming_animation
    local platforming = e.platforming
    local vel = e.velocity
    local an = e.sprite
    local physics = e.physics

    if (physics.onGround) then
        if (physics.onWall) then
            an.animation = pan.push
        else 
            if (vel.x ~= 0) then
                an.animation = pan.run
            else
                an.animation = pan.idle
            end
        end
    else

        if (vel.y < 0) then
            an.animation = pan.jump
        elseif (vel.y > 0) then
            an.animation = pan.fall
        end
    end

    an.flippedH = platforming.direction == "l" or false
end

return PlatformingAnimationSystem