local flashShader = love.graphics.newShader([[
    vec4 effect(vec4 colour, Image tex, vec2 uv, vec2 xy) {
        return  Texel(tex, uv).a * colour;
    }
]])



local Object = require("lib.classic")
local anim8 = require("lib.anim8")

local Player = Object:extend()
local g = anim8.newGrid(16, 16, assets.sprites.hero:getWidth(), assets.sprites.hero:getHeight())
Player.animations = {
    idle = anim8.newAnimation(g("1-4", 6), 0.2),
    run = anim8.newAnimation(g("1-6", 2), 0.1),
    push = anim8.newAnimation(g("1-6", 3), 0.1),
    jump = anim8.newAnimation(g("1-3", 8), 0.2),
    fall = anim8.newAnimation(g("1-3", 7), 0.2), 
    hit = anim8.newAnimation(g("1-3", 9), 0.1), 
    attack = anim8.newAnimation(g("1-4", 4), 0.05, "pauseAtEnd"), 
    die = anim8.newAnimation(g("1-9", 1), 0.065, "pauseAtEnd")
}


local function physicsFilter(item, other)
    local tileDef = game.tilemap.tileset.tiles[other.id]
    if (other.tile and tileDef and tileDef.properties.solid) then 
        if (tileDef.properties.one_way) then
            if ((item.platforming and item.platforming.dropDown and item.platforming.dropDown > 0) or item.position.y + item.hitbox.h > other.y) then
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

function Player:new(initialX, initialY)
    self.id = 99999
    self.name = "Player"
    self.isPlayer = true
    self.collisionLayer = COLLISION_ACTORS
    Components.position(self, initialX, initialY)
    Components.velocity(self)
    Components.hitbox(self, 8, 12)
    Components.physics(self, physicsFilter)
    Components.animatedSprite(self, assets.sprites.hero, Player.animations.fall, 4, 4)
    Components.health(self, 3)
    
    local minJumpHeight = 0.65 * CELL_SIZE
    local maxJumpHeight = 3.3 * CELL_SIZE
    local jumpDuration = 0.4
    local gravity = (2 * maxJumpHeight) / (jumpDuration * jumpDuration)
    self.platforming = {
        runSpeed = 132,
        pushSpeed = 64,
        maxJumpVelocity = -math.sqrt(2 * gravity * maxJumpHeight),
        minJumpVelocity = -math.sqrt(2 * gravity * minJumpHeight),
        jumpDuration = jumpDuration,
        gravity = gravity,
        maxFallSpeed = 28 * CELL_SIZE, 
        dropDown = 0,
        jumpPressTime = 0, 
        disabled = 0, 
        jumping = false
    }

    self.platforming_animation = {
        idle = Player.animations.idle,
        run = Player.animations.run,
        push = Player.animations.push,
        jump = Player.animations.jump,
        fall = Player.animations.fall,
    }
    self.hit = 0
end

function Player:draw()
    self.hit = math.max(0, self.hit - love.timer.getDelta())
    if (self.hit > 0) then
        self.sprite.shader = flashShader
    else
        self.sprite.shader = nil
        if (self.health.invincible > 0) then 
             self.sprite.mod[4] = math.ceil(math.sin(self.health.invincible * 20)) * 1
        else 
            self.sprite.mod[4] = 1
        end
    end   
end

function Player:onAnimationComplete(animation)
    if (animation == Player.animations.die) then
        game.registry:remove(self)
    end
end

function Player:onHealthDepleted()
    self.sprite.animation = Player.animations.die
    self.sprite.animation:reset()
    self.platforming = nil
    self.physics = nil
    game.registry:add(self)
end

function Player:onDamageTaken(dealer, amount)
    if (self.health.current > 0) then
        local dir = 0
        if (dealer.position.x < self.position.x) then 
            dir = 1
        elseif (dealer.position.x >= self.position.x) then
            dir = -1
        end
        self.velocity.x = 80 * dir
        self.velocity.y = -128
        self.platforming.disabled = 0.2
        self.health.invincible = 2
        self.hit = 0.15
    end
    
end

return Player