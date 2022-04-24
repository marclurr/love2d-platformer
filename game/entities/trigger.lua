local Object = require("lib.classic")
local Trigger = Object:extend()

-- TODO make this more general purpose (remove level inclination)
function Trigger:new(layer, obj)
    self.name = obj.name
    self.x = obj.x
    self.y = obj.y
    self.w = obj.width
    self.h = obj.height
    self.overlappingObjs = {}
    self.wasOverlapping = false
    self.noDebug = true
    local onEnterCallback = "onEnter_" .. self.name
    self.onEnter = function(obj) 
        local fn = game.currentLevel[onEnterCallback]
        if (fn) then
            fn(obj)
        end
    end

    local onExitCallback = "onExit_" .. self.name
    self.onExit = function(obj) 
        local fn = game.currentLevel[onExitCallback]
        if (fn) then
            fn(obj)
        end
    end
end

function Trigger:beforeAdd()
    self.manager.world:add(self, self.x, self.y, self.w, self.h)
end

function Trigger:update(dt)
    local _, _, cols, len = self.manager.world:check(self, self.x, self.y, function(a,b) 
        if (b == player) then
            return "cross"
        end
        return nil
    end)

    local colIds = {}
    for i=1,len do
        local obj = cols[i].other
        if (obj.id) then
            colIds[obj.id] = cols[i]
            if (self.overlappingObjs[obj.id] == nil) then
                self.overlappingObjs[obj.id] = obj
                self.onEnter(obj)
            end
        end
    end

    for i=1,#self.overlappingObjs do
        local obj = self.overlappingObjs[i]
        if (colIds[obj.id] == nil) then
            self.overlappingObjs[obj.id] = nil
            self.onExit(obj)
        end
    end
end

function Trigger:drawDebug()
    love.graphics.setColor(0, 0, 1, 0.6)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1,1,1,1)
end

return Trigger