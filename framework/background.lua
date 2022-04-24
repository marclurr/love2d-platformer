local Object = require("lib.classic")
local BackgroundLayer = Object:extend()

function BackgroundLayer:new(image, scale, y)
    if not repeatVertically then repeatVertically = false end
    self.image = image
    self.scale = scale
    self.y = y
end


function BackgroundLayer:draw(x)
    local w = self.image:getWidth()
    local h = self.image:getHeight()

    local bgPosX = (x * self.scale) / w
    local xOffset = bgPosX - math.floor(bgPosX)
    
    for i=0,1 do
        love.graphics.draw(self.image, (-xOffset+i) * w, self.y)
    end
end

return BackgroundLayer