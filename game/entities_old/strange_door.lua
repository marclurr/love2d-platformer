local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local StrangeDoor = Object:extend()


function StrangeDoor:new(x, y)
    self.x = x 
    self.y = y 
    self.w = 16
    self.h = 48
    self.doorCollider = {
        collisionLayer = COLLISION_SOLID,
        x = x + 3,
        y = y,
        w = self.w - 3,
        h = self.h

    }
    self.ref = ref
    self.open = false
    
    

    self.spritesheet = assets.sprites.strangeDoor

    local g = anim8.newGrid(16, 48, self.spritesheet:getWidth(), self.spritesheet:getHeight())

    self.closed = anim8.newAnimation(g("1-10", 1), 0.2, "pauseAtEnd")
    self.opening = anim8.newAnimation(g("1-14", 2), 0.2, "pauseAtEnd")
    self.closing = anim8.newAnimation(g("14-1", 2), 0.2, "pauseAtEnd")
    self.anim = self.closed

    
    self.waitTime = 0
end
function StrangeDoor:playAnimation(newAnim)
    if (newAnim ~= self.anim) then
        self.anim = newAnim
        self.anim:reset()

    end
end

function StrangeDoor:updateAnimation(dt)
    self.anim.flippedH = self.flippedH
    self.anim:update(dt)
    if (self.anim.status == "paused") then
        self:animationComplete(self.anim)
    end

end

function StrangeDoor:animationComplete(anim) 
    if (self.anim == self.opening) then
        self.open = true
    elseif (self.anim == self.closing) then
        self:playAnimation(self.closed)
        self.open = false
    elseif (self.anim == self.closed and self.anim.position ~= 1) then
        self.waitTime = love.math.random(1200, 2400) / 1000
        self.anim:gotoFrame(1)
    end
end

function StrangeDoor:beforeAdd()
    game.world:add(self.doorCollider, self.doorCollider.x, self.doorCollider.y, self.doorCollider.w, self.doorCollider.h)
end

function StrangeDoor:beforeRemove()
    game.world:remove(self.doorCollider)
end

function StrangeDoor:onSwitchActivated()
    local frame = 1
    if (self.anim == self.closing) then
        frame = 15 - self.anim.position
    end
    self:playAnimation(self.opening)
    self.anim:gotoFrame(frame)
end

function StrangeDoor:onSwitchDeactivated()
    local endFrame = self.anim.position
    self:playAnimation(self.closing)
    self.anim:gotoFrame(15 - endFrame)
end


function StrangeDoor:update(dt)

    if (self.anim == self.opening) then 
        local t = self.anim.timer / self.anim.totalDuration
        if (t >= 0.5) then
            self.doorCollider.collisionLayer = 0
        end
    elseif (self.anim == self.closing) then
        local t = self.anim.timer / self.anim.totalDuration
        if (t >= 0.5) then
            self.doorCollider.collisionLayer = COLLISION_SOLID
        end
    elseif (self.anim == self.closed) then
        self.waitTime = math.max(0, self.waitTime - dt)
        
        if (self.waitTime == 0 and self.anim.status == "paused") then
            self.anim:reset()
        end
    end
        
  
    self:updateAnimation(dt)
end

function StrangeDoor:draw()
    self.anim:draw(self.spritesheet, round(self.x), round(self.y))
end

return function(layer, obj)
    return StrangeDoor(obj.x, obj.y)
end