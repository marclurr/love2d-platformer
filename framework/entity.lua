local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Entity = Object:extend()

function Entity:new()
    self.anim = nil
end

function Entity:playAnimation(newAnim, force)
    if (force or newAnim ~= self.anim) then
        self.anim = newAnim
        self.anim:reset()

    end
end

function Entity:updateAnimation(dt)
    self.anim.flippedH = self.flippedH
    self.anim:update(dt)
    if (self.anim.status == "paused") then
        self:animationComplete(self.anim)
    end

end

function Entity:animationComplete(anim)

end

return Entity