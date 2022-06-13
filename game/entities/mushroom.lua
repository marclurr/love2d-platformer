local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Mushroom = Object:extend()
local g = anim8.newGrid(16, 16, assets.sprites.mushroom:getWidth(), assets.sprites.mushroom:getHeight())

function mushroomAI(e, dt)
    if (e.position and e.velocity and e.physics) then
        local pos = e.position
        local vel = e.velocity
        local phys = e.physics

        if (phys.onGround) then 
            -- if (phys.onWall) then 
            --     e.direction = e.direction * -1
            -- end

            local offset = 0
            if (e.direction > 0) then
                offset = e.hitbox.w
            end
            local x, y = game.tilemap:fromWorld(pos.x+offset, pos.y +18)
            local tile = game.tilemap:getTileFromWorld(pos.x+offset, pos.y + 18)
            if (tile.id == 0 or phys.onWall) then 
                e.direction = e.direction * -1
            end

            vel.x = e.direction * 32
        else
            vel.x = 0
        end
    end
end

local function physicsFilter(item, other)
    local tileDef = game.tilemap.tileset.tiles[other.id]
    if (other.tile and tileDef and tileDef.properties.solid) then 
        if (tileDef.properties.one_way) then
            if (item.position.y + item.hitbox.h > other.y) then
                return nil
            end
        end
        return "slide" 
    end
    if (other.collisionLayer and bit.band(other.collisionLayer, COLLISION_SOLID) ~= 0) then
        return "slide"
    end
    return "cross"
end

function Mushroom:new(initialX, initialY)
    self.animations = {
        walk = anim8.newAnimation(g("1-8", 1), 0.1),
        die = anim8.newAnimation(g("1-6", 3), 0.1, "pauseAtEnd")
    }
    
    self.animations.walk:gotoFrame(love.math.random(1, 8))
    
    self.collisionLayer = COLLISION_ACTORS

    self.name = "Mushroom"
    Components.position(self, initialX, initialY)
    Components.velocity(self)
    Components.hitbox(self, 10, 14)
    Components.physics(self, physicsFilter, true, false)
    Components.animatedSprite(self, assets.sprites.mushroom, self.animations.walk, 4, 2)
    Components.health(self, 3)
    Components.causesDamage(self, Damage.constant(1), Predicates.isPlayer)

    self.direction = -1
    Components.controller(self, mushroomAI)
end

function Mushroom:onAnimationComplete(animation)
    if (animation == self.animations.die) then
        game.registry:remove(self)
    end
end

function Mushroom:onHealthDepleted()
    self.sprite.animation = self.animations.die
    self.sprite.animation:reset()
    self.controller = nil
    self.physics = nil
    game.registry:add(self)
end

function Mushroom:draw()
    self.sprite.flippedH = self.velocity.x < 0
end

return function (layer, obj)
    return Mushroom(obj.x, obj.y)
end