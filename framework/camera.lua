local Object = require("lib.classic")
local vector = require("lib.hump.vector")
local Camera = Object:extend()

function Camera:new(w, h)
    self.pos = vector(0,0)
    self.width = w
    self.half_width = w / 2
    self.height = h
    self.half_height = h / 2
    self.min_x = -999999
    self.min_y = -999999
    self.max_x = 999999
    self.max_y = 999999
end

function Camera:attach()
    love.graphics.push()
    local tlx, tly = self:topLeft()
    love.graphics.translate(math.floor(-tlx), math.floor(-tly))
end

function Camera:detach()
    love.graphics.pop()
end

function Camera:topLeft()
    return self.pos.x - self.half_width, self.pos.y - self.half_height
end

function Camera:setPosition(newX, newY)
    self.pos.x = math.max(self.min_x + self.half_width, math.min(self.max_x - self.half_width, newX))
    self.pos.y = math.max(self.min_y + self.half_height, math.min(self.max_y - self.half_height, newY))
end

return Camera