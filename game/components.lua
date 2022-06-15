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

Components.physics = function(e, filter, affectedByGravity, pushable)
    e.physics = {
        onGround = false,
        onWall = false,
        onOneWay = false, 
        filter = filter,
        affectedByGravity = affectedByGravity or false,
        isPushable = pushable or false
    }
end

Components.sprite = function(e, spritesheet, ox, oy)
    e.sprite = {
        mod = {1, 1, 1, 1},
        spritesheet = spritesheet,
        ox = ox, oy = oy
    }
end

Components.animatedSprite = function(e, spritesheet, animation, ox, oy)
    e.sprite = {
        mod = {1, 1, 1, 1},
        spritesheet = spritesheet,
        animation = animation,
        ox = ox, oy = oy
    }
end

Components.animation = function(e, fn) 
    e.animation = {
        nextAnimation = fn
    }
end

Components.health = function(e, maxHealth, currentHealth)
    e.health = {
        owner = e,
        max = maxHealth,
        current = currentHealth or maxHealth,
        invincible = 0
    }
end

Components.trigger = function(e, predicate)
    predicate = predicate or Predicates.any
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

Components.causesDamage = function(e, damageFn, predicate, onHit, direction)
    predicate = predicate or Predicates.any
    e.causesDamage = {
        onHit = onHit,
        damageFn = damageFn,
        filter = function(item, other)
            if (other.health and predicate(other)) then 
                return "cross"
            end
            return nil
        end, 
        direction = direction
    }
end

Components.controller = function(e, controllerFn)
    e.controller = {
        logic = controllerFn
    }
end

Components.lifetime = function(e, t)
    e.lifetime = t
end

return Components