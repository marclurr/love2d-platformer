local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Switch = Object:extend()
local g = anim8.newGrid(16, 4, assets.sprites.button:getWidth(), assets.sprites.button:getHeight())
Switch.animations = {
    off = anim8.newAnimation(g(1, 1), 0.01, "pauseAtEnd"),
    on = anim8.newAnimation(g(2, 1), 0.01, "pauseAtEnd"),
}

function Switch:new(x, y)
    self.name = "Switch"
    self.overlappingObjsCount =  0
    Components.position(self, x+3, y-1)
    Components.hitbox(self, 13, 4)
    Components.animatedSprite(self, assets.sprites.button, Switch.animations.off, 3, 0)
    Components.trigger(self, Predicates.isPhysicsObject)
end

function Switch:onTriggerEntered(obj)
    self.overlappingObjsCount = self.overlappingObjsCount + 1
    self.sprite.animation = Switch.animations.on
end

function Switch:onTriggerExited(obj)
    self.overlappingObjsCount = self.overlappingObjsCount - 1
    if (self.overlappingObjsCount == 0) then
        self.sprite.animation = Switch.animations.off
    end
end



return function(layer, obj) 
    local objects = {}

    table.insert(objects, invisibleCollider(obj.x+1, obj.y - 3, 15, 3))
    table.insert(objects, Switch(obj.x, obj.y - 3))
    return objects, #objects
end