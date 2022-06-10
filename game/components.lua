local Object = require("lib.classic")
local Components = Object:extend()

Components.position = function(e, x, y)
    e.position = {}
    e.position.x = x or 0
    e.position.y = y or 0
end

Components.velocity = function(e, x, y)
    e.velocity = {}
    e.velocity.x = x or 0
    e.velocity.y = y or 0
end

Components.hitbox = function(e, w, h, isSolid)
    e.hitbox = {}
    e.hitbox.w = w
    e.hitbox.h = h
    e.isSolid = isSolid or true
end

Components.physics = function(e, filter)
    e.physics = {
        onGround = false,
        onWall = false,
        onOneWay = false, 
        filter = filter 
    }
end

Components.sprite = function(e, spritesheet, ox, oy)
    e.sprite = {
        spritesheet = spritesheet,
        ox = ox, oy = oy
    }
end

Components.animatedSprite = function(e, spritesheet, animation, ox, oy)
    e.sprite = {
        spritesheet = spritesheet,
        animation = animation,
        ox = ox, oy = oy
    }
end

Components.health = function(e, maxHealth, currentHealth)
    e.health = {
        owner = e,
        max = maxHealth,
        current = currentHealth or maxHealth
    }
end

Components.trigger = function(e, predicate)
    e.trigger = {
        overlappingObjs = {},
        filter = function(item, other)
            if (predicate(other)) then 
                return "cross"
            end
            return nil
        end
    }
end

Components.instaKill = function(e)
    e.instaKill = true
end

return Components