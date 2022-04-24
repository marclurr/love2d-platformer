local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Button = Object:extend()


function Button:new(x, y, ref)
    self.x = x 
    self.y = y + 1
    self.w = 16
    self.h = 3
    self.ref = ref
    self.activated = false
    self.sprite = assets.sprites.button
    self.collisionLayer = COLLISION_SOLID
    self.sprOff = love.graphics.newQuad(0, 0, 16, 4, self.sprite:getWidth(), self.sprite:getHeight())
    self.sprOn = love.graphics.newQuad(16, 0, 16, 4, self.sprite:getWidth(), self.sprite:getHeight())
    self.frame = self.sprOff
    
end

function Button:beforeAdd()
    
    self.manager.world:add(self, self.x + 3, self.y, self.w - 3, self.h)
    if (self.ref) then
        for _, entity in ipairs(self.manager.entities) do
            
            if (entity.refId == self.ref) then
                self.objectUnderControl = entity
            end
        end
        if (self.objectUnderControl == nil) then
            print(string.format("[%s] Button unable to find referenced object [%s], check entity insertion order", self.refId, self.ref))
        end
    end
end

function Button:beforeRemove()
    self.manager.world:remove(self)
end

function Button:update(dt)
    local col, len = self.manager.world:queryRect(self.x + 3, self.y-1, self.w - 3, 4, function(other)
        if (other == self ) then return nil end
        if (other == player or (other.collisionLayer and bit.band(other.collisionLayer, COLLISION_SOLID) ~= 0)) then
            return "cross"
        end
        return nil
    end)

    local wasActivated = self.activated
    self.activated = false

    for i=1,len do
        if (col[i] ~= self) then
          self.activated = true
        end
    end

    if (self.activated) then
        self.frame =  self.sprOn
        if (not wasActivated) then 
            if (self.objectUnderControl and self.objectUnderControl.onSwitchActivated) then
                self.objectUnderControl:onSwitchActivated()
            end
        end

    else
        self.frame = self.sprOff
        if (wasActivated) then
            if (self.objectUnderControl and self.objectUnderControl.onSwitchDeactivated) then
                self.objectUnderControl:onSwitchDeactivated()
            end
        end
    end
end

function Button:draw()

    love.graphics.draw(self.sprite, self.frame, self.x, self.y-1)
end

return function(layer, obj)
    local refId = nil
    if (obj.properties.ref) then
        refId = obj.properties.ref.id
    end
    return Button(obj.x, obj.y-3, refId)
end