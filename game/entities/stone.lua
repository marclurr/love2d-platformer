local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Stone = Object:extend()

local g = 660

local function filter(l, other)
    local tileDef = game.tilemap.tileset.tiles[other.id]
    if (other.tile and tileDef and tileDef.properties.solid) then 
        if (tileDef.properties.one_way and l.y + l.h > other.y) then
            return nil
        end
        return "slide"
    elseif (other == player) then
        return "slide"
    elseif (other.collisionLayer and bit.band(other.collisionLayer, COLLISION_SOLID) ~= 0) then
        return "slide"
    end

    return nil
end

function Stone:new(x, y)
    self.x = x 
    self.y = y
    self.w = 14
    self.h = 15
    self.vx = 0
    self.vy = 0
    self.pushable = true
    self.collisionLayer = COLLISION_SOLID
    
    self.sprite = assets.sprites.stone
    self.debugLabel = "interactable"
end

function Stone:beforeAdd()
    self.manager.world:add(self, self.x, self.y, self.w, self.h)
end

function Stone:beforeRemove()
    self.manager.world:remove(self)
end

function Stone:move(vx, vy)
    local ax, ay, cols, len = self.manager.world:move(self, self.x + vx , self.y + vy, filter)
    self.x = ax
    self.y = ay
    return ax, ay, cols, len
end

function Stone:push(vx) 
    local collisionIterations = 1
    local maxIter = 0
    local finalX, finalY = self.x, self.y
    while collisionIterations > 0 and maxIter < 3 do
        collisionIterations = collisionIterations - 1
        maxIter = maxIter + 1

        local ax, ay, cols, len = self.manager.world:check(self, self.x + vx, self.y, filter)

        for i=1,len do
            local col = cols[i]
            if (col.normal.x ~= 0) then
                local o = cols[i].other
                        
                local yoff =(self.y + self.h) - o.y
            
                if (yoff  <= 3 and yoff > 0) then 
                    self.y = self.y - yoff
                    self.manager.world:update(self, self.x, self.y)
                    
                    collisionIterations = collisionIterations + 1
                end
            end

        end
      
        finalX = ax
        finalY = ay

        if (len == 0) then
         
        end
    end

    self.manager.world:update(self, finalX, finalY)
    self.x = finalX
    self.y = finalY
end

function Stone:onSwitchActivated()
    self.vy = -400
end



function Stone:update(dt)
    self.vy = self.vy + g * dt

    local vel = math.abs(self.vx)
    vel = vel - (dt * 256)
    if (vel < 0.1) then 
        vel = 0
    end

    if (self.vx < 0) then
        self.vx = -1 * vel
    else
        self.vx = vel
    end

    self.grounded = false
    local ax, ay, cols, len = self:move(0, self.vy * dt)

    for i=1,len do
        if (cols[i].normal.y == -1) then
            self.vy = 0
            self.grounded = true
        end

        if (cols[i].normal.x ~= 0) then
            self.vx = 0
        end
    end
end

function Stone:draw()
    love.graphics.draw(self.sprite, self.x-0.5, self.y-0.5)
end

return function(layer, obj)
    return Stone(obj.x, obj.y+1)
end