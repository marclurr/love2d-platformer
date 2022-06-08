local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local BasePickup = Object:extend()

function BasePickup:new(x, y, config)
    self.x = x 
    self.y = y 
    self.w = config.w
    self.h = config.h
    self.fn = config.fn

end

function BasePickup:onPickup()
    if (self.fn) then 
        self.fn()
    end
end

function BasePickup:update(dt)
    local col, len = game.world:queryRect(self.x , self.y, self.w  *2 , self.h *2, function(other)
        if (other == game.player) then
            return "cross"
        end
        return nil
    end)

    if (len > 0) then
        self:onPickup()
        self.isDestroyed = true
    end

end

function BasePickup:draw()
    -- love.graphics.circle("fill", self.x+self.w, self.y+self.w, self.w)
    love.graphics.rectangle("fill", self.x, self.y, self.w * 2, self.h * 2)
end

local pickups = {}
pickups.push_ability_pickup = {
    w = 4, h = 4, fn = function()
        game.player.abilities.push = true
    end

}

pickups.attack_ability_pickup = {
    w = 6, h = 6, fn = function()
        game.player.abilities.attack = true
    end
}

return function(layer, obj)
    if (pickups[obj.type]) then
        local o = BasePickup(obj.x, obj.y, pickups[obj.type])
        o.x = o.x + (o.w/2)
        o.y = o.y + (o.h/2)
        return o
    end
    print("Unrecognised pickup type [" .. obj.type .. "]")
    return nil
end